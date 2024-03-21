import 'payment_detail.dart';

class ContractDetails {
  String collateralInformation;
  String licensePlateProvince;
  String licensePlateExpireDate;
  String vehicleBrand;
  ContractDetails({
    required this.collateralInformation,
    required this.licensePlateProvince,
    required this.licensePlateExpireDate,
    required this.vehicleBrand,
  });
  factory ContractDetails.fromJson(Map<String, dynamic> json) {
    return ContractDetails(
      collateralInformation: json['collateral_information'],
      licensePlateProvince: json['license_plate_province'],
      licensePlateExpireDate: json['license_plate_expire_date'],
      vehicleBrand: json['vehicle_brand'],
    );
  }
}

class MyLoanDetail {
  String currentInstallmentAmount;
  String installmentNumber;
  String totalInstallment;
  int totalPaidAmount;
  int totalPayBalanceLeftAmount;
  int totalLoanBalanceAmount;
  String payBeforeDate;
  String overdueDays;
  String latestPaidDate;
  MyLoanDetail({
    required this.currentInstallmentAmount,
    required this.installmentNumber,
    required this.totalInstallment,
    required this.totalPaidAmount,
    required this.totalPayBalanceLeftAmount,
    required this.totalLoanBalanceAmount,
    required this.payBeforeDate,
    required this.overdueDays,
    required this.latestPaidDate,
  });
  factory MyLoanDetail.fromJson(Map<String, dynamic> json) {
    return MyLoanDetail(
        currentInstallmentAmount: json['current_installment_amount'],
        installmentNumber: json['installment_number'],
        totalInstallment: json['total_installment'],
        totalPaidAmount: json['total_paid_amount'],
        totalPayBalanceLeftAmount: json['total_pay_balance_left_amount'],
        totalLoanBalanceAmount: json['total_loan_balance_amount'],
        payBeforeDate: json['pay_before_date'],
        overdueDays: json['overdue_days'],
        latestPaidDate: json['latest_paid_date']);
  }
}

class LoanInstallmentDetailMedel {
  // String contractCloseDate;
  // String contractName;
  // String contractNo;
  // String contractBankAccount;
  String code;
  String message;
  int total;
  // List paymentAccountData;
  List<PaymentAccountData> paymentAccountData;

  LoanInstallmentDetailMedel({
    required this.code,
    required this.message,
    required this.total,
    required this.paymentAccountData,
  });

  List<PaymentAccountData> setAccList(
      Map<String, dynamic>? json, List<PaymentAccountData> payList) {
    // List<PaymentAccountData> accounts = [];
    if (json != null) {
      json['accounts'].forEach((v) {
        payList.add(new PaymentAccountData.fromJson(v));
      });
    }
    return payList;
  }

  factory LoanInstallmentDetailMedel.fromJson(Map<String, dynamic> json) {
    List<PaymentAccountData> payList = [];
    json['accounts'].forEach((v) {
      payList.add(new PaymentAccountData.fromJson(v));
    });
    return LoanInstallmentDetailMedel(
        code: json['code'],
        message: json['message'],
        total: json['total'],
        paymentAccountData: payList
        // paymentAccountData: setAccList(json['accounts']),
        );
  }
}

LoanInstallmentDetailMedel loanInstallmentDetailMedelDefault =
    LoanInstallmentDetailMedel(
        code: '', message: '', paymentAccountData: [], total: 0);
