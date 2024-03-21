class Installment {
  int amount = 0;
  int totalAmount = 0;
  String paidBeforeDate = '';

  Installment(
      {required this.amount,
      required this.totalAmount,
      required this.paidBeforeDate});
  factory Installment.fromJson(Map<String, dynamic> json) {
    return Installment(
        amount: json['amount'],
        totalAmount: json['total_amount'],
        paidBeforeDate: json['paid_before_date']);
  }
}

// class LoanPaymentDetail {
//   String contractName = '';
//   String contractNo = '';
//   String contractCreateDate = '';
//   String contractCloseDate = '';
//   String loanType = '';
//   String updateDate = '';
//   Installment installment =
//       Installment(amount: 0, totalAmount: 0, paidBeforeDate: '');

//   LoanPaymentDetail({
//     required this.contractName,
//     required this.contractNo,
//     required this.contractCreateDate,
//     required this.contractCloseDate,
//     required this.loanType,
//     required this.updateDate,
//     required this.installment,
//   });

//   factory LoanPaymentDetail.fromJson(Map<String, dynamic> json) {
//     // Installment localInstallment = json['installment'] as Installment;
//     return LoanPaymentDetail(
//         contractName: json['contract_name'],
//         contractNo: json['contract_no'],
//         contractCreateDate: json['contract_create_date'],
//         contractCloseDate: json['contract_close_date'],
//         loanType: json['loan_type'],
//         updateDate: json['update_date'],
//         installment: Installment.fromJson(json['installment']));
//   }
// }
