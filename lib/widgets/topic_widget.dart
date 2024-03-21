import 'package:flutter/material.dart';

class TopicWidget extends StatelessWidget {
  final String title;
  const TopicWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 21),
      child: Row(
        children: [
          SizedBox(
              height: 18,
              child: Container(
                  width: 3,
                  decoration: BoxDecoration(
                      color: const Color(0xFFDB771A).withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(1.5))))),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: TextStyle(
                  color: Color.fromRGBO(0, 48, 99, 1),
                  fontFamily: 'NotoSansThaiSemiBold',
                  fontSize: 16,
                  letterSpacing: 0,
                  fontWeight: FontWeight.normal,
                  height: 0),
            ),
          ),
        ],
      ),
    );
  }
}
