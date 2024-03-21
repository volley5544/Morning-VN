// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_lead_save_product_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceLeadSaveProductRequestModel
    _$InsuranceLeadSaveProductRequestModelFromJson(Map<String, dynamic> json) =>
        InsuranceLeadSaveProductRequestModel(
          json['hash_thai_id'] as String,
          json['product_type'] as String,
          InsuranceLeadSaveProductDataRequestModel.fromJson(
              json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$InsuranceLeadSaveProductRequestModelToJson(
        InsuranceLeadSaveProductRequestModel instance) =>
    <String, dynamic>{
      'hash_thai_id': instance.hashThaiId,
      'product_type': instance.productType,
      'data': instance.data.toJson(),
    };
