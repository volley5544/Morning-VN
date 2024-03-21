import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../connector/firestore/notify.dart';
import '../../services/localStorage/local_storage.dart';
import '../../util/logger_service.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import '../../connector/authentication/login_function.dart';
import 'base_dialog.dart';

// Navigator.of(context).restorablePush(ocrNotFoundDialog(context));
LocalStoragePrefernces localStoragePrefernces = LocalStoragePrefernces();
logOutPop(BuildContext context) {
  baseDialog1(
      context: context,
      title: 'ออกจากระบบ',
      content: Text(
        'คุณต้องการออกจาก\nแอปพลิเคชัน ศรีสวัสดิ์ ใช่หรือไม่?',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium?.merge(
            TextStyle(color: Theme.of(context).colorScheme.tertiaryContainer)),
      ),
      Buttons: [
        Expanded(
          child: SecondaryButton(
            textButton: 'ยกเลิก',
            CallBack: () =>
                Navigator.of(context, rootNavigator: true).pop('dialog'),
          ),
        ),
        Expanded(
          child: PrimaryButton(
              textButton: 'ยืนยัน',
              CallBack: () async {
                Navigator.of(context, rootNavigator: true).pop('dialog');
                FirebaseAnalytics.instance.logEvent(
                  name: 'logout',
                  parameters: {},
                );
                final notiClient = NotifyConnector(hashThaiId);
                try {
                  if (MessagingListenerList.isNotEmpty)
                    MessagingListenerList[0].cancel();
                  MessagingListenerList.clear();
                  if (MessagingOnOpenedAppListenerList.isNotEmpty)
                    MessagingOnOpenedAppListenerList[0].cancel();
                  MessagingOnOpenedAppListenerList.clear();
                  if (MessagingOnRefreshTokenListenerList.isNotEmpty)
                    MessagingOnRefreshTokenListenerList[0].cancel();
                  MessagingOnRefreshTokenListenerList.clear();
                } catch (e) {
                  logger.e('Logout error ${e}');
                }
                // userId, phonenumber, userLocation, userToken
                // backup_pin, pin
                await removePinLocalStorage();
                await notiClient.setFcmToken('');
                await LoginFunction.signOut();
                if (FirebaseAuth.instance.currentUser == null) {
                  hashThaiId = '';
                  BlocProvider.of<UserProfileBloc>(context)
                      .add(ResetUserProfile());
                  BlocProvider.of<LoanBloc>(context).add(ResetLoanState());
                  BlocProvider.of<TopupBloc>(context).add(ResetTopupState());
                  BlocProvider.of<UserTokenBloc>(context)
                      .add(ResetSigninProfile());
                  localStoragePrefernces.removeLocalStorage('phoneNumber');
                  // localStoragePrefernces.removeLocalStorage('userToken');
                  localStoragePrefernces.removeLocalStorage('userId');
                  localStoragePrefernces.removeLocalStorage('userToken');
                  localStoragePrefernces.removeLocalStorage('userLocation');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/intro-page',
                    (route) => false,
                  );
                  BlocProvider.of<PageResultBloc>(context)
                      .add(SetButtonNavigator(false));
                  // context.read<PageResultBloc>().add(SetCurrentNavBarIndex(0));
                }
              }),
        )
      ]);
}
