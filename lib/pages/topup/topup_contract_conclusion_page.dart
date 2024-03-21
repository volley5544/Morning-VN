import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_navigate.dart';

import '../../main.dart';
import '../../models/topup_data.dart';
import '../../models/topup_pdf.dart';
import '../../modules/topupRepo/index.dart';
import '../../services/localStorage/local_storage.dart';
import '../../util/check_string_format.dart';
import '../../util/currentcy_format.dart';
import '../../util/width_until.dart';
import '../../widgets/bottompage.dart';
import '../../widgets/loan_widgets/bootom_button.dart';
import '../../widgets/topic_widget.dart';
import '../loan_installment/loan_installment_payment_detail.dart';
import 'topup_controller.dart';
import 'topup_styling.dart';
import 'topup_widgets/back_account_infonaion.dart';

class TopupContractConclusion extends StatefulWidget {
  final TopupConclusion topupConclusion;
  final Widget? statusRenderer;
  const TopupContractConclusion(
      {Key? key, required this.topupConclusion, this.statusRenderer})
      : super(key: key);

  @override
  State<TopupContractConclusion> createState() =>
      _TopupContractConclusionState();
}

class _TopupContractConclusionState extends State<TopupContractConclusion> {
  final double prefixLineHeight = 24;
  final double prefixLineWidth = 3;
  TopupController topupController = TopupController();
  LocalStoragePrefernces localStoragePrefernces = LocalStoragePrefernces();
  TopupRepository topupRepository = TopupRepository();
  static const configKey = [
    {'label': 'ยอดจัดสินเชื่อ', 'valueField': 'amount'},
    {'label': 'ค่างวด', 'valueField': 'amount_per_installment_with_rate'},
    {'label': 'จำนวนงวด', 'valueField': 'installment_number'},
    {'label': 'ดอกเบี้ย', 'valueField': 'interest_rate'},
    {'label': 'จำนวนเงินที่จะได้รับ', 'valueField': 'total_amount_with_rate'},
  ];
  // static const suffixKey = [
  //   {'label': 'บาท'},
  //   {'label': 'บาท'},
  //   {'label': 'งวด'},
  //   {'label': '%'},
  //   {'label': 'บาท'},
  // ];
  static const docConfigKey = [
    {'label': 'ใบคำขอสินเชื่อ', 'valueField': 'amount'},
    {'label': 'ใบรับเงิน', 'valueField': 'registration_address'},
    {'label': 'เอกสารสัญญา', 'valueField': 'id_card_address'},
  ];

  Map<String, dynamic> getSuffix() {
    return {
      'amount': ' บาท',
      'amount_per_installment_with_rate': ' บาท',
      'installment_number': ' งวด',
      'interest_rate': '%',
      'total_amount_with_rate': ' บาท'
    };
  }

  Map<String, dynamic> setModelEncode(TopupData topupData, TopupState state) {
    return {
      'amount': convertDoubleCurrentcy(state.topupInstallmentNumber.amount),
      'amount_per_installment_with_rate': convertDoubleCurrentcy(
          widget.topupConclusion.selectedInstallmentNumber.regularPeriodAmt),
      'installment_number':
          widget.topupConclusion.selectedInstallmentNumber.tenor,
      'interest_rate':
          widget.topupConclusion.topupInstallmentNumber.interestRate,
      'total_amount_with_rate':
          convertDoubleCurrentcy(widget.topupConclusion.actualAmount),
    };
  }

  Widget rederTopupProperty(Map<String, String> key, TopupState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${key['label']}',
                  style: size14WNormal
                      .merge(TextStyle(color: HexColor('#404040')))),
              Row(
                children: [
                  Text(
                      '${setModelEncode(state.topupData, state)[key['valueField']]}${getSuffix()[key['valueField']]}',
                      style: size16WNormal.merge(TextStyle(
                          fontWeight: FontWeight.w600,
                          color: HexColor('#404040')))),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: HexColor('#E5E5E5'),
        )
      ],
    );
  }

  Widget acceptedDoc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: SvgPicture.asset('assets/acceptedCheck.svg'),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text(
            'ยอมรับแล้ว',
            style:
                primarySize14W500.merge(TextStyle(height: 0, letterSpacing: 0)),
          ),
        ),
        SvgPicture.asset(
          'assets/CaretRight.svg',
        )
      ],
    );
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

  Widget renderDocs(Map<String, String> key, TopupState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: GestureDetector(
        onTap: () => nagivateToDocPage(key['label'].toString(), false,
            state.decodedTopupPdf.topupPdfEncoded),
        child: Container(
          height: 66,
          width: widthAdjuster(
              screenWidth: MediaQuery.of(context).size.width, widthMod: 0.9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            border: Border.all(
              color: Color.fromRGBO(229, 229, 229, 1),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        'assets/DocumentIcon.svg',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3),
                      child: Text(
                        '${key['label']}',
                        style: size16WNormal
                            .merge(TextStyle(fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
                isCurrentPageAccepted(
                  pageName: key['label'].toString(),
                  topupConsent: state.topupConsent,
                )
                    ? acceptedDoc()
                    : SvgPicture.asset(
                        'assets/CaretRight.svg',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget renderStatus() {
    if (widget.statusRenderer != null) {
      return widget.statusRenderer!;
    } else {
      return Container();
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
          context.read<TopupBloc>().add(ReSetTopupComplete());
          if (transoNo != 'n' && transoNo != 'null') {
            ShowTopupiSuccessBottomBox(
                buttonContent: renderTopupSuccessButton(
                  context,
                  transoNo,
                  widget.topupConclusion.topupDataConclusion.dbName,
                  widget.topupConclusion.loanDetail,
                ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'สรุปรายละเอียดของสัญญา',
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
          icon: Icon(
            Icons.arrow_back,
            color: HexColor('#DB771A'),
          ),
        ),
      ),
      body: BlocBuilder<TopupBloc, TopupState>(
        builder: (context, state) {
          if (state is TopupError) {
            return Container();
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: HexColor('#FFFFFF'),
                    ),
                    child: Column(children: [
                      Container(
                        color: HexColor('#F5F5F5'),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 6),
                          child: LoanInstallPaymentDetail(
                            subTitle: 'ข้อมูลหลักประกัน',
                            contractCreateDate: widget
                                .topupConclusion
                                .loanDetail
                                .contractDetails
                                .collateralInformation,
                            contractName: widget.topupConclusion.loanDetail
                                .contractDetails.loanTypeName,
                            contractNo:
                                widget.topupConclusion.loanDetail.contractNo,
                            loanTypeIcon: widget.topupConclusion.loanDetail
                                .contractDetails.loanTypeIcon,
                          ),
                        ),
                      ),
                      renderStatus(),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Wrap(
                          children: [
                            TopicWidget(title: 'รายละเอียดสัญญา'),
                            ...(configKey.map((element) =>
                                rederTopupProperty(element, state))),
                          ],
                        ),
                      ),
                      TopicWidget(title: 'ข้อมูลเลขที่บัญชี'),
                      BackAccountInfomation(
                        branchImage:
                            widget.topupConclusion.loanDetail.branchImage,
                        contractBankAccount: widget
                            .topupConclusion.loanDetail.contractBankAccount,
                        contractBankBrandname: widget
                            .topupConclusion.loanDetail.contractBankBrandname,
                      ),
                      TopicWidget(title: 'เอกสารประกอบสัญญา'),
                      ...(docConfigKey.map((key) => renderDocs(key, state))),
                      Padding(
                        padding: const EdgeInsets.only(top: 32, bottom: 18),
                        child: Text(
                          ' ข้อมูลวันที่ ${formateBudDate(state.topupData.dataDate)} เวลา ${formateTime(state.topupData.dataDate)} น.',
                          // 'ข้อมูลวันที่ 14/06/2565 เวลา 20.43 น.',
                          style: TextStyle(
                              fontFamily: 'NotoSansThai',
                              fontSize: 12,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              BootomButton(
                //'ใบคำขอสินเชื่อ'
                onButtonTap: () => nagivateToDocPage(
                    topupController.getNextPage(state.topupConsent),
                    true,
                    state.decodedTopupPdf.topupPdfEncoded),
                title: 'ถัดไป',
                isOpacity: false,
              )
            ],
          );
        },
      ),
    );
  }
}
