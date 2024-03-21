// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../pages/topup/topup_styling.dart';

class ProfileFields extends StatelessWidget {
  final String keyName;
  final String keyValue;

  String? emptyValue;

  ProfileFields(
      {super.key,
      required this.keyName,
      required this.keyValue,
      this.emptyValue});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            keyName,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .merge(TextStyle(color: HexColor('#646464'))),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            emptyValue != null && keyValue.isEmpty ? emptyValue! : keyValue,
            style: Theme.of(context).textTheme.titleMedium?.merge(
                const TextStyle(
                    fontFamily: 'NotoSansThaiSemiBold', height: 1.51125)),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 14,
          ),
        ]);
  }
}

class EditProfileFields extends StatefulWidget {
  final String keyName;
  final String initialValue;
  final Function onChangeText;
  final bool isWarning;
  final bool? isLineID;
  final int? max;
  final String? hint;

  const EditProfileFields(
      {super.key,
      required this.keyName,
      required this.initialValue,
      required this.onChangeText,
      required this.isWarning,
      this.isLineID,
      this.max,
      this.hint});

  @override
  State<EditProfileFields> createState() => _EditProfileFieldsState();
}

class _EditProfileFieldsState extends State<EditProfileFields> {
  final textController = TextEditingController();
  List<TextInputFormatter>? formatter = null;

  void initState() {
    if (widget.isLineID != null && widget.isLineID == true) {
      formatter = [
        FilteringTextInputFormatter.allow(RegExp('[0-9a-zA-Z._-]')),
      ];
    } else {
      formatter = null;
    }
    setState(() {
      textController.text = widget.initialValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: 12,
          // ),
          TextField(
            inputFormatters: formatter,
            style: Theme.of(context).textTheme.titleMedium?.merge(
                const TextStyle(
                    fontFamily: 'NotoSansThaiSemiBold', height: 2.1)),
            maxLength: widget.max,
            onChanged: (e) => widget.onChangeText(e),
            controller: textController,
            decoration: InputDecoration(
              counterText: '',
              hintText: widget.hint,
              hintStyle: TextStyle(
                  height: 2.1, color: HexColor('#DBDBDB'), fontSize: 16),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              label: Text(
                widget.keyName,
                style: Theme.of(context).textTheme.bodyMedium?.merge(
                    TextStyle(color: HexColor("#646464"), fontSize: 18)),
                textAlign: TextAlign.start,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(width: .5, color: HexColor('#E5E5E5')),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: widget.isWarning
                        ? HexColor('#A02802')
                        : Theme.of(context).primaryColor),
              ),
            ),
          ),
          widget.isWarning
              ? Text(
                  'กรุณาใส่อีเมลให้ถูกต้อง (เช่น srisawad@example.com)',
                  style: warning12CRed,
                )
              : Text(''),
        ]);
  }
}
