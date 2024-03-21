class ContactDetailModel {
  String collateralInformation;
  ContactDetailModel({
    required this.collateralInformation,
  });
  factory ContactDetailModel.fromJson(Map<String, dynamic> json) {
    return ContactDetailModel(
        collateralInformation: json['collateral_information']);
  }
}

class TopupDetailStatusModel {
  String contractName;
  String contractNo;
  String contractBankAccount;
  String contractBankBrandname;
  String loanTypeCode;
  String loanTypeName;
  String loanTypeIcon;
  String requestDate;
  String requestStatus;
  String collateralInformationl;
  double amount;
  double amountPerInstallment;
  int installmentNumber;
  double totalAmountWithRate;
  double interestRate;
  String topupRequestFile;
  String topupArgeementFile;
  String topupReceiptFile;
  String branchImage;
  int actualReceiveAmount;
  TopupDetailStatusModel({
    required String this.contractName,
    required String this.contractNo,
    required String this.contractBankAccount,
    required String this.contractBankBrandname,
    required String this.loanTypeCode,
    required String this.loanTypeName,
    required String this.loanTypeIcon,
    required String this.requestDate,
    required String this.requestStatus,
    required String this.collateralInformationl,
    required double this.amount,
    required double this.amountPerInstallment,
    required int this.installmentNumber,
    required double this.totalAmountWithRate,
    required double this.interestRate,
    required String this.topupRequestFile,
    required String this.topupArgeementFile,
    required String this.topupReceiptFile,
    required String this.branchImage,
    required int this.actualReceiveAmount,
  });

  factory TopupDetailStatusModel.fromJson(Map<String, dynamic> json) {
    return TopupDetailStatusModel(
      contractName: json['contract_name'],
      contractNo: json['contract_no'],
      contractBankAccount: json['contract_bank_account'],
      contractBankBrandname: json['contract_bank_brandname'],
      loanTypeCode: json['loan_type_code'],
      loanTypeName: json['loan_type_name'],
      loanTypeIcon: json['loan_type_icon'],
      requestDate: json['request_date'],
      requestStatus: json['request_status'],
      collateralInformationl: json['collateral_information'],
      amount: json['amount'].toDouble(),
      amountPerInstallment: json['amount_per_installment'].toDouble(),
      installmentNumber: json['installment_number'],
      totalAmountWithRate: json['total_amount_with_rate'].toDouble(),
      interestRate: json['interest_rate'].toDouble(),
      topupRequestFile: json['topup_request_file'],
      topupArgeementFile: json['topup_argeement_file'],
      topupReceiptFile: json['topup_receipt_file'],
      branchImage: json['branch_image'],
      actualReceiveAmount: json['actual_receive_amount'],
    );
  }
}
