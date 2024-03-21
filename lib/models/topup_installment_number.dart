import 'dart:convert';

class TopupInstallmentNumber {
  late String code;
  late String message;
  late String transNo;
  late String contractNo;
  late String firstDueDate;
  late double amount;
  late double interestRate;
  late double topupFeeAmount;
  late double feeAmount;
  late List<Installments> installments;

  TopupInstallmentNumber(
      {required this.code,
      required this.message,
      required this.transNo,
      required this.contractNo,
      required this.firstDueDate,
      required this.amount,
      required this.interestRate,
      required this.topupFeeAmount,
      required this.feeAmount,
      required this.installments});

  factory TopupInstallmentNumber.fromJson(Map<String, dynamic> json) {
    return TopupInstallmentNumber(
        amount: json['amount'].toDouble(),
        code: json['code'],
        contractNo: json['contract_no'],
        feeAmount: json['fee_amount'].toDouble(),
        firstDueDate: json['first_due_date'],
        installments: (json['installments'] as List<dynamic>)
            .map((e) => Installments.fromJson(e as Map<String, dynamic>))
            .toList(),
        interestRate: json['interest_rate'].toDouble(),
        message: json['message'],
        topupFeeAmount: json['topup_fee_amount'].toDouble(),
        transNo: json['trans_no']);
  }
}

class Installments {
  late int tenor;
  late double firstPeriodAmt;
  late double regularPeriodAmt;
  late double lastPeriodAmt;
  late double totalAmt;
  late double intAmt;
  late double lastPeriodPromo;

  Installments(
      {required this.tenor,
      required this.firstPeriodAmt,
      required this.regularPeriodAmt,
      required this.lastPeriodAmt,
      required this.totalAmt,
      required this.intAmt,
      required this.lastPeriodPromo});

  factory Installments.fromJson(Map<String, dynamic> json) {
    return Installments(
        firstPeriodAmt: json['firstPeriodAmt'].toDouble(),
        intAmt: json['intAmt'].toDouble(),
        lastPeriodAmt: json['lastPeriodAmt'].toDouble(),
        lastPeriodPromo: json['lastPeriodPromo'].toDouble(),
        regularPeriodAmt: json['regularPeriodAmt'].toDouble(),
        tenor: json['tenor'],
        totalAmt: json['totalAmt'].toDouble());
  }
}
