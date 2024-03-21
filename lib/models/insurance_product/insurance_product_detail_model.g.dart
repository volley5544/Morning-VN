// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceProductDetailModel _$InsuranceProductDetailModelFromJson(
        Map<String, dynamic> json) =>
    InsuranceProductDetailModel(
      productId: json['product_id'] as String,
      productType: json['product_type'] as String?,
      insuranceType: json['insurance_type'] as String?,
      imageUrl: json['image_url'] as String?,
      insuranceTop: json['insurance'] == null
          ? null
          : ProductDetailTopModel.fromJson(
              json['insurance'] as Map<String, dynamic>),
      insuranceAdvantage: json['insurance_advantage'] == null
          ? null
          : ProductDetailTitleContentListModel.fromJson(
              json['insurance_advantage'] as Map<String, dynamic>),
      insuranceTable: json['insurance_table'] == null
          ? null
          : InsuranceProductDetailTableModel.fromJson(
              json['insurance_table'] as Map<String, dynamic>),
      insuranceCompanyChoice: json['insurance_company_choice'] == null
          ? null
          : InsuranceProductDetailCompanyChoiceModel.fromJson(
              json['insurance_company_choice'] as Map<String, dynamic>),
      insuranceChoice: json['insurance_choice'] == null
          ? null
          : InsuranceProductDetailChoiceModel.fromJson(
              json['insurance_choice'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InsuranceProductDetailModelToJson(
        InsuranceProductDetailModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_type': instance.productType,
      'insurance_type': instance.insuranceType,
      'image_url': instance.imageUrl,
      'insurance': instance.insuranceTop?.toJson(),
      'insurance_advantage': instance.insuranceAdvantage?.toJson(),
      'insurance_table': instance.insuranceTable?.toJson(),
      'insurance_company_choice': instance.insuranceCompanyChoice?.toJson(),
      'insurance_choice': instance.insuranceChoice?.toJson(),
    };
