import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String textButton;
  final Function CallBack;
  late double width;
  late double height;
  late EdgeInsetsGeometry padding;

  PrimaryButton(
      {super.key,
      required this.textButton,
      required this.CallBack,
      this.width = 125,
      this.height = 60,
      this.padding = const EdgeInsets.fromLTRB(10, 0, 0, 0)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () => CallBack(),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(14)),
          ),
          child: Center(
            child: Text(textButton,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall?.merge(TextStyle(
                    letterSpacing: 0, fontFamily: 'NotoSansThaiSemiBold'))),
          ),
        ),
      ),
    );
  }
}
