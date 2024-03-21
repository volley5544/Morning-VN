import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../pages/topup/topup_navigate.dart';
import '../pages/topup/topup_styling.dart';

getDialogHeight(BuildContext context) {
  if (MediaQuery.of(context).size.height > 700) {
    return MediaQuery.of(context).size.height * 0.6;
  } else {
    return MediaQuery.of(context).size.height * 0.85;
  }
}

Future<Function?> ShowBottomSvgVersion(BuildContext context, String titleheader,
        String image, String titlebody, VoidCallback? onTap, String buttontap,
        {bool enableDrag = true}) async =>
    await showMaterialModalBottomSheet(
      isDismissible: false,
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  titleheader,
                  style: GoogleFonts.notoSansThai(
                      color: HexColor('##003063'),
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SvgPicture.asset(
                    image,
                    height: 248,
                    width: 248,
                    fit: BoxFit.contain,
                  ),
                ),

                // SvgPicture.asset('assets/success-icon.svg'),
                Center(
                  child: Text(
                    titlebody,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansThai(
                        fontSize: 18,
                        color: HexColor('#8B99A7'),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color: HexColor('#DB771A'),
                        borderRadius: BorderRadius.circular(14)),
                    child: TextButton(
                      onPressed: onTap,
                      child: Text(
                        buttontap,
                        style: GoogleFonts.notoSansThai(
                          fontSize: 16,
                          color: HexColor('#FFFFFF'),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

Future ShowBottomPngOneButtonVersion(BuildContext context, String titleheader,
        String image, String titlebody, VoidCallback? onTap, String buttontap,
        {bool enableDrag = false,
        String additionalString = '',
        double popupHeight = 0}) async =>
    await showMaterialModalBottomSheet(
      enableDrag: enableDrag,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => SafeArea(
        top: false,
        child: Wrap(children: [
          Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Container(
                        width: 65,
                        height: 4,
                        decoration: BoxDecoration(
                            color: HexColor("#D9D9D9"),
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        titleheader,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSansThai(
                            color: HexColor('##003063'),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48),
                        child: Image.asset(
                          image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Center(
                        child: Text(
                          titlebody,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.notoSansThai(
                              fontSize: 18,
                              color: HexColor('#8B99A7'),
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Center(
                        child: Text(
                          additionalString,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge!.merge(
                              TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer)),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: HexColor('#DB771A'),
                            borderRadius: BorderRadius.circular(14)),
                        child: TextButton(
                          onPressed: onTap,
                          child: Text(
                            buttontap,
                            style: GoogleFonts.notoSansThai(
                              fontSize: 16,
                              color: HexColor('#FFFFFF'),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ]),
      ),
    );

Future<void> ShowTwoBottomPngVersion(
        BuildContext context,
        String titleheader,
        String image,
        String titlebody,
        VoidCallback? onTap,
        String buttontap,
        VoidCallback? onTap2,
        String buttontap2) async =>
    await showMaterialModalBottomSheet(
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => SafeArea(
        top: false,
        child: Wrap(children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            // height: getDialogHeight(context),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    width: 65,
                    height: 4,
                    decoration: BoxDecoration(
                        color: HexColor("#D9D9D9"),
                        borderRadius: BorderRadius.circular(2)),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Text(
                    titleheader,
                    style: GoogleFonts.notoSansThai(
                        color: HexColor('##003063'),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  // SvgPicture.asset('assets/success-icon.svg'),
                  Center(
                    child: Text(
                      titlebody,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSansThai(
                          fontSize: 18,
                          color: HexColor('#8B99A7'),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color: HexColor('#DB771A'),
                        borderRadius: BorderRadius.circular(14)),
                    child: TextButton(
                      onPressed: onTap,
                      child: Text(
                        buttontap,
                        style: GoogleFonts.notoSansThai(
                          fontSize: 16,
                          color: HexColor('#FFFFFF'),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(14)),
                    child: TextButton(
                      onPressed: onTap2,
                      child: Text(buttontap2,
                          style: GoogleFonts.notoSansThai(
                              fontSize: 16,
                              color: HexColor('#DB771A'),
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );

Future<void> ShowDuoBottonSvgVersion({
  required BuildContext context,
  required String titleheader,
  required String titlebody,
  required Widget bodyContent,
  required VoidCallback? onTap,
  required String buttontap,
  required VoidCallback? onTap2,
  required String buttontap2,
}) async =>
    await showMaterialModalBottomSheet(
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))), //20
      context: context,
      builder: (context) => Wrap(children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: HexColor('#D9D9D9')),
                      width: 65,
                      height: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 34),
                      child: Text(
                        titleheader,
                        style: GoogleFonts.notoSansThai(
                            color: HexColor('##003063'),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 14, left: 0, right: 0),
                      child: Center(
                        child: Text(
                          titlebody,
                          textAlign: TextAlign.center,
                          style: size18Wnormal.merge(TextStyle(height: 1.7)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: bodyContent,
                    ),
                  ],
                ),
                SizedBox(
                  height: 28,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Container(
                        // width: 160,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextButton(
                          onPressed: onTap,
                          child: Text(
                            buttontap,
                            style: GoogleFonts.notoSansThai(
                              fontSize: 16,
                              color: HexColor('#DB771A'),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 11,
                    ),
                    Expanded(
                      child: Container(
                        // width: 160,
                        height: 60,
                        decoration: BoxDecoration(
                            color: HexColor('#DB771A'),
                            borderRadius: BorderRadius.circular(14)),
                        child: TextButton(
                          onPressed: onTap2,
                          child: Text(buttontap2,
                              style: GoogleFonts.notoSansThai(
                                fontSize: 16,
                                color: HexColor('#FFFFFF'),
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );

Future<void> ShowBottomSlidingBox({
  required BuildContext context,
  required String titleheader,
  required String image,
  required String titlebody,
  required Widget buttonContent,
  required VoidCallback? onTap,
  required VoidCallback? onTap2,
}) async =>
    await showMaterialModalBottomSheet(
      enableDrag: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => Wrap(children: [
        Container(
            // height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: HexColor('#D9D9D9')),
                        width: 65,
                        height: 4,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        titleheader,
                        style: GoogleFonts.notoSansThai(
                            color: HexColor('##003063'),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        image,
                        height: 248,
                        width: 248,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      // SvgPicture.asset('assets/success-icon.svg'),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 34),
                        child: Center(
                          child: Text(
                            titlebody,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.notoSansThai(
                                fontSize: 18,
                                color: HexColor('#8B99A7'),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  buttonContent
                ],
              ),
            )),
      ]),
    );
Future<void> ShowTopupiSuccessBottomBox({
  required BuildContext context,
  required String titleheader,
  required String image,
  required String titlebody,
  required Widget buttonContent,
  required VoidCallback? onTap,
  required VoidCallback? onTap2,
}) async =>
    await showMaterialModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          ResetToptupConsent(context);
          BlocProvider.of<PageResultBloc>(context)
              .add(SetButtonNavigator(true));
          BlocProvider.of<PageResultBloc>(context)
              .add(SetCurrentNavBarIndex(0));
          Navigator.pushNamed(context, '/home-page');
          return false;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          // height: 680,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(titleheader,
                      style: TextStyle(fontSize: 24, color: HexColor('#003063'))
                          .merge(
                              TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
                ],
              ),
              SvgPicture.asset(
                image,
                height: 248,
                width: 248,
                fit: BoxFit.contain,
              ),
              Center(
                child: Text(
                  titlebody,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSansThai(
                      fontSize: 18,
                      color: HexColor('#8B99A7'),
                      fontWeight: FontWeight.w400),
                ),
              ),
              buttonContent
            ],
          ),
        ),
      ),
    );
