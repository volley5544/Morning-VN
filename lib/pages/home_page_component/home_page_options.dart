import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_list_page.dart';

class SelectableHomePageOptions extends StatelessWidget {
  const SelectableHomePageOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 22, right: 22),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SelectableHomePageOptionsItem(
              title: "เพิ่มวงเงิน",
              assetName: "topup 1.svg",
              onSelect: () {
                BlocProvider.of<PageResultBloc>(context)
                    .add(const SetButtonNavigator(false));
                Navigator.of(context).pushNamed('/top-up-list-page');
              }),
          SizedBox(
            width: 12,
          ),
          SelectableHomePageOptionsItem(
              title: "ชำระด้วย QR",
              assetName: "qrcode 1.svg",
              onSelect: () {
                BlocProvider.of<PageResultBloc>(context)
                    .add(const SetButtonNavigator(false));
                Navigator.of(context).pushNamed('/loan-list-page');
              }),
          SizedBox(
            width: 12,
          ),
          SelectableHomePageOptionsItem(
              title: "ติดตามสถานะ",
              assetName: "topup-status.svg",
              onSelect: () {
                BlocProvider.of<PageResultBloc>(context)
                    .add(const SetButtonNavigator(false));
                Navigator.of(context).pushNamed('/topup-status-list');
              }),
        ],
      ),
    );
  }
}

class SelectableHomePageOptionsItem extends StatelessWidget {
  const SelectableHomePageOptionsItem(
      {Key? key,
      required this.assetName,
      required this.title,
      required this.onSelect})
      : super(key: key);
  final String assetName;
  final String title;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                  offset: Offset(0, 3),
                  blurRadius: 10)
            ],
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: TextButton(
            onPressed: () {
              onSelect.call();
            },
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/' + assetName, width: 32, height: 32),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: GoogleFonts.notoSansThai(
                      fontSize:
                          MediaQuery.of(context).textScaleFactor != 1 ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: HexColor('#404040')),
                ),
              ],
            )),
          )),
    );
  }
}
