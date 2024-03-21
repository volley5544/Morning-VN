import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/width_until.dart';
import '../topup_styling.dart';

class UploadVehicleImage extends StatelessWidget {
  final Function onButtonTap;
  const UploadVehicleImage({Key? key, required this.onButtonTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => this.onButtonTap(),
            child: Container(
              width: widthAdjuster(
                  screenWidth: widthAdjuster(
                      screenWidth: MediaQuery.of(context).size.width),
                  widthMod: 0.87),
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                color: Color.fromRGBO(232, 243, 251, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 8, 15),
                      child: SvgPicture.asset('assets/CameraIcon.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('อัปโหลดรูปภาพ',
                          style: size16CBlue.merge(TextStyle(
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'NotoSansThaiMedium'))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
