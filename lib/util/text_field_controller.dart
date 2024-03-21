import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/util/color_util.dart';
import 'package:mobile_application_srisawad/util/currentcy_format.dart';

import '../pages/topup/topup_styling.dart';

class TextFieldController extends TextInputFormatter {
  // Regular expression pattern to match currency format
  static const pattern = r'^\d+\.?\d{0,2}';

  // Allow only digits and a maximum of 2 decimal places
  final RegExp _regex = RegExp(pattern);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final numberFormat = NumberFormat('#,###', 'th_TH');
    String newText = newValue.text.replaceAll(',', '');
    String newValues = numberFormat.format(double.tryParse(newText) ?? 0.0);
    if (newText.length >= 15) {
      return oldValue;
    } else {
      if (newValue.text.contains('.')) {
        return TextEditingValue(
          text: oldValue.text,
          selection: TextSelection.collapsed(offset: oldValue.text.length),
        );
      }
      return TextEditingValue(
        text: newValues,
        selection: TextSelection.collapsed(offset: newValues.length),
      );
    }
  }
}

class CurrencyInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final FocusNode focusNode;
  final Function onNumberChamge;
  final TopupState topupState;
  CurrencyInputField(
      {required this.controller,
      required this.labelText,
      required this.focusNode,
      required this.onNumberChamge,
      required this.topupState});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      onChanged: (string) => onNumberChamge(string, topupState),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [TextFieldController()],
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: HexColor(ColorUtil.PRIMARY)),
          ),
          suffix: Text('บาท', style: size24W600)),
      style: size24W600,
    );
  }
}
