import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

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
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODA5MFwvc3N3X21vcm5pbmdfZm1cL2FwaVwvbG9naW4iLCJpYXQiOjE3MzQzMzE3MzIsIm5iZiI6MTczNDMzMTczMiwianRpIjoiaUZCdHhkQjNCSURmcmduZCIsInN1YiI6ODc3NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.YMz2tzAuFeEgkcknPmaZiaKPOcFZFiEFGlYvNKJ7gck',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
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
  static String? startdate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user.start_date''',
      ));
}

class WorkCheckAPICall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? uid = '',
    String? latitude = '',
    String? longitude = '',
    String? urlImg = '',
    String? branch = '',
    String? remark = '',
  }) async {
    final ffApiRequestBody = '''
{
  "latitude": "$latitude",
  "longitude": "$longitude",
  "url_img": "$urlImg",
  "branch": "$branch",
  "remark": "$remark"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'workCheckAPI',
      apiUrl: '$apiUrl/api/check-in/work-check',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer  $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? statuslayer1(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.code''',
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
  static dynamic startdate(dynamic response) => getJsonField(
        response,
        r'''$.user.start_date''',
      );
}

class GetLocationCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? uid = '',
    String? latitude = '',
    String? longitude = '',
    String? urlImg = '',
    String? branch = '',
    String? remark = '',
  }) async {
    final ffApiRequestBody = '''
{
  "latitude": "$latitude",
  "longitude": "$longitude",
  "url_img": "$urlImg",
  "branch": "$branch",
  "remark": "$remark"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetLocation',
      apiUrl: '$apiUrl/api/location/list',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer  $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? code(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results.total''',
      ));
  static List<ListLocationCheckInStruct>? listLocatio(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.list_location[*]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => ListLocationCheckInStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class GetBranchLocationCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? uid = '',
    String? latitude = '',
    String? longitude = '',
    String? branchCode = '',
  }) async {
    final ffApiRequestBody = '''
{
  "latitude": "$latitude",
  "longitude": "$longitude",
  "branch_code": "$branchCode"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getBranchLocation',
      apiUrl: '$apiUrl/api/hr/location/get-branch-location',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer  $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? code(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static List? location(dynamic response) => getJsonField(
        response,
        r'''$.results.location[*]''',
        true,
      ) as List?;
  static List? map(dynamic response) => getJsonField(
        response,
        r'''$.results.map[*]''',
        true,
      ) as List?;
  static String? branchlocation(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.map[:].branch_location''',
      ));
  static String? inputlocation(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.map[:].input_location''',
      ));
  static String? latitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.location[:].latitude''',
      ));
  static String? longitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.location[:].longitude''',
      ));
  static String? branchname(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.location[:].branch_name''',
      ));
}

class UpdateBranchLocationCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? uid = '',
    String? latitude = '',
    String? longitude = '',
    String? branchCode = '',
    String? branchName = '',
  }) async {
    final ffApiRequestBody = '''
{
  "latitude": "$latitude",
  "longitude": "$longitude",
  "branch_code": "$branchCode",
  "branch_name": "$branchName"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateBranchLocation',
      apiUrl: '$apiUrl/api/hr/location/update-branch-location',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer  $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? code(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static List? location(dynamic response) => getJsonField(
        response,
        r'''$.results.location[*]''',
        true,
      ) as List?;
  static List? map(dynamic response) => getJsonField(
        response,
        r'''$.results.map[*]''',
        true,
      ) as List?;
  static String? branchlocation(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.map[:].branch_location''',
      ));
  static String? inputlocation(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.map[:].input_location''',
      ));
  static String? latitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.location[:].latitude''',
      ));
  static String? longitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.location[:].longitude''',
      ));
}

class CreateBranchLocationCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? uid = '',
    String? latitude = '',
    String? longitude = '',
    String? branchCode = '',
    String? branchName = '',
    String? areaCode = '',
    String? regionCode = '',
  }) async {
    final ffApiRequestBody = '''
{
  "latitude": "$latitude",
  "longitude": "$longitude",
  "branch_code": "$branchCode",
  "branch_name": "$branchName",
  "area_code": "$areaCode",
  "region_code": "$regionCode"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createBranchLocation',
      apiUrl: '$apiUrl/api/hr/location/create-branch-location',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer  $token',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? code(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static List? location(dynamic response) => getJsonField(
        response,
        r'''$.results.location[*]''',
        true,
      ) as List?;
  static List? map(dynamic response) => getJsonField(
        response,
        r'''$.results.map[*]''',
        true,
      ) as List?;
  static String? branchlocation(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.map[:].branch_location''',
      ));
  static String? inputlocation(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.map[:].input_location''',
      ));
  static String? latitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.location[:].latitude''',
      ));
  static String? longitude(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.location[:].longitude''',
      ));
}

class WorkCheckHistoryAPICall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'workCheckHistoryAPI',
      apiUrl: '$apiUrl/api/check-in/work-check-history',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer  $token',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? code(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static List<CheckinDataStruct>? lastMonth(dynamic response) => (getJsonField(
        response,
        r'''$.results.last_month[*]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CheckinDataStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<CheckinDataStruct>? currentMonth(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.current_month[*]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CheckinDataStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class GetLeaveListCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getLeaveList',
      apiUrl: '$apiUrl/api/leave/get-list',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer  $token',
      },
      params: {},
      bodyType: BodyType.NONE,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static int? code(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static List<CheckinDataStruct>? lastMonth(dynamic response) => (getJsonField(
        response,
        r'''$.results.last_month[*]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CheckinDataStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<CheckinDataStruct>? currentMonth(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.current_month[*]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CheckinDataStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<TestLeaveListDataStruct>? leavelist(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.leave_list.*''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => TestLeaveListDataStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<CalendarDataStruct>? listcalendar(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.list_calendar''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CalendarDataStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<CurrentYearStruct>? currentyear(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.leave_list.*.current_year''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CurrentYearStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<OtherYearStruct>? otheryear(dynamic response) => (getJsonField(
        response,
        r'''$.results.leave_list.*.other_year''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => OtherYearStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class GetUserProfileCall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
    String? apiUrl = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${escapeStringForJson(username)}",
  "password": "${escapeStringForJson(password)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getUserProfile',
      apiUrl: '$apiUrl/api/user-profile',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9sb2NhbGhvc3Q6ODA5MFwvc3N3X21vcm5pbmdfZm1cL2FwaVwvbG9naW4iLCJpYXQiOjE3MzQzMzE3MzIsIm5iZiI6MTczNDMzMTczMiwianRpIjoiaUZCdHhkQjNCSURmcmduZCIsInN1YiI6ODc3NSwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.YMz2tzAuFeEgkcknPmaZiaKPOcFZFiEFGlYvNKJ7gck',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
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

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
