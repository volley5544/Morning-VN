import 'package:mobile_application_srisawad/models/product_detail/product_model.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'dart:convert' as convert;

import '../../models/insurance_product/insurance_product_detail_model.dart';

List<ProductModel> parseProductList(String responseBody) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responseBody);
    return List<ProductModel>.from(parsed['data']['insurance_product'].map((x) {
      return ProductModel.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch e $e');
    return [];
  }
}

List<InsuranceProductDetailModel> parseInsuranceProductDetail(
    String responseBody) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responseBody);
    return List<InsuranceProductDetailModel>.from((parsed['data']).map((x) {
      return InsuranceProductDetailModel.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch e $e');
    return [];
  }
}
