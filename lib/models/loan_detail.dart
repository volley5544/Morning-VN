class LoanListContractDetails {
  double closingBalance;
  String comcode;
  String branchCode;
  String branchName;
  String canTopup;
  String collateralInformation;
  String licensePlateProvince;
  String licensePlateExpireDate;
  String vehicleBrand;
  double currentLtvAmount;
  double creditLimit;
  double financeAmount;
  double osBalance;
  double currentDueAmount;
  String currentDueDate;
  String accountStatus;
  String loanTypeCode;
  String loanTypeName;
  String loanTypeIcon;
  double installmentAmount;
  LoanListContractDetails({
    required this.closingBalance,
    required this.comcode,
    required this.branchCode,
    required this.branchName,
    required this.canTopup,
    required this.collateralInformation,
    required this.licensePlateProvince,
    required this.licensePlateExpireDate,
    required this.vehicleBrand,
    required this.currentLtvAmount,
    required this.creditLimit,
    required this.financeAmount,
    required this.osBalance,
    required this.currentDueAmount,
    required this.currentDueDate,
    required this.accountStatus,
    required this.loanTypeCode,
    required this.loanTypeName,
    required this.loanTypeIcon,
    required this.installmentAmount,
  }); //
  factory LoanListContractDetails.fromJson(Map<String, dynamic> json) {
    return LoanListContractDetails(
      closingBalance: json['closing_balance'].toDouble(),
      comcode: json['comcode'],
      branchCode: json['branch_code'],
      branchName: json['branch_name'],
      installmentAmount: json['installment_amount'].toDouble(),
      canTopup: json['can_topup'],
      collateralInformation: json['collateral_information'],
      licensePlateProvince: json['license_plate_province'],
      licensePlateExpireDate: json['license_plate_expire_date'],
      vehicleBrand: json['vehicle_brand'],
      currentLtvAmount: json['current_ltv_amount'].toDouble(),
      creditLimit: json['credit_limit'].toDouble(),
      financeAmount: json['finance_amount'].toDouble(),
      osBalance: json['os_balance'].toDouble(),
      currentDueAmount: json['current_due_amount'].toDouble(),
      currentDueDate: json['current_due_date'],
      accountStatus: json['account_status'],
      loanTypeCode: json['loan_type_code'],
      loanTypeName: json['loan_type_name'],
      loanTypeIcon: json['loan_type_icon'],
    );
  }
}

class LoanListPaymentDetails {
  double currentInstallmentAmount;
  // double installmentAmount;
  int currentInstallmentNumber;
  int totalInstallment;
  double totalPaidAmount;
  double osBalance;
  // int totalLoanBalanceAmount;
  String payBeforeDate;
  int overdueDays;
  int overdueTerm;
  String latestPaidDate;
  LoanListPaymentDetails({
    required this.currentInstallmentAmount,
    // required this.installmentAmount,
    required this.currentInstallmentNumber,
    required this.totalInstallment,
    required this.totalPaidAmount,
    required this.osBalance,
    // required this.totalLoanBalanceAmount,
    required this.payBeforeDate,
    required this.overdueDays,
    required this.overdueTerm,
    required this.latestPaidDate,
  });
  factory LoanListPaymentDetails.fromJson(Map<String, dynamic> json) {
    return LoanListPaymentDetails(
      currentInstallmentAmount: json['current_due_amount'].toDouble(),
      // installmentAmount: json['installment_amount'].toDouble(),
      currentInstallmentNumber: json['current_installment_number'],
      totalInstallment: json['total_installment_number'],
      payBeforeDate: json['current_due_date'],
      totalPaidAmount: json['total_paid_amount'].toDouble(),
      osBalance: json['os_balance'].toDouble(),
      // totalLoanBalanceAmount: 10000,
      overdueDays: json['overdue_days'],
      overdueTerm: json['overdue_terms'],
      latestPaidDate: json['latest_paid_date'],
    );
  }
}

class TopupDetail {
  String canTopup;
  // TODO saksit check if rthis field has to be used in topup detail page as a default value
  double defaultTopupAmount;
  double installmentNumber;
  double currentLtvAmount;
  // String accountStatus;
  TopupDetail({
    required this.canTopup,
    required this.defaultTopupAmount,
    required this.installmentNumber,
    required this.currentLtvAmount,
    // required this.accountStatus,
  });
  factory TopupDetail.fromJson(Map<String, dynamic> json) {
    return TopupDetail(
      canTopup: json['can_topup'],
      defaultTopupAmount: json['default_topup_amount'].toDouble(),
      installmentNumber: json['total_installment_number'].toDouble(),
      currentLtvAmount: json['current_ltv_amount'].toDouble(),
      // accountStatus: json['account_status'],
    );
  }
}

class LoanDetail {
  String contractName;
  String branchCode;
  String branchName;
  String branchImage;
  String dbName;
  String contractNo;
  String contractBankAccount;
  String contractBankBrandname;
  String contractBankType;
  LoanListContractDetails contractDetails;
  String contractCreateDate;
  String contractCloseDate;
  String contractBranchCreatedName;
  // String loanTypeCode;
  // String loanTypeName;
  // String loanTypeIcon;
  LoanListPaymentDetails paymentDetails;
  TopupDetail topupDetail;
  String dataDate;
  String transNo;
  double requestTopupAmount;
  String requestDate;
  String requestStatus;

  LoanDetail({
    //
    required this.contractName,
    required this.branchCode,
    required this.branchName,
    required this.branchImage,
    required this.dbName,
    required this.contractNo,
    required this.contractBankAccount,
    required this.contractBankBrandname,
    required this.contractBankType,
    required this.contractDetails,
    required this.contractCreateDate,
    required this.contractCloseDate,
    required this.contractBranchCreatedName,
    // required this.loanTypeCode,
    // required this.loanTypeName,
    // required this.loanTypeIcon,
    required this.paymentDetails,
    required this.topupDetail,
    required this.dataDate,
    required this.transNo,
    required this.requestTopupAmount,
    required this.requestDate,
    required this.requestStatus,
  });

  factory LoanDetail.fromJson(Map<String, dynamic> json) {
    return LoanDetail(
      contractName: json['contract_name'],
      branchCode: json['branch_code'],
      branchName: json['branch_name'],
      branchImage: json['branch_image'],
      dbName: json['db_name'],
      contractNo: json['contract_no'],
      contractBankAccount: json['contract_bank_account'],
      contractBankBrandname: json['contract_bank_brandname'],
      contractBankType: json['contract_bank_type'],
      contractDetails:
          LoanListContractDetails.fromJson(json['contract_details']), //
      contractCreateDate: json['contract_date'],
      contractCloseDate: json['contract_close_date'],
      contractBranchCreatedName: json['contract_branch_created_name'],
      // loanTypeCode: json['loan_type_code'],
      // loanTypeName: json['loan_type_name'],
      // loanTypeIcon: json['loan_type_icon'],
      paymentDetails:
          LoanListPaymentDetails.fromJson(json['payment_details']), //
      topupDetail: TopupDetail.fromJson(json['topup_detail']), //
      dataDate: json['data_date'],
      transNo: json['transno'],
      requestTopupAmount: json['request_topup_amount'].toDouble(),
      requestDate: json['request_date'],
      requestStatus: json['request_status'],
    );
  }
}

class LoanListData {
  double sumCurrentDueAmount;
  List<LoanDetail> loanDetailList;
  String totalDataDate;
  LoanListData({
    required this.sumCurrentDueAmount,
    required this.loanDetailList,
    required this.totalDataDate,
  });
  factory LoanListData.fromJson(Map<String, dynamic> json) {
    return LoanListData(
      //sumCurrentDueAmount is sum os balance
      sumCurrentDueAmount: json['sum_current_due_amount'].toDouble(),
      loanDetailList: json['results'],
      totalDataDate: json['total_data_date'],
    );
  }
}

LoanListData loanListDataDefault = LoanListData(
    loanDetailList: [], sumCurrentDueAmount: 1111, totalDataDate: '');
