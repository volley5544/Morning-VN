import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_application_srisawad/models/branch_detail.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'dart:convert' as convert;
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as localStorage;

import '../../util/custom_exception.dart';

List<BranchDetail> parseBranches(String responseBody) {
  final parsed = convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed
      .map<BranchDetail>((json) => BranchDetail.fromJson(json))
      .toList();
}

class MapSearch {
  Future<List<BranchDetail>> searchBranch(String intput) async {
    try {
      final localStorageObject = localStorage.LocalStoragePrefernces();
      dynamic userLocation =
          await localStorageObject.getLocalStorage('userLocation', 'string');
      Map<String, dynamic> maper = jsonDecode(
        userLocation.toString(),
      );
      final response = await Service.rest(
        method: 'get',
        url: 'map/search',
        query: {
          'search': intput,
          'limit': '10',
          'lat': maper['lat'].toString(),
          'lng': maper['lng'].toString()
        },
      );

      if (response['status'].toString() == '200') {
        final stringArr = response['res'];
        final List<BranchDetail> branches = parseBranches(stringArr);
        return branches;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in searchBranch :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in searchBranch :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<List<BranchDetail>> searchNearby(String lat, String lng) async {
    final List<BranchDetail> branches = [];
    final response = await Service.rest(
      method: 'get',
      url: 'map/nearby',
      // url: 'map/nearby',
      query: {'lat': lat.toString(), 'lng': lng.toString()},
    );

    try {
      if (response['status'].toString() == '200') {
        final stringArr = response['res'];
        final List<BranchDetail> branches = parseBranches(stringArr);
        return branches;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in searchNearby :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in searchNearby :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
