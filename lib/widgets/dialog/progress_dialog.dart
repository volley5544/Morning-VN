import 'package:flutter/material.dart';

showProgressDialog({required BuildContext context}){
     return showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: Center(
                child: Image.asset(
                  'assets/srisawad-loading.gif',
                  height: 84,
                  width: 84,
                ),
              ),
            );
          });
}

hideProgressDialog(BuildContext context){
  Navigator.of(context, rootNavigator: true).pop();
}