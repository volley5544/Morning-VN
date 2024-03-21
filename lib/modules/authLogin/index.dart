import 'dart:convert' as convert;
import 'package:mobile_application_srisawad/models/token_user.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../services/localStorage/local_storage.dart';

class UserLogin {
  static Future<String> getUserToken(
      String thai_id, String phone_nubmer) async {
    final response = await Service.rest(
      method: 'post',
      url: 'auth/login',
      body: {
        'thai_id': thai_id,
        'phone_number': phone_nubmer,
      },
    );
    try {
      final String _status = response['status'].toString();
      final String _response = response.toString();
      print('login api response');
      print(_response);
      if (_status == '200') {
        UserToken fuser = UserToken.fromJson(
          convert.jsonDecode(response['res'].toString()),
        );
        return fuser.token.toString();
      } else if (['401', '400'].contains(_status)) {
        return _status;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getUserToken :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getUserToken :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<bool?> checkEnableLocalAuthentication() async {
    var isEnable = await LocalStoragePrefernces()
        .getLocalStorage("isEnableLocalAuthentication", "bool");
    return isEnable;
  }

  Future<void> setEnableLocalAuthentication(bool isEnable) async {
    await LocalStoragePrefernces().setLocalStorage(
      "isEnableLocalAuthentication",
      isEnable,
      "bool",
    );
  }
}

Future<void> removeLocalAuthenticationLocalStorage() async {
  await LocalStoragePrefernces()
      .removeLocalStorage("isEnableLocalAuthentication");
}
