import 'dart:convert';

import 'package:mobile_application_srisawad/models/product_detail/product_model.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/insurance_lead/insurance_lead_save_product_request_model.dart';
import '../../models/insurance_product/insurance_product_detail_model.dart';
import 'index.dart';

class InsuranceProductRepository {
  Future<List<ProductModel>> getProductList() async {
    final response = await Service.rest(
      method: 'get',
      url: 'product/list/insurance',
    );
    try {
      if (response['status'].toString() == '200') {
        final stringArr = response['res'];
        final List<ProductModel> list = parseProductList(stringArr);
        return list;
      } else {
        final Map<String, dynamic> parsed = jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
        return throw Exception(response['status'].toString());
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught error in InsuranceProductRepository :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in InsuranceProductRepository :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<InsuranceProductDetailModel?> getProductDetail(
      {required String productId}) async {
    final response = await Service.rest(
      method: 'get',
      url: 'product/detail/insurance',
      query: {'product_id': productId},
    );
    try {
      if (response['status'].toString() == '200') {
        final stringArr = response['res'];
        final List<InsuranceProductDetailModel> list =
            parseInsuranceProductDetail(stringArr);
        return list.first;
      } else {
        final Map<String, dynamic> parsed = jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
        return throw Exception(response['status'].toString());
      }
    } on RESTApiException catch (e) {
      logger.e('Caught error in getProductDetail :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause.toString()}');
    } catch (e) {
      logger.e('Caught error in getProductDetail :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<bool> saveLead(
      {required InsuranceLeadSaveProductRequestModel request}) async {
    final response = await Service.rest(
      method: 'post',
      url: 'product/save/insurance',
      body: json.encode(request),
      headers: {"Content-Type": "application/json"},
    );
    try {
      if (response['status'].toString() == '200') {
        return true;
      } else {
        final Map<String, dynamic> parsed = jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
        return false;
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught error in saveLead(RESTApiException) :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause.toString()}');
    } catch (e) {
      logger.e('Caught error in saveLead :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
