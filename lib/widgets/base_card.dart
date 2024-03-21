import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';

class BaseCard extends StatelessWidget {
  final Widget content;
  final Widget buttomContent;
  final double? width;
  final bool? hasBorder;
  final Function? onTap;
  const BaseCard(
      {required this.content,
      required this.buttomContent,
      this.width,
      this.hasBorder,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width ?? getActualWidth(context) * 0.9,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: hasBorder != null
              ? Border.all(
                  color: HexColor('#E5E5E5'),
                  width: 1,
                )
              : Border(),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.16),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (this.onTap != null) {
                this.onTap!();
              }
            },
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.white.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[content, buttomContent],
            ),
          ),
        ));
    // );
  }
}
