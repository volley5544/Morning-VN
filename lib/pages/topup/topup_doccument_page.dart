import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_navigate.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../main.dart';
import '../../models/topup_data.dart';
import '../../models/topup_pdf.dart';
import '../../modules/topupRepo/index.dart';
import '../../services/localStorage/local_storage.dart';
import '../../widgets/bottompage.dart';
import '../../widgets/loan_widgets/bootom_button.dart';
import 'topup_controller.dart';
import 'topup_styling.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class TopupDoccumentPage extends StatefulWidget {
  final TopupConclusion topupConclusion;
  const TopupDoccumentPage({Key? key, required this.topupConclusion})
      : super(key: key);

  @override
  State<TopupDoccumentPage> createState() => _TopupDoccumentPageState();
}

class _TopupDoccumentPageState extends State<TopupDoccumentPage> {
  ScrollController _scrollController = ScrollController();
  bool atBottom = false;
  bool isCheckBoxSelected = false;
  TopupController topupController = TopupController();
  TopupRepository topupRepository = TopupRepository();
  // PDFViewController pdfViewController = PDFViewController();
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  LocalStoragePrefernces localStoragePrefernces = LocalStoragePrefernces();
  // Activated when you get to the bottom:
  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  Future handlePdf() async {
    final UserProfileState userProfileBloc =
        BlocProvider.of<UserProfileBloc>(context).state;
    context.read<TopupBloc>().add(GetContractDoccument(
        topupRepository: topupRepository,
        topupSubmitForm: TopupSubmitForm(
          contractNo: widget.topupConclusion.loanDetail.contractNo.trim(),
          dbName: widget.topupConclusion.loanDetail.dbName,
          contractDate: widget.topupConclusion.loanDetail.contractCreateDate,
          name:
              '${userProfileBloc.userProfileData.firstName} ${userProfileBloc.userProfileData.lastName}',
          amount: widget.topupConclusion.loanTotalBalanceAmount,
          from: widget
              .topupConclusion.loanDetail.contractDetails.comcode, // comcode
          contractBankAccount:
              widget.topupConclusion.loanDetail.contractBankAccount,
          contractBankBrandname:
              widget.topupConclusion.loanDetail.contractBankBrandname,
          thaiId: hashThaiId,
          interestRate:
              widget.topupConclusion.topupInstallmentNumber.interestRate,
          installmentNumber:
              widget.topupConclusion.selectedInstallmentNumber.tenor,
          amountPerInstallment:
              widget.topupConclusion.selectedInstallmentNumber.regularPeriodAmt,
          startInstallmentDate:
              widget.topupConclusion.topupInstallmentNumber.firstDueDate,
          // TODO Saksit get this field (there is no api provide this fieldyet)
          // back-end will provide tihs
          installmentDate: '',
          address:
              "${userProfileBloc.userProfileData.addressDetails.trim()} ตำบล ${userProfileBloc.userProfileData.addressSubDistrict} อำเภอ ${userProfileBloc.userProfileData.addressDistinct} จังหวัด ${userProfileBloc.userProfileData.addressProvince} ${userProfileBloc.userProfileData.addressPostalCode}",
          age: '',
          collateralInformation: widget
              .topupConclusion.loanDetail.contractDetails.collateralInformation,
          contractBankBranch: '',
          contractBankType: widget.topupConclusion.loanDetail.contractBankType,
          vehicleBrand: widget
              .topupConclusion.loanDetail.contractDetails.vehicleBrand
              .trim(),
          vehicleColor:
              widget.topupConclusion.topupDataConclusion.carDetails.carColor,
          vehicleModel:
              widget.topupConclusion.topupDataConclusion.carDetails.carSeries,
          vehicleProvince: widget
              .topupConclusion.loanDetail.contractDetails.licensePlateProvince,
          vehicleType:
              widget.topupConclusion.loanDetail.contractDetails.loanTypeName,
        ),
        context: context));
  }

  @override
  void initState() {
    atBottom = false;
    handlePdf();
    super.initState();
  }

  void nagivateConclusionPage(TopupConsent topupConsent, TopupPdf topupPdf) {
    if (widget.topupConclusion.isComeFromConclusionNext) {
      nagivateToDocPage(
          topupController.getNextPage(topupConsent), true, topupPdf);
    } else {
      navKey.currentState!.pushNamed('/top-up-contract-conclusion',
          arguments: widget.topupConclusion);
    }
  }

  Future<void> nagivateToDocPage(
      String appbarTitle, bool goThrough, TopupPdf topupPdf) async {
    TopupState state = BlocProvider.of<TopupBloc>(context).state;
    if (appbarTitle == 'gonext') {
      dynamic phoneNumber =
          await localStoragePrefernces.getLocalStorage('phoneNumber', 'string');
      Navigator.pushNamed(context, '/otp-page', arguments: {
        'callbackFunction': () async {
          String transoNo = await saveTopup(
              topupRepository: topupRepository,
              topupConclusion: widget.topupConclusion,
              topupPdf: topupPdf,
              context: context,
              topupSubmitForm: state.topupSubmitForm);
          if (transoNo != 'n' && transoNo != 'null') {
            ShowTopupiSuccessBottomBox(
                buttonContent: renderTopupSuccessButton(
                    context,
                    transoNo,
                    widget.topupConclusion.topupDataConclusion.dbName,
                    widget.topupConclusion.loanDetail),
                context: context,
                image: 'assets/success-icon.svg',
                onTap: () {},
                onTap2: () {},
                titlebody:
                    'โปรดรอรับการอนุมัติจากทางศรีสวัสดิ์หากได้รับการอนุมัติและมีการโอนเงินแล้วจะส่ง SMS ไปยังหมายเลข ${phoneNumber.substring(0, 3)}-XXX-${phoneNumber.substring(6, 10)}',
                titleheader: 'ยื่นคำขอเพิ่มวงเงินเรียบร้อยแล้ว');
          }
        },
        'phoneNumber': phoneNumber.toString(),
      });
    } else {
      navKey.currentState!.pushNamed('/top-up-doccument',
          arguments: TopupConclusion(
              loanDetail: widget.topupConclusion.loanDetail,
              selectedInstallmentNumber:
                  widget.topupConclusion.selectedInstallmentNumber,
              isComeFromConclusionNext: goThrough,
              appbarTitle: appbarTitle,
              loanTotalBalanceAmount:
                  widget.topupConclusion.loanTotalBalanceAmount,
              vehicleImage: widget.topupConclusion.vehicleImage,
              vehicleTag: widget.topupConclusion.vehicleTag,
              topupInstallmentNumber:
                  widget.topupConclusion.topupInstallmentNumber,
              actualAmount: widget.topupConclusion.actualAmount,
              topupDataConclusion: widget.topupConclusion.topupDataConclusion,
              insuranceAmt: widget.topupConclusion.insuranceAmt));
    }
  }

  void toggleCheckBox(
      {required String path,
      required TopupConsent topupConsentState,
      required bool isAccept}) {
    TopupConsent setted = getTopupConsent(
        isAccept: isAccept, pageName: path, topupConsent: topupConsentState);
    context.read<TopupBloc>().add(SetTopupConsent(topupConsent: setted));
  }

  Map<String, dynamic> getContsentMode(TopupConsent topupConsent) {
    return {
      'เอกสารสัญญา': topupConsent.contactDoccument,
      'ใบคำขอสินเชื่อ': topupConsent.contactRequst,
      'ใบรับเงิน': topupConsent.paySlip,
    };
  }

  Map<String, dynamic> getFilePath(DecodedTopupPdf decodedTopupPdf) {
    return {
      'เอกสารสัญญา': decodedTopupPdf.loanAgreement,
      'ใบคำขอสินเชื่อ': decodedTopupPdf.loan,
      'ใบรับเงิน': decodedTopupPdf.receipt,
    };
  }

  TopupConsent getTopupConsent(
      {required String pageName,
      required TopupConsent topupConsent,
      required bool isAccept}) {
    switch (pageName) {
      case 'ใบคำขอสินเชื่อ':
        return TopupConsent(
            contactDoccument: topupConsent.contactDoccument,
            contactRequst: isAccept,
            paySlip: topupConsent.paySlip);
      case 'ใบรับเงิน':
        return TopupConsent(
            contactDoccument: topupConsent.contactDoccument,
            contactRequst: topupConsent.contactRequst,
            paySlip: isAccept);
      case 'เอกสารสัญญา':
        return TopupConsent(
            contactDoccument: isAccept,
            contactRequst: topupConsent.contactRequst,
            paySlip: topupConsent.paySlip);
      default:
        return TopupConsent(
            contactDoccument: topupConsent.contactDoccument,
            contactRequst: topupConsent.contactRequst,
            paySlip: topupConsent.paySlip);
    }
  }

  bool isCurrentPageAccepted(
      {required String pageName, required TopupConsent topupConsent}) {
    switch (pageName) {
      case 'ใบคำขอสินเชื่อ':
        return topupConsent.contactRequst;
      case 'ใบรับเงิน':
        return topupConsent.paySlip;
      case 'เอกสารสัญญา':
        return topupConsent.contactDoccument;
      default:
        return false;
    }
  }

  Widget renderCheckBoxRow(TopupState state) {
    bool isChecked =
        getContsentMode(state.topupConsent)[widget.topupConclusion.appbarTitle]
            as bool;
    return Container(
      width: getActualWidth(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
              offset: Offset(0, 1),
              blurRadius: 10)
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(35, 28, 15, 28),
            child: Row(
              children: [
                isChecked
                    ? GestureDetector(
                        onTap: () => toggleCheckBox(
                            isAccept: false,
                            path: widget.topupConclusion.appbarTitle,
                            topupConsentState: state.topupConsent),
                        child: SvgPicture.asset('assets/CheckedEclipse.svg'))
                    : GestureDetector(
                        onTap: () => toggleCheckBox(
                            isAccept: true,
                            path: widget.topupConclusion.appbarTitle,
                            topupConsentState: state.topupConsent),
                        child: SvgPicture.asset('assets/UncheckedEclipse.svg')),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Container(
                      constraints: BoxConstraints(maxWidth: 250),
                      child: Text(
                        'ฉันยอมรับและได้อ่านเนื้อหาของเอกสารฉบับนี้ทั้งหมดแล้ว',
                        style: size14WNormal.merge(
                            TextStyle(height: 1.5, color: HexColor('#003063'))),
                      )),
                )
              ],
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${widget.topupConclusion.appbarTitle}',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
        ),
        backgroundColor: HexColor('#FFFFFF'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset('assets/back-icon.svg'),
        ),
      ),
      body: BlocBuilder<TopupBloc, TopupState>(
        builder: (context, state) {
          if (state is TopupLoading) {
            return ProgressLoading();
          }
          if (state is TopupError) {
            return Container();
          }
          if (state is TopupComplete) {
            return Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  PDFView(
                    fitPolicy: FitPolicy.WIDTH,
                    onRender: (pages) {
                      if (pages == 1) {
                        setState(() {
                          atBottom = true;
                        });
                      }
                    },
                    onPageChanged: (page, total) {
                      if (page == total! - 1) {
                        setState(() {
                          atBottom = true;
                        });
                      }
                    },
                    autoSpacing: false,
                    pageFling: false,
                    pageSnap: false,
                    filePath: getFilePath(state.decodedTopupPdf)[
                        widget.topupConclusion.appbarTitle],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        atBottom ? renderCheckBoxRow(state) : Container(),
                        Container(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          child: BootomButton(
                            onButtonTap: !isCurrentPageAccepted(
                                    pageName:
                                        widget.topupConclusion.appbarTitle,
                                    topupConsent: state.topupConsent)
                                ? () {}
                                : () => nagivateConclusionPage(
                                    state.topupConsent,
                                    state.decodedTopupPdf.topupPdfEncoded),
                            title: 'ถัดไป',
                            isOpacity: !isCurrentPageAccepted(
                                pageName: widget.topupConclusion.appbarTitle,
                                topupConsent: state.topupConsent),
                            decoration: false,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: Text('Error'),
          );
        },
      ),
    );
  }
}
