import 'dart:convert';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class AuthenAPICall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
    String? apiUrl = '',
    String? fcmToken = '',
    String? uid = '',
    String? check = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "$username",
  "password": "$password",
  "api_url": "$apiUrl",
  "fcm_token": "$fcmToken",
  "uid": "$uid",
  "check": "$check"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'authenAPI',
      apiUrl: '$apiUrl/api/login',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Basic dGFra286MTIzNDU2',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      alwaysAllowBody: false,
    );
  }

  static int? statuslayer1(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.status''',
      ));
  static String? messagelayer1(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static String? accesstoken(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.access_token''',
      ));
  static String? nameth(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.name_th''',
      ));
  static String? email(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.email''',
      ));
  static String? employeeid(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.user.employee_id''',
      ));
  static String? mobilephone(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.user.mobile_phone''',
      ));
  static String? position(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.position''',
      ));
  static String? level(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.level''',
      ));
  static String? branchcode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.user.branch_code''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}
