import 'loan_detail.dart';
import 'topup_installment_number.dart';
import 'user_addresses.dart';

class TopupData {
  late String code;
  late String message;
  late String dbName;
  late String contractNo;
  late ContractDetails contractDetails;
  late CarDetails carDetails;
  late String firstDueDate;
  late int dueDay;
  late String contractDate;
  late double defaultTopupAmount;
  late int installmentNumber;
  late double installmentAmount;
  late double minAmountWithRate;
  late double maxTopupAmount;
  late double interestRate;
  late double transferAmount;
  late double osBalance;
  late String dataDate;
  late String packageId;
  late String lifeInsureAmt;
  late double minTopupAmount;

  TopupData({
    required this.code,
    required this.message,
    required this.dbName,
    required this.contractNo,
    required this.contractDetails,
    required this.carDetails,
    required this.firstDueDate,
    required this.dueDay,
    required this.contractDate,
    required this.defaultTopupAmount,
    required this.installmentNumber,
    required this.installmentAmount,
    required this.minAmountWithRate,
    required this.maxTopupAmount,
    required this.interestRate,
    required this.transferAmount,
    required this.osBalance,
    required this.dataDate,
    required this.packageId,
    required this.lifeInsureAmt,
    required this.minTopupAmount,
  });

  TopupData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    dbName = json['db_name'];
    contractNo = json['contract_no'];
    contractDetails = ContractDetails.fromJson(json['contract_details']);
    carDetails = CarDetails.fromJson(json['car_details']);
    firstDueDate = json['first_due_date'];
    dueDay = json['due_day'];
    contractDate = json['contract_date'];
    defaultTopupAmount = json['default_topup_amount'].toDouble();
    installmentNumber = json['installment_number'];
    installmentAmount = json['installment_amount'].toDouble();
    minAmountWithRate = json['min_amount_with_rate'].toDouble();
    maxTopupAmount = json['max_topup_amount'].toDouble();
    interestRate = json['interest_rate'].toDouble();
    transferAmount = json['transfer_amount'].toDouble();
    osBalance = json['os_balance'].toDouble();
    dataDate = json['data_date'];
    packageId = json['package_id'];
    lifeInsureAmt = json['life_insure_amt'];
    minTopupAmount = json['min_topup_amount'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['db_name'] = this.dbName;
    data['contract_no'] = this.contractNo;
    data['contract_details'] = this.contractDetails.toJson();
    data['car_details'] = this.carDetails.toJson();
    data['first_due_date'] = this.firstDueDate;
    data['due_day'] = this.dueDay;
    data['contract_date'] = this.contractDate;
    data['default_topup_amount'] = this.defaultTopupAmount;
    data['installment_number'] = this.installmentNumber;
    data['installment_amount'] = this.installmentAmount;
    data['min_amount_with_rate'] = this.minAmountWithRate;
    data['max_topup_amount'] = this.maxTopupAmount;
    data['interest_rate'] = this.interestRate;
    data['transfer_amount'] = this.transferAmount;
    data['os_balance'] = this.osBalance;
    data['data_date'] = this.dataDate;
    data['package_id'] = this.dataDate;
    data['life_insure_amt'] = this.dataDate;
    return data;
  }
}

class ContractDetails {
  late String comcode;
  late String branchCode;
  late String branchName;
  late String canTopup;
  late String collateralInformation;
  late String licensePlateProvince;
  late String licensePlateExpireDate;
  late String vehicleBrand;
  late double currentLtvAmount;
  late double creditLimit;
  late double monthlyInterestRate;
  late double effectiveInterestRate;
  late double osBalance;
  late double closingBalance;
  late double currentDueAmount;
  late String currentDueDate;
  late String accountStatus;
  late String firstDueDate;
  late String lastDueDate;

  ContractDetails(
      {required this.comcode,
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
      required this.closingBalance,
      required this.currentDueAmount,
      required this.currentDueDate,
      required this.accountStatus,
      required this.firstDueDate,
      required this.lastDueDate});

  ContractDetails.fromJson(Map<String, dynamic> json) {
    comcode = json['comcode'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    canTopup = json['can_topup'];
    collateralInformation = json['collateral_information'];
    licensePlateProvince = json['license_plate_province'];
    licensePlateExpireDate = json['license_plate_expire_date'];
    vehicleBrand = json['vehicle_brand'];
    currentLtvAmount = json['current_ltv_amount'].toDouble();
    creditLimit = json['credit_limit'].toDouble();
    monthlyInterestRate = json['monthly_interest_rate'].toDouble();
    effectiveInterestRate = json['effective_interest_rate'].toDouble();
    osBalance = json['os_balance'].toDouble();
    closingBalance = json['closing_balance'].toDouble();
    currentDueAmount = json['current_due_amount'].toDouble();
    currentDueDate = json['current_due_date'];
    accountStatus = json['account_status'];
    firstDueDate = json['first_due_date'];
    lastDueDate = json['last_due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comcode'] = this.comcode;
    data['branch_code'] = this.branchCode;
    data['branch_name'] = this.branchName;
    data['can_topup'] = this.canTopup;
    data['collateral_information'] = this.collateralInformation;
    data['license_plate_province'] = this.licensePlateProvince;
    data['license_plate_expire_date'] = this.licensePlateExpireDate;
    data['vehicle_brand'] = this.vehicleBrand;
    data['current_ltv_amount'] = this.currentLtvAmount;
    data['credit_limit'] = this.creditLimit;
    data['monthly_interest_rate'] = this.monthlyInterestRate;
    data['effective_interest_rate'] = this.effectiveInterestRate;
    data['os_balance'] = this.osBalance;
    data['current_due_amount'] = this.currentDueAmount;
    data['current_due_date'] = this.currentDueDate;
    data['account_status'] = this.accountStatus;
    data['first_due_date'] = this.firstDueDate;
    data['last_due_date'] = this.lastDueDate;
    return data;
  }
}

class CarDetails {
  late String carRegistrationPrefix;
  late String carRegistration;
  late String carProvince;
  late String carBrand;
  late String carSeries;
  late String carDesc;
  late String carChassisNo;
  late String carCc;
  late String carEngineNo;
  late String carGear;
  late String carManufactureYear;
  late String carColor;

  CarDetails(
      {required this.carRegistrationPrefix,
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
      required this.carColor});

  CarDetails.fromJson(Map<String, dynamic> json) {
    carRegistrationPrefix = json['car_registration_prefix'];
    carRegistration = json['car_registration'];
    carProvince = json['car_province'];
    carBrand = json['car_brand'];
    carSeries = json['car_series'];
    carDesc = json['car_desc'];
    carChassisNo = json['car_chassisNo'];
    carCc = json['car_cc'];
    carEngineNo = json['car_engineNo'];
    carGear = json['car_gear'];
    carManufactureYear = json['car_manufacture_year'];
    carColor = json['car_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_registration_prefix'] = this.carRegistrationPrefix;
    data['car_registration'] = this.carRegistration;
    data['car_province'] = this.carProvince;
    data['car_brand'] = this.carBrand;
    data['car_series'] = this.carSeries;
    data['car_desc'] = this.carDesc;
    data['car_chassisNo'] = this.carChassisNo;
    data['car_cc'] = this.carCc;
    data['car_engineNo'] = this.carEngineNo;
    data['car_gear'] = this.carGear;
    data['car_manufacture_year'] = this.carManufactureYear;
    data['car_color'] = this.carColor;
    return data;
  }
}

class TopupConclusion {
  LoanDetail loanDetail;
  Installments selectedInstallmentNumber;
  TopupInstallmentNumber topupInstallmentNumber;
  String appbarTitle = '';
  bool isComeFromConclusionNext;
  double loanTotalBalanceAmount;
  String vehicleImage;
  String vehicleTag;
  double actualAmount;
  double insuranceAmt;
  TopupData topupDataConclusion;

  TopupConclusion({
    required this.loanDetail,
    required this.selectedInstallmentNumber,
    required this.topupInstallmentNumber,
    required this.isComeFromConclusionNext,
    required this.appbarTitle,
    required this.loanTotalBalanceAmount,
    required this.vehicleImage,
    required this.vehicleTag,
    required this.actualAmount,
    required this.topupDataConclusion,
    required this.insuranceAmt,
  });
}

class TopupConsent {
  bool contactRequst;
  bool paySlip;
  bool contactDoccument;
  TopupConsent({
    required this.contactRequst,
    required this.paySlip,
    required this.contactDoccument,
  });
}
