import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/util/text_field_controller.dart';

import '../../../models/loan_detail.dart';
import '../../../models/topup_data.dart';
import '../../../models/topup_installment_number.dart';
import '../../../util/color_util.dart';
import '../../../util/currentcy_format.dart';
import '../../../util/width_until.dart';
import '../topup_styling.dart';

class NewTopupDetail extends StatefulWidget {
  final TopupState topupState;
  final LoanDetail loanDetail;
  final Function onNumberChamge;
  final TextEditingController controller;
  final bool isWarning;
  final bool isShowMinwarning;
  final bool isRenderInstallmentNumber;
  final FocusNode focusNode;
  final TopupInstallmentNumber installmentNumber;
  final double actualRecieveAmount;
  final CurrencyTextInputFormatter creditLimitFormatter;
  final bool isInsuranceSelected;
  final Function setInsuranceSelected;
  const NewTopupDetail({
    Key? key,
    required this.topupState,
    required this.loanDetail,
    required this.onNumberChamge,
    required this.controller,
    required this.isWarning,
    required this.focusNode,
    required this.isRenderInstallmentNumber,
    required this.installmentNumber,
    required this.actualRecieveAmount,
    required this.isShowMinwarning,
    required this.creditLimitFormatter,
    required this.setInsuranceSelected,
    required this.isInsuranceSelected,
  }) : super(key: key);

  @override
  State<NewTopupDetail> createState() => _NewTopupDetailState();
}

class _NewTopupDetailState extends State<NewTopupDetail> {
  // FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  static const configKey = [
    {'label': 'ยอดปิดสัญญาเก่า', 'valueField': 'left_over_paid'},
    {'label': 'จำนวนงวด', 'valueField': 'installment_number'},
    {'label': 'ค่างวด', 'valueField': 'amount_per_installment'},
  ];
  Map<String, dynamic> setModelEncode(TopupData topupData) {
    return {
      'left_over_paid':
          convertDoubleCurrentcy(topupData.contractDetails.closingBalance),
      'installment_number': topupData.installmentNumber,
      'amount_per_installment':
          convertDoubleCurrentcy(topupData.installmentAmount),
    };
  }

  Map<String, dynamic> textFieldSuffix() {
    return {
      'left_over_paid': 'บาท',
      'installment_number': 'งวด',
      'amount_per_installment': 'บาท'
    };
  }

  Widget renderTopupProperty(Map<String, String> key, TopupState state) {
    bool isLeftOver = key['valueField'] == 'left_over_paid';
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, isLeftOver ? 1 : 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${key['label']}',
                  style: size14WNormal
                      .merge(TextStyle(color: HexColor('#404040')))),
              Text(
                  '${setModelEncode(state.topupData)[key['valueField']]} ${textFieldSuffix()[key['valueField']]}',
                  style: size16WNormal.merge(TextStyle(
                      fontWeight: FontWeight.w600,
                      color: HexColor('#404040')))),
            ],
          ),
        ),
        if (isLeftOver)
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 8),
            child: SizedBox(
              width: double.infinity,
              child: Text('*ยอดปิดคำนวณ ณ วันเวลาที่ทำรายการ'),
            ),
          ),
        Container(
          height: 1,
          color: HexColor('#E5E5E5'),
        )
      ],
    );
  }

  Widget titileWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 22, top: 20, bottom: 10),
      child: Text(
        'รายละเอียดการขอสินเชื่อ',
        style: size16WNormal.merge(
            TextStyle(fontWeight: FontWeight.w600, color: HexColor('#003063'))),
      ),
    );
  }

  Widget renderInstallmentData(Map<String, String> key,
      TopupInstallmentNumber state, TopupData topupData) {
    bool isLeftOver = key['valueField'] == 'left_over_paid';
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, isLeftOver ? 1 : 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${key['label']}',
                  style: size16WNormal
                      .merge(TextStyle(color: HexColor('#404040')))),
              Text(
                  '${setInstallmentModel(state, topupData)[key['valueField']]} ${textFieldSuffix()[key['valueField']]}',
                  style: size16WNormal.merge(TextStyle(
                      fontWeight: FontWeight.w600,
                      color: HexColor('#404040')))),
            ],
          ),
        ),
        if (isLeftOver)
          Padding(
            padding: const EdgeInsets.only(left: 24, bottom: 8),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                '*ยอดปิดคำนวณ ณ วันเวลาที่ทำรายการ',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        Container(
          height: 1,
          color: HexColor('#E5E5E5'),
        )
      ],
    );
  }

  Map<String, dynamic> setInstallmentModel(
      TopupInstallmentNumber topupInstallmentNumber, TopupData topupData) {
    int installemntLength = topupInstallmentNumber.installments.length - 1;
    return {
      'left_over_paid':
          convertDoubleCurrentcy(topupData.contractDetails.closingBalance),
      'installment_number':
          topupInstallmentNumber.installments[installemntLength].tenor,
      'amount_per_installment': convertDoubleCurrentcy(topupInstallmentNumber
          .installments[installemntLength].regularPeriodAmt),
    };
  }

  Widget textColorSeter(String value) {
    return Text(value, style: TextStyle(color: Color.fromRGBO(64, 64, 64, 1)));
  }

  Widget selectableInsurance() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: widget.setInsuranceSelected(),
            child: Container(
              height: 64,
              width: widthAdjuster(
                  screenWidth: MediaQuery.of(context).size.width,
                  widthMod: 0.9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                border: Border.all(
                  color: widget.isInsuranceSelected
                      ? HexColor('#DB771A')
                      : Color.fromRGBO(229, 229, 229, 1),
                  width: widget.isInsuranceSelected ? 2 : 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: widget.isInsuranceSelected
                              ? SvgPicture.asset(
                                  'assets/CheckedEclipse.svg',
                                  width: 16,
                                  height: 16,
                                )
                              : SvgPicture.asset(
                                  'assets/UncheckedEclipse.svg',
                                  width: 16,
                                  height: 16,
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            'ค่าประกันวงเงิน',
                            style: widget.isInsuranceSelected
                                ? size16PromaryW500
                                : size16BlueW500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '฿${convertDoubleCurrentcyNoDecimal(parDoubleSafty(widget.topupState.topupData.lifeInsureAmt))}',
                      style:
                          TextStyle(fontSize: 16, color: HexColor('#404040')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthAdjuster(screenWidth: MediaQuery.of(context).size.width),
      decoration: BoxDecoration(
        color: HexColor('#FFFFFF'),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.16),
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      // color: HexColor('#FFFFFF'),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 24.0, right: (isWidthTooLong == true ? 0 : 24)),
              child: Wrap(
                children: [
                  textColorSeter('ยอดขอสินเชื่อใหม่'),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                        width: widthAdjuster(
                            screenWidth:
                                MediaQuery.of(context).size.width * 0.88),
                        child: CurrencyInputField(
                          onNumberChamge: widget.onNumberChamge,
                          controller: widget.controller,
                          focusNode: widget.focusNode,
                          labelText: 'Enter amount',
                          topupState: widget.topupState,
                        )),
                  ),
                  widget.isShowMinwarning
                      ? Text(
                          'จำนวนเงินต้องไม่น้อยกว่า ${convertDoubleCurrentcy(widget.topupState.topupData.minTopupAmount)} บาท',
                          style: warning12CRed)
                      : Container(),
                  widget.isWarning
                      ? Text(
                          'จำนวนเงินต้องไม่เกิน ${convertCurrentcy(widget.topupState.topupData.maxTopupAmount.toInt())} บาท',
                          style: warning12CRed)
                      : Container()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 33),
                    child: Text(
                      'เงื่อนไข',
                      style: size12Wnormal.merge(TextStyle(
                        color: Color.fromRGBO(218, 119, 26, 1),
                      )),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: size12Wnormal.merge(
                          TextStyle(color: HexColor('#8B99A7'), height: 1.5)),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              'คุณสามารถแก้ไขยอดขอสินเชื่อใหม่ได้ แต่จำนวนเงินต้องไม่เกิน ',
                        ),
                        TextSpan(
                          text:
                              '${convertDoubleCurrentcy(widget.topupState.topupData.maxTopupAmount)} บาท ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '(ยอดจัดสินเชื่อ ระบบจะปัดเป็นจำนวนเต็มร้อยเท่านั้น)',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 15,
                  bottom: 20,
                  left: 24.0,
                  right: (isWidthTooLong == true ? 0 : 24)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('รวมยอดจัดสินเชื่อ',
                      style: size14WNormal
                          .merge(TextStyle(color: HexColor('#404040')))),
                  widget.isInsuranceSelected
                      ? Text(
                          '${convertDoubleCurrentcy(parDoubleSafty(widget.controller.text.replaceAll(',', '')) + parDoubleSafty(widget.topupState.topupData.lifeInsureAmt))} บาท',
                          style: size16WNormal.merge(TextStyle(
                              fontWeight: FontWeight.w600,
                              color: HexColor('#003063'))))
                      : Text(
                          '${convertDoubleCurrentcy(parDoubleSafty(widget.controller.text.replaceAll(',', '')))} บาท',
                          style: size16WNormal.merge(TextStyle(
                              fontWeight: FontWeight.w600,
                              color: HexColor('#003063')))),
                ],
              ),
            ),
            Container(
              height: 5,
              width: double.infinity,
              color: HexColor("#E6E6E6"),
            ),
            widget.isRenderInstallmentNumber
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titileWidget(),
                      ...(configKey.map((key) => renderInstallmentData(
                          key,
                          widget.installmentNumber,
                          widget.topupState.topupData)))
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titileWidget(),
                      ...(configKey.map((key) =>
                          renderTopupProperty(key, widget.topupState))),
                    ],
                  )
          ])),
    );
  }
}
