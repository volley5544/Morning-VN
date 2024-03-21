class OtpAuth {
  int create_date;
  String code = '';
  String ref = '';

  OtpAuth({
    required this.create_date,
    required this.code,
    required this.ref,
  });
  factory OtpAuth.fromJson(Map<String, dynamic> json) {
    return OtpAuth(
      create_date: json['create_date'],
      code: json['code'],
      ref: json['ref'],
    );
  }
}

class OtpPageModel {
  String phoneNumber;
  Function callbackFunction;

  OtpPageModel(
      {required String this.phoneNumber,
      required Function this.callbackFunction});
  factory OtpPageModel.fromJson(Map<String, dynamic> json) {
    return OtpPageModel(
      phoneNumber: json['phoneNumber'],
      callbackFunction: json['callbackFunction'],
    );
  }
}
