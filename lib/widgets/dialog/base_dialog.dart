import 'package:flutter/material.dart';

dynamic onClose() {}
baseDialog1(
    {required BuildContext context,
    Widget? imageWidget,
    required String title,
    // ignore: non_constant_identifier_names
    required Widget content,
    // ignore: non_constant_identifier_names
    List<Widget> Buttons = const [],
    Function() onCloseFn = onClose,
    EdgeInsetsGeometry inputPadding =
        const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 10)}) {
  showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: inputPadding,
          alignment: Alignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              imageWidget ?? const SizedBox(),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.merge(
                      const TextStyle(
                          letterSpacing: -0.1,
                          fontFamily: 'NotoSansThaiSemiBold')),
                ),
              ),
              content,
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: MediaQuery.of(context).viewInsets * 1.2,
                //  const EdgeInsets.fromLTRB(0, 0, 0, 16),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[...Buttons]),
              )
            ],
          ),
        );
      }).then((value) => onCloseFn());
}
