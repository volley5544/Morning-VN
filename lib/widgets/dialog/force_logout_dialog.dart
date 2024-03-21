import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../connector/firestore/notify.dart';
import '../../services/localStorage/local_storage.dart';
import '../../connector/authentication/login_function.dart';
import '../../util/logger_service.dart';

LocalStoragePrefernces localStoragePrefernces = LocalStoragePrefernces();

class ForceLogoutBtn extends StatefulWidget {
  final BuildContext logoutContext;
  final BuildContext mainContext;

  const ForceLogoutBtn(
      {Key? key, required this.logoutContext, required this.mainContext})
      : super(key: key);

  @override
  State<ForceLogoutBtn> createState() => _ForceLogoutBtn();
}

class _ForceLogoutBtn extends State<ForceLogoutBtn> {
  bool isLogoutLoading = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          onTap: () async {
            if (isLogoutLoading) {
              logger.i('Logout dialog clicked!');
              return;
            }
            setState(() {
              isLogoutLoading = true;
            });
            FirebaseAnalytics.instance.logEvent(
              name: 'logout',
              parameters: {},
            );
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
            } catch (e) {}
            await removePinLocalStorage();
            await LoginFunction.signOut();
            // await notiClient.setFcmToken('');

            if (FirebaseAuth.instance.currentUser == null) {
              hashThaiId = '';
              // widget.mainContext
              //     .read<PageResultBloc>()
              //     .add(SetCurrentNavBarIndex(0));
              BlocProvider.of<UserProfileBloc>(widget.mainContext)
                  .add(ResetUserProfile());
              BlocProvider.of<LoanBloc>(widget.mainContext)
                  .add(ResetLoanState());
              BlocProvider.of<TopupBloc>(widget.mainContext)
                  .add(ResetTopupState());
              BlocProvider.of<UserTokenBloc>(widget.mainContext)
                  .add(ResetSigninProfile());
              localStoragePrefernces.removeLocalStorage('phoneNumber');
              localStoragePrefernces.removeLocalStorage('userId');
              localStoragePrefernces.removeLocalStorage('userToken');
              localStoragePrefernces.removeLocalStorage('userLocation');
              BlocProvider.of<PageResultBloc>(widget.mainContext)
                  .add(SetButtonNavigator(false));
              Navigator.of(widget.logoutContext).pop('dialog');
              Navigator.of(widget.mainContext).pushNamedAndRemoveUntil(
                '/login-page',
                (route) => false,
              );
            }
            setState(() {
              isLogoutLoading = false;
            });
          },
          child: isLogoutLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(219, 119, 26, 1),
                  ),
                )
              : Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(widget.mainContext).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                  ),
                  child: Center(
                    child: Text("ปิด",
                        textAlign: TextAlign.center,
                        style: Theme.of(widget.mainContext)
                            .textTheme
                            .labelSmall
                            ?.merge(TextStyle(
                                letterSpacing: 0,
                                fontFamily: 'NotoSansThaiSemiBold'))),
                  ),
                ),
        ));
  }
}

showForceLogOutDialog(BuildContext context) {
  showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext logoutContext) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.only(top: 22, right: 20, left: 20, bottom: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'กรุณาเข้าสู่ระบบใหม่',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                    const TextStyle(
                        letterSpacing: -0.1,
                        fontFamily: 'NotoSansThaiSemiBold')),
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                'assets/error-icon.svg',
                width: 56,
                height: 56,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'บัญชีของคุณถูกเข้าสู่ระบบด้วยเครื่องอื่น\nกรุณาเข้าสู่ระบบใหม่อีกครั้ง',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.merge(TextStyle(
                    color: Theme.of(context).colorScheme.tertiaryContainer)),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  ForceLogoutBtn(
                    logoutContext: logoutContext,
                    mainContext: context,
                  )
                ],
              )
            ],
          ),
        );
      });
}
