import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../service.dart';
import 'dart:convert' as convert;

class AuthActiveDevice {
  Future<bool> activeDevice(
    String hashThaiId,
    String fcmToken,
  ) async {
    final response = await Service.rest(
      method: 'post',
      url: 'auth/active-device',
      body: {'hash_thai_id': hashThaiId, 'fcm_token': fcmToken},
    );
    try {
      if (response['status'] == '200' || response['status'] == 200) {
        return true;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught error in AuthActiveDevice (RESTApiException) :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in AuthActiveDevice :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
