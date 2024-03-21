import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../util/color_util.dart';

class MainTitle extends StatelessWidget {
  final String text;

  const MainTitle(
    this.text,
  );

  Widget styleingprimary() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor('#DB771A'),
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }

  Widget styleSecondary() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.SECONDARY),
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainTitle(text);
  }
}

class Largetitle extends StatelessWidget {
  final String text;

  const Largetitle(
    this.text,
  );

  Widget styleSecondary() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.SECONDARY),
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }

  Widget styleDescription() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor("8B99A7"),
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Largetitle(text);
  }
}

class MainDescription extends StatelessWidget {
  final String text;
  TextAlign? textAlign;
  MainDescription(
    this.text,[this.textAlign]
  );

  Widget styleSecondary() {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.SECONDARY),
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    );
  }

  Widget styleLightGrey() {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.LIGHT_GREY),
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainDescription(text);
  }
}

class TextTitle extends StatelessWidget {
  final String text;
  TextAlign? textAlign;

  TextTitle(this.text, [this.textAlign]);

  Widget stylePrimary() {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.PRIMARY),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget styleSecondary() {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.notoSansThai(
        color: HexColor("#003063"),
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextTitle(text);
  }
}

class Subtitle extends StatelessWidget {
  final String text;
  TextAlign? textAlign;

  Subtitle(this.text, [this.textAlign]);

  Widget styleSecondary() {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.SECONDARY),
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }

  Widget styleGrey() {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.GREY),
        fontWeight: FontWeight.w400,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Subtitle(text, textAlign);
  }
}

class Subtitle1 extends StatelessWidget {
  final String text;

  const Subtitle1(
    this.text,
  );

  Widget styleSecondary() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.SECONDARY),
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Subtitle1(text);
  }
}

class Subtitle2 extends StatelessWidget {
  final String text;

  TextAlign? textAlign;

  Subtitle2(this.text, [this.textAlign]);

  Widget styleSecondary() {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.SECONDARY),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }

  Widget styleGrey() {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      text,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.GREY),
        fontWeight: FontWeight.w600,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Subtitle2(text);
  }
}

class Subtitle3 extends StatelessWidget {
  final String text;

  const Subtitle3(
    this.text,
  );

  Widget styleSecondary() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Subtitle3(text);
  }
}

class Body extends StatelessWidget {
  final String text;

  TextAlign? textAlign;

  Body(this.text, [this.textAlign]);

  Widget styleSecondary() {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.notoSansThai(
        color: HexColor("646464"),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }

  Widget styleGrey() {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.GREY),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }

  Widget styleLightGrey() {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.notoSansThai(
        color: HexColor(ColorUtil.LIGHT_GREY),
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Body(text);
  }
}

class Caption extends StatelessWidget {
  final String text;

  const Caption(
    this.text,
  );

  Widget styleSecondary() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        fontWeight: FontWeight.w400,
        fontSize: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Caption(text);
  }
}

class Captionlabel extends StatelessWidget {
  final String text;

  const Captionlabel(
    this.text,
  );

  Widget styleSecondary() {
    return Text(
      text,
      style: GoogleFonts.notoSansThai(
        fontWeight: FontWeight.w400,
        fontSize: 10,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Captionlabel(text);
  }
}

class SectionTextTitle extends StatelessWidget {
  SectionTextTitle(this.text, [this.barColor,this.barHeight]);
  double? barHeight;
  Color? barColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 3,
          height: barHeight??16,
          decoration: BoxDecoration(
              color: barColor??HexColor(ColorUtil.PRIMARY),
              borderRadius: BorderRadius.circular(20)),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: GoogleFonts.notoSansThai(
              color: HexColor(ColorUtil.SECONDARY),
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ],
    );
  }
}
