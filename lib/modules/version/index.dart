import 'package:mobile_application_srisawad/models/check_version_response_model.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../service.dart';
import 'dart:convert' as convert;

class VersionRepository {
  Future<CheckVersionResponseModel> checkNeedUpdateVersion(
      String version) async {
    try {
      final response =
          await Service.rest(method: 'get', url: 'version/check/$version');

      if (response['status'].toString() == '200') {
        try {
          return CheckVersionResponseModel.fromJson(
              convert.jsonDecode(response['res'].toString()));
        } catch (e) {}
        return CheckVersionResponseModel(false);
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in checkNeedUpdateVersion :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in checkNeedUpdateVersion :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
