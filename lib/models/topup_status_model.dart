class TopupList {
  String contractName;
  String contractNo;
  String collateralInformation;
  String current_ltv_amount;
  int amount;
  String requestDate;
  String request_status;
  TopupList(
      {required this.contractName,
      required this.contractNo,
      required this.collateralInformation,
      required this.current_ltv_amount,
      required this.amount,
      required this.requestDate,
      required this.request_status});

  factory TopupList.fromJson(Map<String, dynamic> json) {
    return TopupList(
        contractName: json['contract_name'],
        contractNo: json['contract_no'],
        collateralInformation: json['collateral_information'],
        current_ltv_amount: json['current_ltv_amount'],
        amount: json['amount'],
        requestDate: json['request_date'],
        request_status: json['request_status']);
  }
}
