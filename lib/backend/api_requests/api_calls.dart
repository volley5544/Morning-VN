import 'dart:convert';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start TrackingApi Group Code

class TrackingApiGroup {
  static String getBaseUrl({
    String? apiUrl = '',
  }) =>
      'https://prd-proxy.swpfin.com:8093';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static GetEmployeeListApiCall getEmployeeListApiCall =
      GetEmployeeListApiCall();
  static GetLocationEmployeeAPICall getLocationEmployeeAPICall =
      GetLocationEmployeeAPICall();
}

class GetEmployeeListApiCall {
  Future<ApiCallResponse> call({
    String? apiUrl = '',
  }) async {
    final baseUrl = TrackingApiGroup.getBaseUrl(
      apiUrl: apiUrl,
    );

    final ffApiRequestBody = '''
{
  "branch_code": "<branch_code>"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetEmployeeListApi',
      apiUrl: '${baseUrl}/api/users/vn',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
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

  List<TrackingEmployeeDataModelStruct>? employeeData(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => TrackingEmployeeDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class GetLocationEmployeeAPICall {
  Future<ApiCallResponse> call({
    String? employeeId = '',
    String? dateTime = '',
    String? apiUrl = '',
  }) async {
    final baseUrl = TrackingApiGroup.getBaseUrl(
      apiUrl: apiUrl,
    );

    final ffApiRequestBody = '''
{
  "employee_id": "${escapeStringForJson(employeeId)}",
  "date_time": "${escapeStringForJson(dateTime)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetLocationEmployeeAPI',
      apiUrl: '${baseUrl}/api/data/user-location-vn',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
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

  int? code(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.code''',
      ));
  String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  List<TrackingEmployeeDataLocationModelStruct>? data(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data[:]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => TrackingEmployeeDataLocationModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

/// End TrackingApi Group Code

/// Start Collection VN Group Code

class CollectionVNGroup {
  static String getBaseUrl({
    String? url = '',
    String? language = '',
  }) =>
      '${url}';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept-Language': '[language]',
  };
  static GetDataCountCall getDataCountCall = GetDataCountCall();
  static GetDataPersonCall getDataPersonCall = GetDataPersonCall();
  static GetDataListCall getDataListCall = GetDataListCall();
  static GetDataHistoryCall getDataHistoryCall = GetDataHistoryCall();
  static SaveCallCollectionCall saveCallCollectionCall =
      SaveCallCollectionCall();
}

class GetDataCountCall {
  Future<ApiCallResponse> call({
    String? branchCode = '',
    String? codeKate = '',
    String? codeRegion = '',
    String? url = '',
    String? language = '',
  }) async {
    final baseUrl = CollectionVNGroup.getBaseUrl(
      url: url,
      language: language,
    );

    final ffApiRequestBody = '''
{
  "branchCode": "${escapeStringForJson(branchCode)}",
  "codeKate": "${escapeStringForJson(codeKate)}",
  "codeRegion": "${escapeStringForJson(codeRegion)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'get data count',
      apiUrl: '${baseUrl}/api/collection/get_data_count',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': '${language}',
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

  List<CountCollectionDataModelStruct>? data(dynamic response) => (getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CountCollectionDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class GetDataPersonCall {
  Future<ApiCallResponse> call({
    String? idCard = '',
    String? url = '',
    String? language = '',
  }) async {
    final baseUrl = CollectionVNGroup.getBaseUrl(
      url: url,
      language: language,
    );

    final ffApiRequestBody = '''
{
  "idCard": "${escapeStringForJson(idCard)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'get data person',
      apiUrl: '${baseUrl}/api/collection/get_data_person',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': '${language}',
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

  List<CollectionDataModelStruct>? data(dynamic response) => (getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CollectionDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class GetDataListCall {
  Future<ApiCallResponse> call({
    String? branchCode = '',
    String? codeKate = '',
    String? codeRegion = '',
    int? dataPage,
    int? pageSize,
    String? dataFilter = '',
    String? searchBy = '',
    String? search = '',
    String? sortBy = '',
    String? url = '',
    String? language = '',
  }) async {
    final baseUrl = CollectionVNGroup.getBaseUrl(
      url: url,
      language: language,
    );

    final ffApiRequestBody = '''
{
  "branchCode": "${escapeStringForJson(branchCode)}",
  "codeKate": "${escapeStringForJson(codeKate)}",
  "codeRegion": "${escapeStringForJson(codeRegion)}",
  "dataPage": ${dataPage},
  "pageSize": ${pageSize},
  "dataFilter": "${escapeStringForJson(dataFilter)}",
  "searchBy": "${escapeStringForJson(searchBy)}",
  "search":"${escapeStringForJson(search)}" ,
  "sortBy": "${escapeStringForJson(sortBy)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'get data list',
      apiUrl: '${baseUrl}/api/collection/get_data_list',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': '${language}',
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

class GetDataHistoryCall {
  Future<ApiCallResponse> call({
    String? contNo = '',
    String? url = '',
    String? language = '',
  }) async {
    final baseUrl = CollectionVNGroup.getBaseUrl(
      url: url,
      language: language,
    );

    final ffApiRequestBody = '''
{
  "contNo": "${escapeStringForJson(contNo)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'get data history',
      apiUrl: '${baseUrl}/api/collection/get_data_history',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': '${language}',
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

  List<HistoryCollectionDataModelStruct>? data(dynamic response) =>
      (getJsonField(
        response,
        r'''$.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => HistoryCollectionDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class SaveCallCollectionCall {
  Future<ApiCallResponse> call({
    List<String>? saveCallList,
    String? url = '',
    String? language = '',
  }) async {
    final baseUrl = CollectionVNGroup.getBaseUrl(
      url: url,
      language: language,
    );
    final saveCall = _serializeList(saveCallList);

    return ApiManager.instance.makeApiCall(
      callName: 'save call collection',
      apiUrl: '${baseUrl}/api/collection/save_call_collection',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': '${language}',
      },
      params: {
        'saveCall': saveCall,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Collection VN Group Code

class AuthenAPICall {
  static Future<ApiCallResponse> call({
    String? username = '',
    String? password = '',
    String? apiUrl = '',
    String? fcmToken = '',
    String? uid = '',
    String? check = '',
    String? projectName = 'SSW_ARUNSAWAD_VN',
  }) async {
    final ffApiRequestBody = '''
{
  "username": "${username}",
  "password": "${password}",
  "uid": "${uid}",
  "project_name" : "${projectName}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'authenAPI',
      apiUrl: '${apiUrl}/api/login',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
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

class GetEmployeeListCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? employeeId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "employee_id": "${employeeId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetEmployeeList',
      apiUrl: '${apiUrl}/api/hr/users/in-branch-range',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
  static List<TrackingEmployeeDataModelStruct>? data(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.data[:]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => TrackingEmployeeDataModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
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
  "latitude": "${latitude}",
  "longitude": "${longitude}",
  "url_img": "${urlImg}",
  "branch": "${branch}",
  "remark": "${remark}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'workCheckAPI',
      apiUrl: '${apiUrl}/api/check-in/work-check',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static String? statuslayer1(dynamic response) =>
      castToType<String>(getJsonField(
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

class GetLocationEmployeeCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? employeeId = '',
    String? dateTime = '',
  }) async {
    final ffApiRequestBody = '''
{
  "employee_id": "${employeeId}",
  "date_time": "${dateTime}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetLocationEmployee',
      apiUrl: '${apiUrl}/api/hr/users/check-gps',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static int? code(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static List<TrackingEmployeeDataLocationModelStruct>? data(
          dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.data.data''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => TrackingEmployeeDataLocationModelStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
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
  "latitude": "${latitude}",
  "longitude": "${longitude}",
  "url_img": "${urlImg}",
  "branch": "${branch}",
  "remark": "${remark}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetLocation',
      apiUrl: '${apiUrl}/api/location/list',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
  "latitude": "${latitude}",
  "longitude": "${longitude}",
  "branch_code": "${branchCode}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getBranchLocation',
      apiUrl: '${apiUrl}/api/hr/location/get-branch-location',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
  "latitude": "${latitude}",
  "longitude": "${longitude}",
  "branch_code": "${branchCode}",
  "branch_name": "${branchName}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'updateBranchLocation',
      apiUrl: '${apiUrl}/api/hr/location/update-branch-location',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
  "latitude": "${latitude}",
  "longitude": "${longitude}",
  "branch_code": "${branchCode}",
  "branch_name": "${branchName}",
  "area_code": "${areaCode}",
  "region_code": "${regionCode}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'createBranchLocation',
      apiUrl: '${apiUrl}/api/hr/location/create-branch-location',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
      apiUrl: '${apiUrl}/api/check-in/work-check-history',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static String? code(dynamic response) => castToType<String>(getJsonField(
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
  static dynamic lastMothCheck(dynamic response) => getJsonField(
        response,
        r'''$.results.last_month''',
      );
  static dynamic currentMothCheck(dynamic response) => getJsonField(
        response,
        r'''$.results.current_month''',
      );
}

class GetLeaveListCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getLeaveList',
      apiUrl: '${apiUrl}/api/leave/get-list',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
  static List? leavelist(dynamic response) => getJsonField(
        response,
        r'''$.results.leave_list[*]''',
        true,
      ) as List?;
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
  static List<CurrentYearStruct>? nextyear(dynamic response) => (getJsonField(
        response,
        r'''$.results.leave_list.*.next_year''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CurrentYearStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static int? total(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results.total''',
      ));
  static int? countlistcalendar(dynamic response) =>
      castToType<int>(getJsonField(
        response,
        r'''$.results.count_list_calendar''',
      ));
  static List<CurrentYearStruct>? previousyear(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.leave_list.*.previous_year''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => CurrentYearStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
}

class GetLeaveHistoryCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getLeaveHistory',
      apiUrl: '${apiUrl}/api/leave/history',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
  static List? currentYear(dynamic response) => getJsonField(
        response,
        r'''$.results.current_year.leave_list[*]''',
        true,
      ) as List?;
  static List? previousYear(dynamic response) => getJsonField(
        response,
        r'''$.results.previous_year.leave_list[*]''',
        true,
      ) as List?;
  static List? nextYear(dynamic response) => getJsonField(
        response,
        r'''$.results.next_year.leave_list[*]''',
        true,
      ) as List?;
  static List<LeaveHistoryStruct>? leaveListCurrentYear(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.current_year.leave_list[*]''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => LeaveHistoryStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<String>? leaveListCurrentYearMonth(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.current_year.leave_list[*].month''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static String? currentMonth(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.current_month_only''',
      ));
  static dynamic results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
      );
}

class SaveLeaveCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    String? leaveType = '',
    String? leaveStartDate = '',
    String? leaveEndDate = '',
    String? leavePeriod = '',
    String? leaveReason = '',
    String? leaveDocument = '',
    List<String>? leaveDateList,
  }) async {
    final leaveDate = _serializeList(leaveDateList);

    final ffApiRequestBody = '''
{
  "leave_type": "${leaveType}",
  "leave_start_date": "${leaveStartDate}",
  "leave_end_date": "${leaveEndDate}",
  "leave_period": "${leavePeriod}",
  "leave_reason": "${leaveReason}",
  "leave_document": "${leaveDocument}",
  "leave_date": ${leaveDate}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'saveLeave',
      apiUrl: '${apiUrl}/api/leave/save',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static int? code(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static int? leaveId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results.leave_id''',
      ));
  static int? leaveDetailId(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.results.leave_detail_id''',
      ));
}

class GetUserProfileAPICall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    final ffApiRequestBody = '''
{
  "username": <username>,
  "password": <password>
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'getUserProfileAPI',
      apiUrl: '${apiUrl}/api/user-profile',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static dynamic results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
      );
  static String? profileBranchCode(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.branchCode''',
      ));
  static String? profliePositionName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.positionName''',
      ));
  static String? profilePhoneNumber(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.mobileNumber''',
      ));
  static String? profileHiredDate(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.hiredDate''',
      ));
  static String? statuslayer(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.status''',
      ));
  static String? statusHead(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.headOfWork''',
      ));
  static String? profileEmployeeID(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.empCode''',
      ));
  static String? profileFullName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.fullName''',
      ));
  static String? profileNickName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.nickName''',
      ));
  static String? profileServiceDurationYY(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.serviceDuration.year''',
      ));
  static String? profileServiceDurationMM(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.serviceDuration.month''',
      ));
  static String? profileServiceDurationDD(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.serviceDuration.day''',
      ));
  static String? code(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? profileBranchName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.results.branchName''',
      ));
  static String? rolename(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.UserRole[:].profile[:].role_name''',
      ));
  static String? gpslevel(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.gps_level''',
      ));
  static String? level(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.results.level''',
      ));
}

class GetLeaveListApproveCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getLeaveListApprove',
      apiUrl: '${apiUrl}/api/leave/get-list-approve',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static String? statuslayer(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static dynamic results(dynamic response) => getJsonField(
        response,
        r'''$.results''',
      );
  static List<ListApproveStruct>? listApprove(dynamic response) =>
      (getJsonField(
        response,
        r'''$.results.list_approve''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => ListApproveStruct.maybeFromMap(x))
          .withoutNulls
          .toList();
  static List<String>? allLeaveId(dynamic response) => (getJsonField(
        response,
        r'''$.results.all_leave_id''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List<String>? empCode(dynamic response) => (getJsonField(
        response,
        r'''$.results.list_approve[:].emp_code''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class GetAllLeaveCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getAllLeave',
      apiUrl: '${apiUrl}/api/leave/get-all-leave',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static DataLeaveAllStruct? previousYearCancel(dynamic response) =>
      DataLeaveAllStruct.maybeFromMap(getJsonField(
        response,
        r'''$.results.previous_year.Cancel[*]''',
      ));
  static List? previousYearApprove(dynamic response) => getJsonField(
        response,
        r'''$.results.previous_year.Approve[*]''',
        true,
      ) as List?;
  static DataLeaveAllStruct? previousYearNotApprove(dynamic response) =>
      DataLeaveAllStruct.maybeFromMap(getJsonField(
        response,
        r'''$.results.previous_year.NotApprove[*]''',
      ));
  static String? statuslayer(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? message(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static List? currentYearCancel(dynamic response) => getJsonField(
        response,
        r'''$.results.current_year.Cancel[*]''',
        true,
      ) as List?;
  static List? currentYearApprove(dynamic response) => getJsonField(
        response,
        r'''$.results.current_year.Approve[*]''',
        true,
      ) as List?;
  static List? currentYearNotApprove(dynamic response) => getJsonField(
        response,
        r'''$.results.current_year.NotApprove[*]''',
        true,
      ) as List?;
  static dynamic nextYearCancel(dynamic response) => getJsonField(
        response,
        r'''$.results.next_year.Cancel[*]''',
      );
  static List? nextYearApprove(dynamic response) => getJsonField(
        response,
        r'''$.results.next_year.Approve[*]''',
        true,
      ) as List?;
  static dynamic nextYearNotApprove(dynamic response) => getJsonField(
        response,
        r'''$.results.next_year.NotApprove[*]''',
      );
}

class GetAllLeaveCopyCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getAllLeave Copy',
      apiUrl: '${apiUrl}/api/leave/get-all-leave',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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

  static String? statusLayer1(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.code''',
      ));
  static String? messageLayer1(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.message''',
      ));
  static dynamic currentYearData(dynamic response) => getJsonField(
        response,
        r'''$.results.current_year''',
      );
  static dynamic previousYearData(dynamic response) => getJsonField(
        response,
        r'''$.results.previous_year''',
      );
  static dynamic nextYearData(dynamic response) => getJsonField(
        response,
        r'''$.results.next_year''',
      );
}

class SaveStatusLeaveCall {
  static Future<ApiCallResponse> call({
    String? apiUrl = '',
    String? token = '',
    List<String>? idList,
    String? status = '',
    String? reason = '',
  }) async {
    final id = _serializeList(idList);

    final ffApiRequestBody = '''
{
  "id": ${id},
  "status": "${escapeStringForJson(status)}",
  "reason": "${escapeStringForJson(reason)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'saveStatusLeave',
      apiUrl: '${apiUrl}/api/leave/save-status',
      callType: ApiCallType.POST,
      headers: {
        'ContentType': 'application/json; charset=utf-8,',
        'Authorization': 'Bearer ${token}',
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
