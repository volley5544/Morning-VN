import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

import '../util/color_util.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key, required this.onRetry}) : super(key: key);
  final Function onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            // color: Colors.black,
            'assets/Station.svg',
            height: 58,
            width: 58,
          ),
          SizedBox(
            height: 14,
          ),
          MainDescription(
                  "ไม่มีการเชื่อมต่ออินเทอร์เน็ต\nโปรดเชื่อมต่อและลองใหม่อีกครั้ง",
                  TextAlign.center)
              .styleLightGrey(),
          SizedBox(
            height: 24,
          ),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 42)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                              color: HexColor(ColorUtil.SECONDARY))))),
              onPressed: () => onRetry.call(),
              child: MainDescription("ลองอีกครั้ง").styleSecondary()),
        ],
      ),
    );
  }
}
