import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TermConditionCard extends StatelessWidget {
  TermConditionCard({Key? key}) : super(key: key);

  Widget textContent(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        text,
        maxLines: 2,
        style: TextStyle(
            color: Color.fromRGBO(64, 64, 64, 1),
            fontSize: 14,
            letterSpacing: 0,
            fontWeight: FontWeight.w400,
            height: 1.5),
      ),
    );
  }

  List<String> textList = [
    '• ไม่มียอดค้างชำระ',
    '• ผ่อนชำระมาแล้วเกินครึ่งสัญญา',
    '• สัญญาเหลืองวดค้างมากกว่า 3 งวด',
    '• ลูกหนี้คงเหลือมากกว่า 3,000 บาท',
    '• อายุรถไม่เกิน 7 ปี',
    '• ขอเพิ่มวงเงินได้สูงสุด 70,000 บาท'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Container(
        width: 331,
        // height: 118,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
          color: Color.fromRGBO(251, 239, 227, 1),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, top: 14, bottom: 14, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'เงื่อนไขในการขอเพิ่มวงเงิน',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(218, 119, 26, 1),
                        fontSize: 14,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Container(
                    height: 8,
                  ),
                  ...(textList.map((e) => textContent(e))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  '*สามารถทำการขอเพิ่มวงเงินได้เวลา 06.00 - 23.00 น.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 48, 99, 1),
                      fontSize: 14,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
