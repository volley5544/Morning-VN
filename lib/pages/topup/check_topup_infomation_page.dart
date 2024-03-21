import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../bloc/page_result/page_result_bloc.dart';
import '../../bloc/topup_bloc/topup_bloc.dart';
import '../../main.dart';
import '../../models/loan_detail.dart';
import '../../models/topup_data.dart';
import '../../models/user_addresses.dart';
import '../../modules/topupRepo/index.dart';
import '../../util/width_until.dart';
import '../../widgets/bottompage.dart';
import '../../widgets/buttons/duo_button.dart';
import 'topup_styling.dart';
import 'topup_widgets/back_account_infonaion.dart';

class CheckTopupInfomation extends StatefulWidget {
  final TopupConclusion topupConclusion;
  const CheckTopupInfomation({Key? key, required this.topupConclusion})
      : super(key: key);

  @override
  State<CheckTopupInfomation> createState() => _CheckTopupInfomationState();
}

class _CheckTopupInfomationState extends State<CheckTopupInfomation> {
  final TopupRepository topupRepository = TopupRepository();
  final double prefixLineHeight = 18;
  final double prefixLineWidth = 3;
  final EdgeInsets headerPadding = EdgeInsets.only(left: 10, top: 3);

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

  static const configKey = [
    {'label': 'ที่อยู่ปัจจุบัน', 'valueField': 'current_address'},
    {'label': 'ที่อยู่ตามทะเบียนบ้าน', 'valueField': 'registration_address'},
    {'label': 'ที่อยู่ตามบัตรประชาชน', 'valueField': 'id_card_address'},
    {'label': 'ที่ทำงาน/ที่อยู่อื่นๆ', 'valueField': 'other_address'},
  ];

  Map<String, dynamic> setIconMapper() {
    return {
      'current_address': 'current-address-icon',
      'registration_address': 'registered-address',
      'id_card_address': 'card-id-address',
      'other_address': 'office-address',
    };
  }

  Map<String, dynamic> setModelEncode(UserAddresses userAddresses) {
    return {
      'current_address':
          '${userAddresses.currentAddress.addressDetails.trim()} ${userAddresses.currentAddress.addressSubDistrict} ${userAddresses.currentAddress.addressDistrict} ${userAddresses.currentAddress.addressProvince} ${userAddresses.currentAddress.addressPostalCode}',
      'registration_address':
          '${userAddresses.registrationAddress.addressDetails.trim()} ${userAddresses.registrationAddress.addressSubDistrict} ${userAddresses.registrationAddress.addressDistrict} ${userAddresses.registrationAddress.addressProvince} ${userAddresses.registrationAddress.addressPostalCode}',
      'id_card_address':
          '${userAddresses.idCardAddress.addressDetails.trim()} ${userAddresses.idCardAddress.addressSubDistrict} ${userAddresses.idCardAddress.addressDistrict} ${userAddresses.idCardAddress.addressProvince} ${userAddresses.idCardAddress.addressPostalCode}',
      'other_address':
          '${userAddresses.otherAddress.addressDetails.trim()} ${userAddresses.otherAddress.addressSubDistrict} ${userAddresses.otherAddress.addressDistrict} ${userAddresses.otherAddress.addressProvince} ${userAddresses.otherAddress.addressPostalCode}',
    };
  }

  @override
  void initState() {
    context.read<TopupBloc>().add(GetUsreAddreses(
        hashThaiId: hashThaiId,
        topupRepository: topupRepository,
        context: context));
    super.initState();
  }

  Widget addressList() {
    return BlocBuilder<TopupBloc, TopupState>(
      builder: (context, state) {
        if (state is TopupLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(219, 119, 26, 1),
            ),
          );
        }
        if (state is TopupError) {
          return Container();
        }
        if (state is TopupComplete) {
          return Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 21),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                              height: prefixLineHeight,
                              child: Container(
                                  width: prefixLineWidth,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFDB771A)
                                          .withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))))),
                          Padding(
                            padding: headerPadding,
                            child: Text(
                              'ข้อมูลที่อยู่',
                              style: size16W600CBlackBlue.merge(TextStyle(
                                  fontFamily: 'NotoSansThaiSemiBold')),
                            ),
                          ),
                        ],
                      )),
                ),
                ...(configKey.map((key) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: widthAdjuster(
                          screenWidth: MediaQuery.of(context).size.width,
                          widthMod: 0.9),
                      height: 84,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                        border: Border.all(
                          color: Color.fromRGBO(229, 229, 229, 1),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 21),
                            child: SvgPicture.asset(
                                'assets/${setIconMapper()[key['valueField']]}.svg'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${key['label']}',
                                  style: size16W600CBlackBlue.merge(TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'NotoSansThaiSemiBold')),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                          maxWidth: widthAdjuster(
                                              screenWidth:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width,
                                              widthMod: 0.6)),
                                      child: Text(
                                        '${setModelEncode(state.userAddressesList)[key['valueField']]}',
                                        style: size18Wnormal.merge(TextStyle(
                                            fontSize: 14, height: 1.5)),
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }))
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  String phonenumberRexExSafty(String phoneNumber) {
    try {
      return phoneNumber.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'),
          (Match m) => "${m[1]}-${m[2]}-${m[3]}");
    } catch (e) {
      logger.e(
          'Caught error in check topup data phonenumber is empty:${e.toString()} ');
      return '';
    }
  }

  Widget userPhoneIndomation() {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 21, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                          height: prefixLineHeight,
                          child: Container(
                              width: prefixLineWidth,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xFFDB771A).withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))))),
                      Padding(
                        padding: headerPadding,
                        child: Text(
                          'ข้อมูลเบอร์โทรศัพท์',
                          style: size16W600CBlackBlue.merge(TextStyle(
                            fontFamily: 'NotoSansThaiSemiBold',
                          )),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'เบอร์โทรศัพท์',
                      style: TextStyle(color: HexColor('#646464')),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${phonenumberRexExSafty(state.userProfileData.phoneNumber)}',
                      style: size16CBlue.merge(TextStyle(
                          color: HexColor('#003063'),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'NotoSansThai',
                          letterSpacing: 0.3)),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  void nagivateConclusionPage(LoanDetail loanDetail) {
    Navigator.pop(context);
    navKey.currentState!
        .pushNamed('/top-up-contract-conclusion',
            arguments: widget.topupConclusion)
        .then((value) => Navigator.pop(context));
  }

  Widget renderSlidingBoxButton() {
    return Column(
      children: [
        Container(
          width: widthAdjuster(screenWidth: MediaQuery.of(context).size.width),
          height: 60,
          decoration: BoxDecoration(
              color: HexColor('#DB771A'),
              borderRadius: BorderRadius.circular(14)),
          child: TextButton(
            onPressed: () {
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetCurrentNavBarIndex(1));
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetButtonNavigator(true));
              navKey.currentState?.pushNamed('/map-page');

              // BlocProvider.of<mapSearch.MapSearchBloc>(context).add(mapSearch.MapSetSearchHistory(branchOptions: ));
            },
            child: Text(
              'ค้นหาสาขาใกล้เคียง',
              style: GoogleFonts.notoSansThai(
                fontSize: 16,
                color: HexColor('#FFFFFF'),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: HexColor('#DB771A'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'ตรวจสอบข้อมูลส่วนตัว',
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                      TextStyle(
                          fontSize: 24, fontFamily: 'NotoSansThaiSemiBold')),
                ),
              ),
            ],
          ),
          backgroundColor: HexColor('#FFFFFF'),
        ),
        body: BlocBuilder<TopupBloc, TopupState>(builder: (context, state) {
          if (state is TopupLoading) {
            return Center(
              child: ProgressLoading(),
            );
          }
          // else if (state is TopupError) {
          //   return Container();
          // }
          // else if (state is TopupComplete) {
          else if (state is TopupComplete) {
            return Container(
              color: HexColor('#FFFFFF'),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 23, right: 32, top: 10),
                                    child: Text(
                                        'กรุณาตรวจสอบความถูกต้องของข้อมูลอีกครั้งเพื่อยืนยันการขอเพิ่มวงเงิน',
                                        style: size16CBlackBlue),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 21),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                            height: prefixLineHeight,
                                            child: Container(
                                                width: prefixLineWidth,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFDB771A)
                                                            .withOpacity(0.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20))))),
                                        Padding(
                                          padding: headerPadding,
                                          child: Text('ข้อมูลเลขที่บัญชี',
                                              style: size16W600CBlackBlue.merge(
                                                  TextStyle(
                                                      fontFamily:
                                                          'NotoSansThaiSemiBold'))),
                                        ),
                                      ],
                                    ),
                                  )),
                              BackAccountInfomation(
                                branchImage: widget
                                    .topupConclusion.loanDetail.branchImage,
                                contractBankAccount: widget.topupConclusion
                                    .loanDetail.contractBankAccount,
                                contractBankBrandname: widget.topupConclusion
                                    .loanDetail.contractBankBrandname,
                              ),
                              userPhoneIndomation(),
                              addressList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  DuoButton(
                    leftTitle: 'ไม่ถูกต้อง',
                    onLeftButtonTap: () => ShowBottomSlidingBox(
                        buttonContent: renderSlidingBoxButton(),
                        context: context,
                        image: 'assets/branch.png',
                        onTap: () {},
                        onTap2: () {},
                        titlebody:
                            'กรุณาติดต่อที่สาขาใกล้เคียง\nเพื่อทำการแก้ไขข้อมูลให้ถูกต้อง',
                        titleheader: 'กรุณาติดต่อสาขา'),
                    onRightButtonTap: () => ShowDuoBottonSvgVersion(
                      buttontap: 'ตรวจสอบอีกครั้ง',
                      buttontap2: 'ยืนยัน',
                      context: context,
                      onTap: () => Navigator.pop(context),
                      onTap2: () => nagivateConclusionPage(
                          widget.topupConclusion.loanDetail),
                      titlebody:
                          'คุณยืนยันที่จะให้ทางเราทำการโอนเงิน\nไปยังเลขที่บัญชีนี้ใช่หรือไม่?',
                      titleheader: 'ยืนยันข้อมูล',
                      bodyContent: BackAccountInfomation(
                        branchImage:
                            widget.topupConclusion.loanDetail.branchImage,
                        contractBankAccount: widget
                            .topupConclusion.loanDetail.contractBankAccount,
                        contractBankBrandname: widget
                            .topupConclusion.loanDetail.contractBankBrandname,
                      ),
                    ),
                    rightTitle: 'ยืนยัน',
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        }));
  }
}
