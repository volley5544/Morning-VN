// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_product_detail_company_choice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceProductDetailCompanyChoiceModel
    _$InsuranceProductDetailCompanyChoiceModelFromJson(
            Map<String, dynamic> json) =>
        InsuranceProductDetailCompanyChoiceModel(
          title: json['title'] as String?,
          imageUrlList: (json['content'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
        );

Map<String, dynamic> _$InsuranceProductDetailCompanyChoiceModelToJson(
        InsuranceProductDetailCompanyChoiceModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.imageUrlList,
    };
