import 'package:mobile_application_srisawad/models/otp_model.dart';
import 'dart:convert' as convert;
import 'package:mobile_application_srisawad/modules/service.dart';

Future<OtpAuth> verfiyOtp(
  String phoneNumber,
) async {
  // if (phoneNumber.contains('7780220')) {
  // return OtpAuth(create_date: 1668485594187, code: "749935", ref: "tWkN9x");
  // } else {
  final _phonenumber = phoneNumber.startsWith('66')
      ? phoneNumber
      : '66' + phoneNumber.substring(1);
  final response = await Service.rest(
    method: 'post',
    url: 'otp',
    body: {
      'phone_number': _phonenumber,
    },
  );
  if (response['status'].toString() == '200') {
    OtpAuth OtpDetail = OtpAuth.fromJson(
      convert.jsonDecode(response['res'].toString()),
    );
    return OtpDetail;
  } else {
    throw Exception('Unable to get OTP');
  }
  // }
}
