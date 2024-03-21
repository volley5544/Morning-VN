import 'dart:convert';

import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/models/loan_payment_detail.dart';
import 'package:mobile_application_srisawad/models/qr_code_detail.dart';

class TopupLoanDetail {
  String canTopup;
  double defaultTopupAmount;
  int installmentNumber;
  TopupLoanDetail({
    required this.canTopup,
    required this.defaultTopupAmount,
    required this.installmentNumber,
  });
  factory TopupLoanDetail.fromJson(Map<String, dynamic> json) {
    return TopupLoanDetail(
      canTopup: json['can_topup'],
      defaultTopupAmount: json['default_topup_amount'].toDouble(),
      installmentNumber: json['installment_number'],
    );
  }
}

class LoanPaymentListContractDetails {
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
  double monthlyInterestRate;
  double effectiveInterestRate;
  double osBalance;
  double currentDueAmount;
  String currentDueDate;
  String accountStatus;
  String firstDueDate;
  String lastDueDate;
  LoanPaymentListContractDetails({
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
    required this.monthlyInterestRate,
    required this.effectiveInterestRate,
    required this.osBalance,
    required this.currentDueAmount,
    required this.currentDueDate,
    required this.accountStatus,
    required this.firstDueDate,
    required this.lastDueDate,
  });
  factory LoanPaymentListContractDetails.fromJson(Map<String, dynamic> json) {
    return LoanPaymentListContractDetails(
      comcode: json['comcode'],
      branchCode: json['branch_code'],
      branchName: json['branch_name'],
      canTopup: json['can_topup'],
      collateralInformation: json['collateral_information'],
      licensePlateProvince: json['license_plate_province'],
      licensePlateExpireDate: json['license_plate_expire_date'],
      vehicleBrand: json['vehicle_brand'],
      currentLtvAmount: json['current_ltv_amount'].toDouble(),
      creditLimit: json['credit_limit'].toDouble(),
      monthlyInterestRate: json['monthly_interest_rate'].toDouble(),
      effectiveInterestRate: json['effective_interest_rate'].toDouble(),
      osBalance: json['os_balance'].toDouble(),
      currentDueAmount: json['current_due_amount'].toDouble(),
      currentDueDate: json['current_due_date'],
      accountStatus: json['account_status'],
      firstDueDate: json['first_due_date'],
      lastDueDate: json['last_due_date'],
    );
  }
}

class LoanPaymentDetails {
  double currentInstallmentAmount;
  int currentInstallmentNumber;
  int totalInstallment;
  double totalPaidAmount;
  double totalPayBalanceLeftAmount;
  double totalLoanBalanceAmount;
  String payBeforeDate;
  int overdueDays;
  String latestPaidDate;
  LoanPaymentDetails({
    required this.currentInstallmentAmount,
    required this.currentInstallmentNumber,
    required this.totalInstallment,
    required this.totalPaidAmount,
    required this.totalPayBalanceLeftAmount,
    required this.totalLoanBalanceAmount,
    required this.payBeforeDate,
    required this.overdueDays,
    required this.latestPaidDate,
  });
  factory LoanPaymentDetails.fromJson(Map<String, dynamic> json) {
    return LoanPaymentDetails(
      currentInstallmentAmount: json['current_installment_amount'].toDouble(),
      currentInstallmentNumber: json['current_installment_number'],
      totalInstallment: json['total_installment'],
      totalPaidAmount: json['total_paid_amount'].toDouble(),
      totalPayBalanceLeftAmount:
          json['total_pay_balance_left_amount'].toDouble(),
      totalLoanBalanceAmount: json['total_loan_balance_amount'].toDouble(),
      payBeforeDate: json['pay_before_date'],
      overdueDays: json['overdue_days'],
      latestPaidDate: json['latest_paid_date'],
    );
  }
}

class PaymentAccountData {
  String contractName;
  String branchCode;
  String branchName;
  String dbName;
  String contractNo;
  String contractBankAccount;
  String contractBankBrandname;
  LoanPaymentListContractDetails contractDetails;
  CarDetailData carDetails;
  String contractDate;
  String contractCloseDate;
  // String contractBranchCreatedName;
  // String loanTypeCode;
  // String loanTypeName;
  LoanListPaymentDetails listPaymentDetails;
  TopupDetail topupDetail;
  String dataDate;
  String transno;
  double requestTopupAmount;
  String requestDate;
  String requestStatus;
  // LoanPaymentDetails paymentDetails;
  // TopupLoanDetail topupDetail;
  PaymentAccountData(
      {required this.contractName,
      required this.branchCode,
      required this.branchName,
      required this.dbName,
      required this.contractNo,
      required this.contractBankAccount,
      required this.contractBankBrandname,
      required this.contractDetails,
      required this.carDetails,
      required this.contractDate,
      required this.contractCloseDate,
      // required this.contractBranchCreatedName,
      // required this.loanTypeCode,
      // required this.loanTypeName,
      required this.listPaymentDetails,
      required this.topupDetail,
      required this.dataDate,
      required this.transno,
      required this.requestTopupAmount,
      required this.requestDate,
      required this.requestStatus
      // required this.paymentDetails,
      // required this.topupDetail,
      });
  //
  factory PaymentAccountData.fromJson(Map<String, dynamic> json) {
    return PaymentAccountData(
      contractName: json['contract_name'],
      branchCode: json['branch_code'],
      branchName: json['branch_name'],
      dbName: json['db_name'],
      contractNo: json['contract_no'],
      contractBankAccount: json['contract_bank_account'],
      contractBankBrandname: json['contract_bank_brandname'],
      contractDetails:
          LoanPaymentListContractDetails.fromJson(json['contract_details']),
      carDetails: CarDetailData.fromJson(json['car_details']),
      contractDate: json['contract_date'],
      contractCloseDate: json['contract_close_date'],
      // contractBranchCreatedName: json['contract_branch_created_name'],
      // loanTypeCode: json['loan_type_code'],
      // loanTypeName: json['loan_type_name'],
      listPaymentDetails:
          LoanListPaymentDetails.fromJson(json['payment_details']),
      topupDetail: TopupDetail.fromJson(json['topup_detail']),
      dataDate: json['data_date'],
      transno: json['transno'],
      requestTopupAmount: json['request_topup_amount'].toDouble(),
      requestDate: json['request_date'],
      requestStatus: json['request_status'],

      // paymentDetails: LoanPaymentDetails.fromJson(json['payment_details']),
      // topupDetail: TopupLoanDetail.fromJson(json['topup_detail']),
    );
  }
}

class CarDetailData {
  String carRegistrationPrefix;
  String carRegistration;
  String carProvince;
  String carBrand;
  String carSeries;
  String carDesc;
  String carChassisNo;
  String carCc;
  String carEngineNo;
  String carGear;
  String carManufactureYear;
  String carColor;
  CarDetailData({
    required this.carRegistrationPrefix,
    required this.carRegistration,
    required this.carProvince,
    required this.carBrand,
    required this.carSeries,
    required this.carDesc,
    required this.carChassisNo,
    required this.carCc,
    required this.carEngineNo,
    required this.carGear,
    required this.carManufactureYear,
    required this.carColor,
  });
  factory CarDetailData.fromJson(Map<String, dynamic> json) {
    return CarDetailData(
      carRegistrationPrefix: json['car_registration_prefix'],
      carRegistration: json['car_registration'],
      carProvince: json['car_province'],
      carBrand: json['car_brand'],
      carSeries: json['car_series'],
      carDesc: json['car_desc'],
      carChassisNo: json['car_chassisNo'],
      carCc: json['car_cc'],
      carEngineNo: json['car_engineNo'],
      carGear: json['car_gear'],
      carManufactureYear: json['car_manufacture_year'],
      carColor: json['car_color'],
    );
  }
}

class LoanPaymentDetail {
  String contractCloseDate;
  String contractName;
  String contractNo;
  String contractBankAccount;
  String collateralInformation;
  // String loanTypeCode;
  // String loanTypeName;
  String loanTypeIcon;
  String dataDate;
  // String code;
  // String message;
  // int total;
  // List paymentAccountData;
  // List<PaymentAccountData> paymentAccountData;

  LoanPaymentDetail({
    required this.contractCloseDate,
    required this.contractName,
    required this.contractNo,
    required this.contractBankAccount,
    required this.collateralInformation,
    // required this.loanTypeCode,
    // required this.loanTypeName,
    required this.loanTypeIcon,
    required this.dataDate,
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

  factory LoanPaymentDetail.fromJson(Map<String, dynamic> json) {
    // List<PaymentAccountData> payList = [];
    // json['accounts'].forEach((v) {
    //   payList.add(new PaymentAccountData.fromJson(v));
    // });
    return LoanPaymentDetail(
        contractCloseDate: json['contractCloseDate'],
        contractName: json['contractName'],
        contractNo: json['contractNo'],
        contractBankAccount: json['contractBankAccount'],
        collateralInformation: json['collateralInformation'],
        // loanTypeCode: json['loan_type_code'],
        // loanTypeName: json['loan_type_name'],
        loanTypeIcon: json['loan_type_icon'],
        dataDate: json['data_date']
        // paymentAccountData: setAccList(json['accounts']),
        );
  }
}

class QrCode {
  String type = '';
  List data = [];

  QrCode({required this.type, required this.data});
  factory QrCode.fromJson(Map<String, dynamic> json) {
    return QrCode(type: json['type'], data: json['data']);
  }
}

class Qrform {
  String type = '';
  List data = [];

  Qrform({required this.type, required this.data});
  factory Qrform.fromJson(Map<String, dynamic> json) {
    return Qrform(type: json['type'], data: json['data']);
  }
}

class BarCode {
  String type = '';
  List data = [];

  BarCode({required this.type, required this.data});
  factory BarCode.fromJson(Map<String, dynamic> json) {
    return BarCode(type: json['type'], data: json['data']);
  }
}

class BarForm {
  String type = '';
  List data = [];

  BarForm({required this.type, required this.data});
  factory BarForm.fromJson(Map<String, dynamic> json) {
    return BarForm(type: json['type'], data: json['data']);
  }
}

class PaymentDetail {
  QrCode qrCode;
  Qrform qrform;
  BarCode barCode;
  BarForm barForm;
  LoanPaymentDetail detail;
  QrCodeDetail qrCodeDetail;

  PaymentDetail({
    required this.qrCode,
    required this.qrform,
    required this.barCode,
    required this.barForm,
    required this.detail,
    required this.qrCodeDetail,
  });
  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      qrCode: QrCode.fromJson(json['qr']),
      qrform: Qrform.fromJson(json['qrform']),
      barCode: BarCode.fromJson(json['bar']),
      barForm: BarForm.fromJson(json['barform']),
      detail: LoanPaymentDetail.fromJson(json['loanDetail']),
      qrCodeDetail: QrCodeDetail.fromJson(json['qrDetail']),
    );
  }
}

PaymentDetail paymentDetailDefault = PaymentDetail(
  detail: LoanPaymentDetail(
    contractBankAccount: '',
    contractCloseDate: '',
    contractName: '',
    contractNo: '',
    collateralInformation: '',
    // loanTypeCode: '',
    dataDate: '',
    loanTypeIcon: '',
    // loanTypeName: '',
  ),
  qrCode: QrCode(data: [], type: ''),
  qrform: Qrform(data: [], type: ''),
  barCode: BarCode(data: [], type: ''),
  barForm: BarForm(data: [], type: ''),
  qrCodeDetail: QrCodeDetail(
      amount: 0,
      dataDate: '',
      fullBarcode: '',
      prefix: '',
      ref1: '',
      ref2: '',
      taxId: '',
      code: "",
      message: '',
      suffix: ''),
);
