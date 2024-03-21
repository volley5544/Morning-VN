// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_lead_save_product_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanLeadSaveProductRequestModel _$LoanLeadSaveProductRequestModelFromJson(
        Map<String, dynamic> json) =>
    LoanLeadSaveProductRequestModel(
      json['hash_thai_id'] as String,
      json['product_type'] as String,
      LoanLeadSaveProductDataRequestModel.fromJson(
          json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoanLeadSaveProductRequestModelToJson(
        LoanLeadSaveProductRequestModel instance) =>
    <String, dynamic>{
      'hash_thai_id': instance.hashThaiId,
      'product_type': instance.productType,
      'data': instance.data.toJson(),
    };
