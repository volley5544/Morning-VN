import 'package:mobile_application_srisawad/models/check_version_response_model.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../service.dart';
import 'dart:convert' as convert;

class Retention {
  Future<String> getRetensionNumber() async {
    try {
      final response =
          await Service.rest(method: 'get', url: 'retentionLoanNumber');

      if (response['status'].toString() == '200') {
        final Map<String, dynamic> parsed =
            convert.jsonDecode(response['res'].toString());
        // RetentionDetail retention =
        //     convert.jsonDecode(response['res'].toString());
        return parsed['loan_retention_number'];
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getRetensionNumber :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getRetensionNumber :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
