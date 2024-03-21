class PersonalCredit {
  String vehicelType = '';
  int leftToPay = 0;
  DateTime deadLineDate = DateTime.now();
  PersonalCredit({
    required this.vehicelType,
    required this.leftToPay,
    required this.deadLineDate,
  });

  factory PersonalCredit.fromJson(Map<String, dynamic> json) {
    return PersonalCredit(
      vehicelType: json['car'],
      leftToPay: json['bike'],
      deadLineDate: json['2022-09-01'],
    );
  }
}
