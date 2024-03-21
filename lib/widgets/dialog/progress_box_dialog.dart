import 'package:flutter/material.dart';

showProgressBoxDialog({required BuildContext context}) {
  return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  color: Colors.white,
                ),
                child: Image.asset(
                  'assets/srisawad-loading.gif',
                  height: 84,
                  width: 84,
                ),
              ),
            ));
      });
}
