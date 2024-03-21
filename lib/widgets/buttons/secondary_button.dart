import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SecondaryButton extends StatelessWidget {
  final String textButton;
  // ignore: non_constant_identifier_names
  final Function CallBack;
  late double width;
  late double height;
  late EdgeInsetsGeometry padding;
  late double raduis;

  SecondaryButton(
      {super.key,
      required this.textButton,
      required this.CallBack,
      this.width = 134,
      this.height = 60,
      this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
      this.raduis = 14});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.zero,
      padding: padding,
      child: GestureDetector(
        onTap: () => CallBack(),
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.all(Radius.circular(raduis)),
            ),
            child: Center(
                child: Text(textButton,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium?.merge(
                        TextStyle(
                            letterSpacing: 0,
                            fontFamily: 'NotoSansThaiSemiBold'))))),
      ),
    );
  }
}
