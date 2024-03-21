import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/user_profile_data.dart';
import 'package:mobile_application_srisawad/modules/userProfile/index.dart';
import 'package:mobile_application_srisawad/services/display_image.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';
import 'package:mobile_application_srisawad/widgets/flash/top_flash.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

DateTime? userProfileTimer;

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc()
      : super(UserProfileLoading(
            userProfileData: UserProfileData(
              isExistingCustomer: false,
              thaiId: '',
              title: '',
              firstName: '',
              lastName: '',
              phoneNumber: '',
              dob: '',
              email: '',
              addressDetails: '',
              addressSubDistrict: '',
              addressDistinct: '',
              addressProvince: '',
              addressPostalCode: '',
              lineId: '',
              code: '',
              message: '',
            ),
            imageFile: Uint8List(0))) {
    on<ResetUserProfile>(
      (event, emit) {
        state.userProfileData = UserProfileData(
          isExistingCustomer: false,
          thaiId: '',
          title: '',
          firstName: '',
          lastName: '',
          phoneNumber: '',
          dob: '',
          email: '',
          addressDetails: '',
          addressSubDistrict: '',
          addressDistinct: '',
          addressProvince: '',
          addressPostalCode: '',
          lineId: '',
          code: '',
          message: '',
        );
      },
    );
    on<GetUserProFileData>((event, emit) async {
      try {
        if (userProfileTimer == null) {
          userProfileTimer = DateTime.now();
        }
        if (state.userProfileData.firstName == '') {
          userProfileTimer = DateTime.now();
          emit(UserProfileLoading(
              userProfileData: state.userProfileData,
              imageFile: state.imageFile));
          UserProfileData userData =
              await event.userProfile.getUserProfile(event.id, true);

          emit(UserProfileComplete(
              userProfileData: userData, imageFile: state.imageFile));
        } else if (DateTime.now().minute > userProfileTimer!.minute + 5) {
          userProfileTimer = DateTime.now();
          emit(UserProfileLoading(
              userProfileData: state.userProfileData,
              imageFile: state.imageFile));
          UserProfileData userData =
              await event.userProfile.getUserProfile(event.id, true);
          emit(UserProfileComplete(
              userProfileData: userData, imageFile: state.imageFile));
        }
      } on RESTApiException catch (e) {
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
        emit(UserProfileError(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
      } catch (e) {
        emit(UserProfileError(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
      }
    });
    on<UpdateUserProfile>((event, emit) async {
      try {
        emit(UserProfileLoading(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
        await event.userProfile.updateUserProfile(
            email: event.email, lineId: event.lineId, id: event.id);
        UserProfileData userData =
            await event.userProfile.getUserProfile(event.id, true);
        emit(UserProfileComplete(
            userProfileData: userData, imageFile: state.imageFile));
        showTopFlash(
            margin: EdgeInsets.symmetric(horizontal: 22),
            duration: 2,
            barrierColor: Colors.transparent,
            contents: Container(
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.8),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                  child: Container(
                      child: Row(children: [
                    SvgPicture.asset('assets/SuccessSnackIcon.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'บันทึกข้อมูลสำเร็จ',
                      style: Theme.of(navKey.currentContext as BuildContext)
                          .textTheme
                          .labelSmall
                          ?.merge(TextStyle(
                            fontWeight: FontWeight.w400,
                            // fontFamily:
                            //     'NotoSansThaiSemiBold'
                          )),
                    )
                  ]))),
            ),
            context: navKey.currentContext as BuildContext);
      } on RESTApiException catch (e) {
        serverSuspendedDialog(navKey.currentContext ?? event.context,
            additionalText: e.cause.toString());
        emit(UserProfileComplete(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
      } catch (e) {
        emit(UserProfileComplete(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
        serverSuspendedDialog(navKey.currentContext ?? event.context);
      }
    });
    on<SetDisplayImage>((event, emit) async {
      try {
        // await dotenv.load(fileName: ".env");
        emit(UserProfilePhotoLoading(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
        StorageConnector storageConnector = StorageConnector();
        Displayimage displayimage = Displayimage();
        final IMAGE_LOCATION = dotenv.env['IMAGE_LOCATION'];
        String mockPath1 = '${IMAGE_LOCATION}';
        String mockPath2 = '/display_image.jpg';
        // File imageFile;
        try {
          await displayimage.uploadDisplayImage(event.capturedPhoto!);
        } catch (e) {
          logger.e('forming file fail: $e');
          throw Exception();
        }
        var user = await FirebaseAuth.instance.currentUser;
        await user!.getIdTokenResult();
        String userId = user.uid;

        Uint8List fetchedImage = await storageConnector
            .downloadToMemory(mockPath1 + userId + mockPath2);
        state.imageFile = Uint8List(0);
        emit(UserProfileUpdatePhotoComplete(
            userProfileData: state.userProfileData, imageFile: fetchedImage));
        emit(UserProfileComplete(
            userProfileData: state.userProfileData, imageFile: fetchedImage));
      } catch (e) {
        serverSuspendedDialog(navKey.currentContext ?? event.inputContext);
        emit(UserProfileComplete(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
      }
    });
    on<SetDisplayImageFromHome>((event, emit) async {
      emit(UserProfileImageLoading(
          userProfileData: state.userProfileData, imageFile: state.imageFile));
      state.imageFile = event.imageFile;
      emit(UserProfileImageComplete(
          userProfileData: state.userProfileData, imageFile: event.imageFile));
    });

    on<UpdateProfile>((event, emit) async {
      try {
        emit(UserProfileLoading(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
        await event.userProfile.updateProfile(
            firstName: event.firstName,
            lastName: event.lastName,
            id: event.id,
            phone: event.phone,
            dob: event.dob,
            address: event.address,
            province: event.province,
            district: event.district,
            subdistrict: event.subdistrict,
            postal: event.postal);
        UserProfileData userData =
            await event.userProfile.getUserProfile(event.id, false);
        emit(UserProfileComplete(
            userProfileData: userData, imageFile: state.imageFile));
        showTopFlash(
            margin: EdgeInsets.symmetric(horizontal: 22),
            duration: 2,
            barrierColor: Colors.transparent,
            contents: Container(
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.8),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                  child: Container(
                      child: Row(children: [
                    SvgPicture.asset('assets/SuccessSnackIcon.svg'),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'บันทึกข้อมูลสำเร็จ',
                      style: Theme.of(navKey.currentContext as BuildContext)
                          .textTheme
                          .labelSmall
                          ?.merge(TextStyle(
                            fontWeight: FontWeight.w400,
                            // fontFamily:
                            //     'NotoSansThaiSemiBold'
                          )),
                    )
                  ]))),
            ),
            context: navKey.currentContext as BuildContext);
      } on RESTApiException catch (e) {
        serverSuspendedDialog(navKey.currentContext ?? event.context,
            additionalText: e.cause.toString());
        emit(UserProfileComplete(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
      } catch (e) {
        emit(UserProfileComplete(
            userProfileData: state.userProfileData,
            imageFile: state.imageFile));
        serverSuspendedDialog(navKey.currentContext ?? event.context);
      }
    });
  }
}
