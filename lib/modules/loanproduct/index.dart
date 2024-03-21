import 'package:mobile_application_srisawad/models/loan_product/loan_product_detail_model.dart';
import 'package:mobile_application_srisawad/models/product_detail/product_model.dart';
import 'dart:convert' as convert;

import 'package:mobile_application_srisawad/util/logger_service.dart';

List<ProductModel> parseLoanProductList(String responseBody) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responseBody);
    return List<ProductModel>.from(parsed['data']['loan_product'].map((x) {
      return ProductModel.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch e $e');
    return [];
  }
}

List<LoanProductDetailModel> parseLoanProductDetail(String responseBody) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responseBody);
    return List<LoanProductDetailModel>.from((parsed['data']).map((x) {
      return LoanProductDetailModel.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch e $e');
    return [];
  }
}
