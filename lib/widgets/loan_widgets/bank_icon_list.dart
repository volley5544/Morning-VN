import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';

class BankIconList extends StatelessWidget {
  final BuildContext context;
  BankIconList({required this.context});

  List<String> iconList = [
    'counterService',
    'lotus',
    'ttb',
    'baac',
    'kbank',
    'ktb',
    'bbl',
    'gsb',
  ];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...(iconList.map(
          (icons) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Image.asset(
                'assets/$icons.png',
                height: 32,
                width: 32,
              ),
            );
          },
        ))
      ],
    );
    // );
  }
}
