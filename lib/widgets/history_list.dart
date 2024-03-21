import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class HistoryList extends StatelessWidget {
  final String historyText;
  HistoryList(this.historyText);

  @override
  Widget build(BuildContext context) {
    return // Figma Flutter Generator RecentlysearchWidget - GROUP
        Column(
      children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width,
            height: 64,
            child: Row(children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        historyText,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.notoSansThai(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: HexColor('#003063'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])),
        Container(
          height: 1.5,
          color: HexColor('#E5E5E5'),
        ),
      ],
    );
  }
}
