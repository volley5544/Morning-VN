import 'dart:io';

class TopupPdf {
  String loan;
  String receipt;
  String loanAgreement;

  TopupPdf({
    required this.loan,
    required this.receipt,
    required this.loanAgreement,
  });

  factory TopupPdf.fromJson(Map<String, dynamic> json) {
    return TopupPdf(
      loan: json['request'],
      receipt: json['receipt'],
      loanAgreement: json['agreement'],
    );
  }
}

class DecodedTopupPdf {
  String loan;
  String receipt;
  String loanAgreement;
  TopupPdf topupPdfEncoded;

  DecodedTopupPdf({
    required this.loan,
    required this.receipt,
    required this.loanAgreement,
    required this.topupPdfEncoded,
  });

  factory DecodedTopupPdf.fromJson(Map<String, dynamic> json) {
    return DecodedTopupPdf(
      loan: json['address_details'],
      receipt: json['address_sub_district'],
      loanAgreement: json['loan_agreement'],
      topupPdfEncoded: json[''],
    );
  }
}

class TopupSubmitForm {
  String contractNo;
  String dbName;
  String contractDate;
  String address;
  String name;
  double amount;
  String from;
  String contractBankAccount;
  String contractBankBrandname;
  String contractBankType;
  String contractBankBranch;
  String thaiId;
  double interestRate;
  int installmentNumber;
  double amountPerInstallment;
  String startInstallmentDate;
  String installmentDate;
  String vehicleType;
  String vehicleBrand;
  String vehicleModel;
  String vehicleColor;
  String vehicleProvince;
  String collateralInformation;
  String age;

  TopupSubmitForm({
    required this.contractNo,
    required this.dbName,
    required this.contractDate,
    required this.address,
    required this.name,
    required this.amount,
    required this.from,
    required this.contractBankAccount,
    required this.contractBankBrandname,
    required this.contractBankType,
    required this.contractBankBranch,
    required this.thaiId,
    required this.interestRate,
    required this.installmentNumber,
    required this.amountPerInstallment,
    required this.startInstallmentDate,
    required this.installmentDate,
    required this.vehicleType,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleColor,
    required this.vehicleProvince,
    required this.collateralInformation,
    required this.age,
  });
}

TopupSubmitForm topupSubmitForm = TopupSubmitForm(
    address: '',
    age: '',
    amount: 0,
    amountPerInstallment: 0,
    collateralInformation: '',
    contractBankAccount: '',
    contractBankBranch: '',
    contractBankBrandname: '',
    contractBankType: '',
    contractDate: '',
    contractNo: '',
    dbName: '',
    from: '',
    installmentDate: '',
    installmentNumber: 0,
    interestRate: 0,
    name: '',
    startInstallmentDate: '',
    thaiId: '',
    vehicleBrand: '',
    vehicleColor: '',
    vehicleModel: '',
    vehicleProvince: '',
    vehicleType: '');
