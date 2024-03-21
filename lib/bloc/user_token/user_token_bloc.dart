import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/connector/authentication/login_function.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';
import 'package:mobile_application_srisawad/models/register.dart';
import 'package:mobile_application_srisawad/models/token_user.dart';
import 'package:mobile_application_srisawad/modules/authLogin/index.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/modules/userProfile/index.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as localStorage;
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/services/notification.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import '../../modules/auth/auth_active_device.dart';
import '../../modules/authRegister/index.dart';
import '../../widgets/dialog/login_error.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';
import '../../connector/firestore/notify.dart';
import '../../main.dart';
import '../register_bloc/register_bloc.dart';

part 'user_token_event.dart';
part 'user_token_state.dart';

class UserTokenBloc extends Bloc<UserTokenEvent, UserTokenState> {
  UserTokenBloc()
      : super(UserTokenInitial(
            UserToken(
                token: '',
                firebaseToken: '',
                data: DataToken(firstName: 'firstname', lastName: 'lastname')),
            RegisterVerfiy(
                isExistingCustomer: false, status: '', phoneNumber: ''),
            '')) {
    on<ResetSigninProfile>((event, emit) async {
      emit(SignInResetComplete(
          UserToken(
              token: '',
              firebaseToken: '',
              data: DataToken(firstName: 'firstname', lastName: 'lastname')),
          RegisterVerfiy(
              isExistingCustomer: false, status: '', phoneNumber: ''),
          ''));
    });
    on<BSignin>((event, emit) async {
      try {
        emit(SignInLoading(state.userToken, state.registerVerfiy,
            state.phoneNumber.toString()));
        emit(SignInComplete(state.userToken, event.registerVerfiy,
            event.phoneNumber.toString()));
      } catch (e) {
        logger.e('Error: $e');
        emit(SignInError(
            state.userToken, event.registerVerfiy, state.phoneNumber));
      }
    });
    on<LoginUserToTheSysytem>(
      (event, emit) async {
        try {
          var localStorageObject = localStorage.LocalStoragePrefernces();
          StorageConnector storageConnector = StorageConnector();
          emit(LoginLoading(
              state.userToken, state.registerVerfiy, state.phoneNumber));

          await dotenv.load(fileName: ".env");
          Uint8List fetchedImage;
          String mockPath1 = '${dotenv.env['IMAGE_LOCATION']}';
          String mockPath2 = '/display_image.jpg';
          String userId = '';

          final firebaseToken =
              await UserLogin.getUserToken(event.thaiId, event.phoneNumber);
          if (['401', '404'].contains(firebaseToken)) {
            logger.w('Got Client 40X error code.');
            loginWithErrorDialog(event.context);
            emit(LoginError(
                state.userToken, state.registerVerfiy, state.phoneNumber));
          } else if (['500', '501', '502', '509'].contains(firebaseToken)) {
            logger.w('Got Internal server 50X error code.');
            emit(LoginError(
                state.userToken, state.registerVerfiy, event.phoneNumber));
            serverSuspendedDialog(event.context);
          } else {
            otpCallbackFunction() async {
              final value = await LoginFunction.signIn(firebaseToken);
              final user = await FirebaseAuth.instance.currentUser;
              var authaug = AuthRegister();
              RegisterVerfiy result = await authaug.verfiyUser(
                event.thaiId,
                event.phoneNumber,
              );
              result.isExistingCustomer == true
                  ? event.context.read<RegisterBloc>().state.isValidated = true
                  : event.context.read<RegisterBloc>().state.isValidated =
                      false;
              logger.d('user ID: >>>$value');
              await user!.getIdTokenResult();
              userId = user.uid;
              hashThaiId = userId;
              localStorageObject.setLocalStorage('userToken', value, 'string');
              localStorageObject.setLocalStorage(
                  'phoneNumber', event.phoneNumber, 'string');
              localStorageObject.setLocalStorage(
                  'userId', event.thaiId, 'string');
              // Handle FCM token to firestore
              final notiClient = NotifyConnector(userId);
              final fcmToken = await FirebaseMessaging.instance.getToken();

              logger.e("callActiveDevice");
              var service = AuthActiveDevice();
              try {
                logger.i('try to rest active device with   ${fcmToken}');
                await service.activeDevice(hashThaiId, fcmToken ?? "");
              } catch (e) {
                logger.e("callActiveDevice error");
              }
              notiClient.setFcmToken(fcmToken as String);
              createOnTokenRefreshListener(userId);
              createNotificationReciever(userId);
              fetchedImage = await storageConnector
                  .downloadToMemory(mockPath1 + userId + mockPath2);
              BlocProvider.of<UserProfileBloc>(event.context).add(
                  SetDisplayImageFromHome(
                      userProfile: event.userProfile,
                      imagePath: mockPath1 + userId + mockPath2,
                      imageFile: fetchedImage));
              BlocProvider.of<UserProfileBloc>(event.context).add(
                  GetUserProFileData(
                      event.userProfile, hashThaiId, event.context));
              late String existingPin = '';
              final bool _isValidPin = await isVaildPin();
              if (_isValidPin) {
                existingPin = (await getPin()).pin;
              } else {
                final backupPin = await getBackupPin(userId);
                if (backupPin.pin != 'null') {
                  existingPin = backupPin.pin;
                }
              }
              Navigator.pushNamed(event.context, '/pin-page', arguments: {
                'existingPin': existingPin,
                'hashThaiId': userId,
                'phoneNumber': event.phoneNumber,
                'isRegister': false
              });
            }

            emit(LoginComplete(
                state.userToken, state.registerVerfiy, event.phoneNumber));
            Navigator.pushNamed(event.context, '/otp-page', arguments: {
              'callbackFunction': await otpCallbackFunction,
              'phoneNumber': event.phoneNumber,
            });
          }
        } on RESTApiException catch (e) {
          logger.e(
              'LoginUserToTheSysytem bloc error(RESTApiException) :${e.cause.toString()} ');
          emit(LoginError(
              state.userToken, state.registerVerfiy, state.phoneNumber));
          Navigator.of(event.context).pop();
          serverSuspendedDialog(event.context,
              additionalText: e.cause.toString());
          emit(LoginComplete(
              state.userToken, state.registerVerfiy, state.phoneNumber));
        } catch (_, stack) {
          logger.e('LoginUserToTheSysytem: Exception: ' + _.toString());
          logger.e('LoginUserToTheSysytem: Stacktrace: ' + stack.toString());
          emit(LoginError(
              state.userToken, state.registerVerfiy, state.phoneNumber));
          serverSuspendedDialog(event.context);
          emit(LoginComplete(
              state.userToken, state.registerVerfiy, state.phoneNumber));
        }
      },
    );
  }
}
