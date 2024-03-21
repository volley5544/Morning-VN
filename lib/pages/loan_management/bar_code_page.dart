import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';

class BarCodePageg extends StatelessWidget {
  final PaymentDetail paymentDetail;
  final bool isBarCodeShow;
  final Function onBarCodeSelected;
  const BarCodePageg(
      {required this.paymentDetail,
      required this.isBarCodeShow,
      required this.onBarCodeSelected});

  @override
  Widget build(BuildContext context) {
    return isBarCodeShow
        ? Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                  width: 270,
                  child: Image.memory(
                    Uint8List.fromList(paymentDetail.qrCode.data.cast<int>()),
                    // width: MediaQuery.of(context).size.height * 0.4,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('R1: ${paymentDetail.qrCodeDetail.ref1}'),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('R2: ${paymentDetail.qrCodeDetail.ref2}'),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(top: 36),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => onBarCodeSelected(),
                  child: SizedBox(
                    width: 320,
                    child: Image.memory(Uint8List.fromList(
                        paymentDetail.barCode.data.cast<int>())),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18),
                  child: Text('R1: ${paymentDetail.qrCodeDetail.ref1}'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('R2: ${paymentDetail.qrCodeDetail.ref2}'),
                ),
              ],
            ),
          );
  }
}
