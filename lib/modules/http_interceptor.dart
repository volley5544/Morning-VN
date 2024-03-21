import 'package:http_interceptor/http_interceptor.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as localStorage;
import 'package:mobile_application_srisawad/util/logger_service.dart';

class HttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      final localStorageObject = localStorage.LocalStoragePrefernces();
      final dynamic userToken =
          await localStorageObject.getLocalStorage('userToken', 'string');
      // data.headers["Authorization"] = "Bearer ${userToken.toString()}";
      data.headers["Authorization"] =
          "Bearer ${userToken.runtimeType == Null ? '' : userToken.toString()}";
      data.headers["x-srisawad"] = "x1";
    } catch (e) {
      logger.e('Cause on HttpInterceptor $e');
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async =>
      data;
}

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    logger.i("----- Request -----");
    logger.i(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    logger.i("----- Response -----");
    logger.i(data.toString());
    return data;
  }
}
