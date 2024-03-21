import 'dart:convert' as convert;
import 'package:mobile_application_srisawad/models/register.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/device_id.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

class AuthRegister {
  static Future<String> registerauther(
    String thai_id,
    String phone_nubmer,
    String first_name,
    String last_name,
    String title,
    String dob,
    String email,
    String address_details,
    String address_sub_district,
    String address_distinct,
    String address_province,
    String address_postal_code,
    String line_id,
  ) async {
    final response = await Service.rest(
      method: 'post',
      url: 'auth/register',
      headers: {
        'device_id': (await getId() ?? ''),
      },
      body: {
        'thai_id': thai_id,
        'phone_number': phone_nubmer,
        'first_name': first_name,
        'last_name': last_name,
        'title': title,
        'dob': dob,
        'email': email,
        'address_details': address_details,
        'address_sub_district': address_sub_district,
        'address_district': address_distinct,
        'address_province': address_province,
        'address_postal_code': address_postal_code,
        'line_id': line_id,
      },
    );
    try {
      print(response);
      final _response = response.toString();
      print('response auth/register : ');
      print(_response);
      if (response['status'] == '200' || response['status'] == 200) {
        return 'Register success';
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught error in registerauther(RESTApiException) :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in registerauther :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<RegisterVerfiy> verfiyUser(
    String thai_id,
    String phone_number,
  ) async {
    final response = await Service.rest(
      method: 'post',
      url: 'auth/verify',
      // TODO Saksit header for spamable end-point
      // headers: {"Authorization":'Basic key(base64)'},
      body: {
        'thai_id': thai_id,
        'phone_number': phone_number,
        'device_id': (await getId()),
      },
    );
    try {
      final _status = response['status'].toString();
      final _response = response.toString();
      print('response api : ');
      print(_response);
      if (_status == '200') {
        print('verify  $response');
        RegisterVerfiy userDetail = RegisterVerfiy.fromJson(
          convert.jsonDecode(response['res'].toString()),
        );
        return userDetail;
      } else if (_status == '401') {
        return RegisterVerfiy(
          isExistingCustomer: false,
          status: '',
          phoneNumber: '',
        );
      } else if (_status == '404') {
        return RegisterVerfiy(
          isExistingCustomer: false,
          status: '',
          phoneNumber: '',
        );
      } else {

        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught error in verfiyUser(RESTApiException) :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in verfiyUser :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
