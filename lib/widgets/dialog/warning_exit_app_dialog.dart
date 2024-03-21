import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../services/localStorage/pin_local_storage.dart';
import '../text_compent.dart';

Future showWarningExitAppDialog(BuildContext context) {
 return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        contentPadding:
        EdgeInsets.only(top: 22, right: 20, left: 20, bottom: 12),
        content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextTitle(
                    "แจ้งเตือน",
                    TextAlign.center)
                    .styleSecondary(),
                SizedBox(
                  height: 9,
                ),
                Body('คุณต้องการออกจากระบบและปิดแอพ หรือไม่',
                    TextAlign.center)
                    .styleLightGrey(),
                SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: HexColor('#FCEFE4'),
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 18),
                            child: Center(
                              child: Text(
                                "ยกเลิก",
                                style: GoogleFonts.notoSansThai(
                                    color: HexColor('#DB771A'),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () async {
                          exitApp();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                              color: HexColor('#DB771A'),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'ตกลง',
                              style: GoogleFonts.notoSansThai(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ));
}

Future<void> exitApp() async {
  FirebaseAnalytics.instance.logEvent(
    name: 'logout',
    parameters: {},
  );
  await removePinLocalStorage();
  if (Platform.isIOS) {
    exit(0);
  } else {
    SystemNavigator.pop();
  }
}
