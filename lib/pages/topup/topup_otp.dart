import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/topup_data.dart';

class TopupOtp extends StatefulWidget {
  final TopupConclusion topupConclusion;
  const TopupOtp({Key? key, required this.topupConclusion}) : super(key: key);

  @override
  State<TopupOtp> createState() => _TopupOtpState();
}

class _TopupOtpState extends State<TopupOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'ตรวจสอบข้อมูลส่วนตัว',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: HexColor('#FFFFFF'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: HexColor('#DB771A'),
            ),
          ),
        ),
        body: Center(
          child: Text('otp page'),
        ));
  }
}
