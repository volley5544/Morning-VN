import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '_dialog_flash.dart';
import 'top_flash.dart';

void serverSuspended(
    {required String title,
    required String body,
    required BuildContext context,
    required String buttonText}) {
  final Widget contents = FlashBar(
    content: Column(
      children: [
        Image.asset(
          'assets/ServerSuspended.png',
          width: 206,
          height: 164,
        ),
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.merge(TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        Align(
          alignment: Alignment.center,
          child: Text(
            body,
            style: TextStyle(
              fontFamily: 'NotoSansThai',
              height: 1.51071429,
              letterSpacing: 0.3,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(100, 100, 100, 1),
            ),
          ),
        ),
      ],
    ),
    showProgressIndicator: false,
  );
  showDialogFlash(
      content: contents,
      context: context,
      title: title,
      buttonText: buttonText);
}

void flashNoResultFound(
    {required String title,
    required String body,
    required BuildContext context,
    required String buttonText}) {
  final Widget contents = FlashBar(
    padding: EdgeInsets.only(top: 10),
    content: Column(
      children: [
        SvgPicture.asset('assets/notFoundIcon.svg'),
        Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text('ไม่พบการค้นหา',
                style: GoogleFonts.notoSansThai(
                    fontSize: 16, fontWeight: FontWeight.w600))
            // Theme.of(context).textTheme.titleMedium?.merge(
            //     TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            ),
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              body,
              style: TextStyle(
                fontFamily: 'NotoSansThai',
                height: 1.51071429,
                letterSpacing: 0.3,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(100, 100, 100, 1),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: Container(
            decoration: BoxDecoration(
              color: HexColor('#DB771A'),
              borderRadius: const BorderRadius.all(Radius.circular(14)),
            ),
            width: 300,
            height: 60,
            child: Center(
              child: Text(buttonText,
                  style: GoogleFonts.notoSansThai(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#FFFFFF'))),
            ),
          ),
        ),
      ],
    ),
    showProgressIndicator: false,
  );
  noResultDialogFlash(
    content: contents,
    context: context,
    title: title,
  );
}

void onCloseTap(BuildContext context, FlashController<dynamic> controller,
    void Function(void Function()) setState) {
  controller.dismiss();
}
