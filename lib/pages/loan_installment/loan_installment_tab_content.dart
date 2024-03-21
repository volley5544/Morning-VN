import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_history_bloc/loan_history_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_installment_bloc/loan_installment_bloc.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/models/loan_detail_history.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/loan_installment_conclusion_detail.dart';
import 'package:mobile_application_srisawad/util/currentcy_format.dart';

import '../../main.dart';
import '../../util/check_string_format.dart';
import '../../util/logger_service.dart';

class LoanInstallTabContent extends StatelessWidget {
  final LoanDetail loanDetail;
  final List<String> loanDetailKeys;
  final BuildContext context;
  final String focusedOption;
  final LoanInstallmentState state;
  final double heightAllComponents;
  LoanInstallTabContent(
      {Key? key,
      required this.loanDetail,
      required this.loanDetailKeys,
      required this.context,
      required this.focusedOption,
      required this.state,
      required this.heightAllComponents})
      : super(key: key);

  Widget dividerLine() {
    return Container(
      width: getActualWidth(context),
      height: 1,
      color: HexColor('#E5E5E5'),
    );
  }

  Widget loanDetailStringField(
      String keyText, String content, String rearText) {
    TextStyle textStyleLeft = const TextStyle(
        color: Color.fromRGBO(64, 64, 64, 1),
        fontFamily: 'NotoSansThai',
        fontSize: 14,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
        height: 1);
    TextStyle textStyleRight = const TextStyle(
        color: Color.fromRGBO(64, 64, 64, 1),
        fontFamily: 'NotoSansThai',
        fontSize: 16,
        letterSpacing: 0,
        fontWeight: FontWeight.w600,
        height: 1);
    return Column(
      children: [
        Container(
          color: HexColor('#FFFFFF'),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 27, 27, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(keyText, style: textStyleLeft),
                Row(
                  children: [
                    Text(
                      content,
                      style: textStyleRight,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(
                        rearText,
                        style: textStyleRight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        dividerLine()
      ],
    );
  }

  int getIntData(String value) {
    try {
      return int.parse(value);
    } catch (e) {
      logger.e('Catch on $value');
      return 0;
    }
  }

  double getDoubleData(String value) {
    return double.parse(value);
  }

  String getStringData(String value) {
    return value.toString();
  }

  Widget loanDetailIntField(
      String keyText, String content, String rearText, String dataType) {
    TextStyle textStyleLeft = const TextStyle(
        color: Color.fromRGBO(64, 64, 64, 1),
        fontFamily: 'NotoSansThai',
        fontSize: 14,
        letterSpacing: 0,
        fontWeight: FontWeight.normal,
        height: 1);
    TextStyle textStyleRight = const TextStyle(
        color: Color.fromRGBO(64, 64, 64, 1),
        fontFamily: 'NotoSansThai',
        fontSize: 16,
        letterSpacing: 0,
        fontWeight: FontWeight.w600,
        height: 1);
    return Column(
      children: [
        Container(
          color: HexColor('#FFFFFF'),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 21, 27, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(keyText, style: textStyleLeft),
                Row(
                  children: [
                    dataType == 'int'
                        ? Text(convertCurrentcy(getIntData(content)),
                            style: textStyleRight)
                        : dataType == 'String'
                            ? Text(getStringData(content),
                                style: textStyleRight)
                            : Text(
                                convertDoubleCurrentcy(double.parse(content))
                                    .toString(),
                                style: textStyleRight),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text(rearText, style: textStyleRight),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        dividerLine()
      ],
    );
  }

  Map<String, dynamic> configValueSuffix() {
    return {
      'os_balance': 'บาท',
      'total_loan_balance_amount': 'บาท',
      'current_installment_amount': 'บาท',
      'total_installment': 'งวด',
      'contract_branch_created_name': '',
      'contract_create_date': '',
      'loan_type_name': '',
      'vehicle_brand': '',
      'vehicle_model': '',
      'car_cc': '',
      'collateral_information': '',
      'start_date': '',
      'contract_close_date': '',
      'interest_rate_per_month': ''
    };
  }

  Map<String, dynamic> configSuffix() {
    return {
      'os_balance': 'double',
      'total_loan_balance_amount': 'double',
      'current_installment_amount': 'double',
      'total_installment': 'String',
      'contract_branch_created_name': 'String',
      'contract_create_date': 'String',
      'loan_type_name': 'String',
      'vehicle_brand': 'String',
      'vehicle_model': 'String',
      'car_cc': 'String',
      'collateral_information': 'String',
      'start_date': 'String',
      'contract_close_date': 'String',
      'interest_rate_per_month': 'String'
    };
  }

  Map<String, dynamic> getPaymentData(
      LoanDetail loanDetail, LoanInstallmentState state) {
    return {
      'os_balance': state.loanInstallmentDetail.paymentAccountData[0]
          .listPaymentDetails.osBalance,
      'total_loan_balance_amount': loanDetail.contractDetails.creditLimit,
      'current_installment_amount':
          loanDetail.contractDetails.installmentAmount,
      'total_installment': loanDetail.paymentDetails.totalInstallment,
      'contract_branch_created_name':
          '${loanDetail.branchName} (${loanDetail.branchCode})',
      'contract_create_date': formateBudDate(loanDetail.contractCreateDate),
      'loan_type_name': loanDetail.contractDetails.loanTypeName,
      'vehicle_brand': loanDetail.contractDetails.vehicleBrand.trim(),
      'vehicle_model': state.loanInstallmentDetail.paymentAccountData.isNotEmpty
          ? state
              .loanInstallmentDetail.paymentAccountData[0].carDetails.carSeries
          : '-',
      'car_cc': state.loanInstallmentDetail.paymentAccountData.isNotEmpty
          ? state.loanInstallmentDetail.paymentAccountData[0].carDetails.carCc
          : '-',
      'collateral_information':
          loanDetail.contractDetails.collateralInformation,
      'start_date': formateBudDate(state.loanInstallmentDetail
          .paymentAccountData[0].contractDetails.firstDueDate),
      'contract_close_date': formateBudDate(state.loanInstallmentDetail
          .paymentAccountData[0].contractDetails.lastDueDate),
      'interest_rate_per_month': state
              .loanInstallmentDetail.paymentAccountData.isNotEmpty
          ? '${convertDoubleCurrentcy(state.loanInstallmentDetail.paymentAccountData[0].contractDetails.monthlyInterestRate ?? 0.0)}%'
          : '-',
    };
  }

  static const keyLabel = [
    {'label': 'ยอดหนี้คงเหลือ', 'valueField': 'os_balance'},
    {'label': 'ยอดจัดสินเชื่อ', 'valueField': 'total_loan_balance_amount'},
    {'label': 'ค่างวด', 'valueField': 'current_installment_amount'},
    {'label': 'จำนวนงวด', 'valueField': 'total_installment'},
    {'label': 'สาขาที่ทำสัญญา', 'valueField': 'contract_branch_created_name'},
    {'label': 'วันที่ทำสัญญา', 'valueField': 'contract_create_date'},
    {'label': 'กลุ่มสินค้า', 'valueField': 'loan_type_name'},
    {'label': 'ยี่ห้อสินค้า', 'valueField': 'vehicle_brand'},
    {'label': 'รุ่นสินค้า', 'valueField': 'vehicle_model'},
    {'label': 'รายละเอียดสินค้า', 'valueField': 'car_cc'},
    {'label': 'เลขทะเบียน', 'valueField': 'collateral_information'},
    {'label': 'วันเริ่มงวดแรก', 'valueField': 'start_date'},
    {'label': 'วันงวดสุดท้าย', 'valueField': 'contract_close_date'},
    {'label': 'อัตราดอกเบี้ยต่อเดือน', 'valueField': 'interest_rate_per_month'},
  ];

  Widget loanDetailWidget() {
    // TODO: [Saksit] forgot interest_rate_per_month
    switch (state.runtimeType) {
      case LoadLoanInstallmentDetailLoading:
        return SizedBox(
          height: 200,
          child: Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(219, 119, 26, 1),
          )),
        );
      case LoadLoanInstallmentDetailComplete:
        return Column(children: [
          ...(keyLabel.map((key) => loanDetailIntField(
              '${key['label']}',
              getPaymentData(loanDetail, state)[key['valueField']].toString(),
              configValueSuffix()[key['valueField']],
              configSuffix()[key['valueField']]))),
          Container(
            color: HexColor('#FFFFFF'),
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Center(
                child: Text(
                  ' ข้อมูลวันที่ ${formateBudDate(loanDetail.dataDate)} เวลา ${formateTime(loanDetail.dataDate)} น.',
                  // 'ข้อมูลวันที่ 14/06/2565 เวลา 20.43 น.',
                  style: TextStyle(
                      color: Color.fromRGBO(138, 152, 167, 1),
                      fontFamily: 'NotoSansThai',
                      fontSize: 12,
                      letterSpacing: 0,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
            ),
          )
        ]);
      case LoadLoanInstallmentDetailError:
        return Container();
      default:
        return Container();
    }
  }

  Widget loanPayDetail() {
    switch (state.runtimeType) {
      case LoadLoanInstallmentDetailLoading:
        return SizedBox(
          height: 200,
          child: Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(219, 119, 26, 1),
          )),
        );
      case LoadLoanInstallmentDetailComplete:
        return Container(
          child: Column(children: [
            loanDetailIntField(
                'ชำระค่างวดแล้ว',
                convertDoubleCurrentcy(
                        loanDetail.paymentDetails.totalPaidAmount)
                    .toString(),
                'บาท',
                'String'),
            // TODO saksit totalLoanBalanceAmount is no longer used
            loanDetailIntField(
                'จำนวนวันที่ค้าง',
                loanDetail.paymentDetails.overdueDays.toString(),
                'วัน',
                'String'),
            // TODO Chaange calue to the updated value from the api anmed overdue_term
            loanDetailStringField('จำนวนงวดที่ค้าง',
                loanDetail.paymentDetails.overdueTerm.toString(), 'งวด'),
            loanDetailStringField('วันชำระครั้งล่าสุด',
                formateBudDate(loanDetail.paymentDetails.latestPaidDate), ''),
            Container(
              color: HexColor('#FFFFFF'),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Center(
                  child: Text(
                    ' ข้อมูลวันที่ ${formateBudDate(loanDetail.dataDate)} เวลา ${formateTime(loanDetail.dataDate)} น.',
                    // 'ข้อมูลวันที่ 14/06/2565 เวลา 20.43 น.',
                    style: TextStyle(
                        color: Color.fromRGBO(138, 152, 167, 1),
                        fontFamily: 'NotoSansThai',
                        fontSize: 12,
                        letterSpacing: 0,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ),
              ),
            )
          ]),
        );
      case LoadLoanInstallmentDetailError:
        return Container();
      default:
        return Container();
    }
  }

  Widget loanHistoryDetail(HistoryResult historyResult) {
    return LoanInstallmentConclusionDetail(
      // loanInstallmentDetail: loanInstallmentDetail,
      leftTitle: 'วันที่ชำระ',
      leftContent: formateBudDate(historyResult.paidDate),
      rightTitle: 'ยอดที่ชำระ',
      rightContent: convertDoubleCurrentcy(historyResult.amount),
      cardWidth: getActualWidth(context) * 0.95,
    );
  }

  Widget renderLoanHistory(
      List<HistoryResult> loanDetailHistory, historyState) {
    switch (historyState.runtimeType) {
      case LoadLoanInstallmenHistoryLoading:
        return SizedBox(
          height: 200,
          child: Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(219, 119, 26, 1),
          )),
        );
      case LoadLoanInstallmenHistoryComplete:
        if (loanDetailHistory.isEmpty) {
          return Container(
            height: MediaQuery.of(context).size.height - heightAllComponents,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ไม่มีประวัติการชำระ',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              ...(historyState.loanDetailHistory
                  .map((e) => loanHistoryDetail(e)))
            ],
          );
        }
      case LoadLoanInstallmentHistoryError:
        return Container();
      default:
        return Container();
    }
  }

  Widget componentOptions() {
    switch (focusedOption) {
      case 'ข้อมูลสินเชื่อ':
        return loanDetailWidget();
      case 'ข้อมูลการชำระ':
        return loanPayDetail();
      case 'ประวัติการชำระ':
        return BlocBuilder<LoanHistoryBloc, LoanHistoryState>(
          builder: (context, state) {
            return renderLoanHistory(state.loanDetailHistory, state);
          },
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
      child: componentOptions(),
    ));
  }
}
