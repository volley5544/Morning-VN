import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/widgets/base_card.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';

import '../../main.dart';

class InfoWindow extends StatelessWidget {
  final String title;
  final String address;
  final String subDistrict;
  final String district;
  final String province;
  final String contact;
  final String distance;
  final Function launchDial;
  final Function launchMap;

  const InfoWindow(
      {required this.title,
      required this.address,
      required this.contact,
      required this.distance,
      required this.launchDial,
      required this.launchMap,
      required this.subDistrict,
      required this.district,
      required this.province});

  String isTextContentEmpty(String text) {
    if (text != '') {
      return text;
    }
    return '-';
  }

  Widget infoContent(BuildContext context) {
    final prepContract = contact.replaceAll("-", "");
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 0, 5),
            child: Text(
              title == '' ? '-' : title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSansThai(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: HexColor('#003063'),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: SvgPicture.asset('assets/BrnachLocationIcon.svg'),
              ),
              // Image.asset('assets/LocationIcon.png'),
              SizedBox(
                width: 290,
                // height: 50,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  child: Text(
                    '${address.trim()} ${isTextContentEmpty(subDistrict).trim()} ${isTextContentEmpty(district).trim()} ${isTextContentEmpty(province).trim()} ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            children: <Widget>[
              SvgPicture.asset('assets/PhoneIcon.svg'),
              Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: SizedBox(
                    width: 130,
                    child: Text(
                      isTextContentEmpty(contact) == '-'
                          ? '-'
                          : MaskedTextController(
                                  mask: '000-000-0000', text: prepContract)
                              .text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )),
              SvgPicture.asset('assets/DistanceIcon.svg'),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                child: Text(isTextContentEmpty(distance),
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
            ],
          ),
        )
      ],
      //   )
      // ],
    );
  }

  Widget bottomInfo() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(13, 0, 13, 14),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: contact == ''
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Button(
                buttonCallBack: launchMap,
                color: 'DB771A',
                height: 48,
                isTextBlack: false,
                textButton: 'นำทาง',
                // width: 153,
              ),
            ),
            Container(
              width: 8,
            ),
            (contact == '' || contact == '-')
                ? Expanded(child: Container())
                : Expanded(
                    child: Button(
                      buttonCallBack: launchDial,
                      color: 'FCEFE4',
                      height: 48,
                      isTextBlack: true,
                      textButton: 'โทร',
                      // width: 153,
                    ),
                  )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BaseCard(
        buttomContent: bottomInfo(),
        content: infoContent(context),
        width: getActualWidth(context) * 0.87);
  }
}
