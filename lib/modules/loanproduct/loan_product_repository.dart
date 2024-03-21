import 'dart:convert';

import 'package:mobile_application_srisawad/models/loan_product/loan_product_detail_model.dart';
import 'package:mobile_application_srisawad/models/product_detail/product_model.dart';
import 'package:mobile_application_srisawad/modules/loanproduct/index.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/loan_lead/loan_lead_save_product_request_model.dart';

class LoanProductRepository {
  Future<List<ProductModel>> getLoanProductList() async {
    final response = await Service.rest(
      method: 'get',
      url: 'product/list/loan',
    );
    try {
      if (response['status'].toString() == '200') {
        final stringArr = response['res'];
        final List<ProductModel> list = parseLoanProductList(stringArr);
        return list;
      } else {
        final Map<String, dynamic> parsed = jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught error in getLoanProductList(RESTApiException) :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause.toString()}');
    } catch (e) {
      logger.e('Caught error in getLoanProductList :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<LoanProductDetailModel?> getLoanProductDetail(
      {required String productId}) async {
    final response = await Service.rest(
      method: 'get',
      url: 'product/detail/loan',
      query: {'product_id': productId},
    );
    try {
      if (response['status'].toString() == '200') {
        final stringArr = response['res'];
        final List<LoanProductDetailModel> list =
            parseLoanProductDetail(stringArr);
        return list.first;
      } else {
        final Map<String, dynamic> parsed = jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e('Caught error in getLoanProductDetail :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause.toString()}');
    } catch (e) {
      logger.e('Caught error in getLoanProductDetail :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<bool> saveLead(
      {required LoanLeadSaveProductRequestModel request}) async {
    final response = await Service.rest(
      method: 'post',
      url: 'product/save/loan',
      body: json.encode(request.toJson()),
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
