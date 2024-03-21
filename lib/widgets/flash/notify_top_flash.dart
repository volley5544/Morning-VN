import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'top_flash.dart';

void showNotifyTopFlash({
  required String title,
  required String body,
  required BuildContext context,
}) {
  final Widget contents = FlashBar(
    icon: Container(
      // color: Colors.yellow,
      padding: EdgeInsets.fromLTRB(14, 0, 16, 10),
      child: SvgPicture.asset('assets/notify-icon.svg'),
    ),
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.merge(TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
        Text(
          body,
          style: TextStyle(
            fontFamily: 'NotoSansThai',
            // height: 1.51071429,
            // letterSpacing: 0.3,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(100, 100, 100, 1),
          ),
        ),
      ],
    ),
    showProgressIndicator: false,
  );
  showTopFlash(
      contents: contents,
      context: context,
      margin: EdgeInsets.fromLTRB(5, 10, 5, 10));
}
