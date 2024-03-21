import 'package:flutter/material.dart';

class ProgressLoading extends StatelessWidget {
  const ProgressLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Image.asset(
            'assets/srisawad-loading.gif',
            height: 84,
            width: 84,
          )),
          Text('กำลังโหลด...')
        ],
      ),
    );
  }
}
