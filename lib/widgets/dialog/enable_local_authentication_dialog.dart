import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application_srisawad/util/authentication_type.dart';

import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

enableLocalAuthenticationDialog(BuildContext context,
    AuthenticationType authenticationType, Function(bool) onClickEnableButton) {
  showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTitle(authenticationType),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                    const TextStyle(
                        letterSpacing: -0.1,
                        fontFamily: 'NotoSansThaiSemiBold')),
              ),
              SizedBox(height: 26),
              getIcon(authenticationType),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  getDescription(authenticationType),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                        textButton: 'ยกเลิก',
                        CallBack: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          onClickEnableButton.call(false);
                        }),
                  ),
                  Expanded(
                    child: PrimaryButton(
                        textButton: 'เปิดใช้งาน',
                        CallBack: () async {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                          onClickEnableButton.call(true);
                        }),
                  )
                ],
              ),
            ],
          ),
        );
      });
}

String getDescription(AuthenticationType authenticationType) {
  switch (authenticationType) {
    case AuthenticationType.Touch:
      return "เปิดใช้งานสแกนลายนิ้วมือเพื่อความสะดวก ในการเข้าใช้งานครั้งถัดไป";
    case AuthenticationType.Face:
      return "เปิดใช้งานสแกนใบหน้าเพื่อความสะดวก ในการเข้าใช้งานครั้งถัดไป";
    case AuthenticationType.FaceAndTouch:
      return "เปิดใช้งานสแกนใบหน้าหรือสแกนลายนิ้วมือ เพื่อความสะดวกในการเข้าใช้งานครั้งถัดไป";
    default:
      return "";
  }
}

Widget getIcon(AuthenticationType authenticationType) {
  var logo;
  switch (authenticationType) {
    case AuthenticationType.Touch:
      logo = SvgPicture.asset('assets/fingerprint-icon.svg', width: 48);
      break;
    case AuthenticationType.Face:
      logo = SvgPicture.asset('assets/face-id-icon.svg', width: 48);
      break;
    case AuthenticationType.FaceAndTouch:
      logo = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.asset('assets/fingerprint-icon.svg', width: 48),
        SizedBox(
          width: 52,
        ),
        SvgPicture.asset('assets/face-id-icon.svg', width: 48)
      ]);
      break;
    default:
      logo = SizedBox();
  }
  return logo;
}

String getTitle(AuthenticationType authenticationType) {
  switch (authenticationType) {
    case AuthenticationType.Touch:
      return "ต้องการเปิดการใช้งานสแกนลายนิ้วมือ\nหรือไม่?";
    case AuthenticationType.Face:
      return "ต้องการเปิดการใช้งานสแกนใบหน้า\nหรือไม่?";
    case AuthenticationType.FaceAndTouch:
      return "ต้องการเปิดการใช้งานไบโอเมตริกซ์\nหรือไม่?";
    default:
      return "";
  }
}
