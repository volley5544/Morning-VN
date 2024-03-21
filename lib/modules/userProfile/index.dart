import 'dart:convert' as convert;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:mobile_application_srisawad/models/user_profile_data.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../util/custom_exception.dart';

const BASE_URL = 'http://localhost:8080'; // process.env.API

class UserProfile {
  Future<UserProfileData> getUserProfile(String id, bool fromHome) async {
    final response = await Service.rest(
        method: 'get',
        url: fromHome
            ? 'profile/$id'
            : 'profile/${sha256.convert(utf8.encode(id)).toString()}');

    //   headers: {"Authorization": "some token"});
    // response['status'] = 500;
    // response['res'] = convert.jsonEncode({
    //   "errorCode": "THA00001",
    //   "errorDescription":
    //       "ENOENT: no such file or directory, open '../assets/qrcode-form.png'"
    // });
    try {
      if (response['status'].toString() == '200') {
        print('respone${response['res']}');
        String tmp = response['res'].toString().replaceAll('[', '');
        String tmp2 = tmp.replaceAll(']', '');
        UserProfileData userData =
            UserProfileData.fromJson(convert.jsonDecode(tmp2));
        return userData;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getUserProfile :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getUserProfile :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<void> updateUserProfile(
      {required String id,
      required String email,
      required String lineId}) async {
    try {
      final response = await Service.rest(
          method: 'post',
          url: 'profile/${id}',
          body: {"line_id": lineId, "email": email});
      if (response['status'].toString() == '200') {
        logger.d('Update profile succesfully ');
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in updateUserProfile :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in updateUserProfile :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<void> updateProfile(
      {required String id,
      required String firstName,
      required String lastName,
      required String phone,
      required String dob,
      required String address,
      required String province,
      required String district,
      required String subdistrict,
      required String postal}) async {
    try {
      final response = await Service.rest(
          method: 'post',
          url: 'profile/${sha256.convert(utf8.encode(id)).toString()}',
          body: {
            "first_name": firstName,
            "last_name": lastName,
            "phone_number": phone,
            "dob": dob,
            "address_details": address,
            "address_sub_district": subdistrict,
            "address_district": district,
            "address_province": province,
            "address_postal_code": postal,
          });
      if (response['status'].toString() == '200') {
        logger.d('Update profile succesfully ');
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in updateUserProfile :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in updateUserProfile :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
