// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_product_detail_choice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceProductDetailChoiceModel _$InsuranceProductDetailChoiceModelFromJson(
        Map<String, dynamic> json) =>
    InsuranceProductDetailChoiceModel(
      title: json['title'] as String?,
      bulletList: (json['content'] as List<dynamic>?)
          ?.map((e) => ProductDetailTitleBulletListModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InsuranceProductDetailChoiceModelToJson(
        InsuranceProductDetailChoiceModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.bulletList?.map((e) => e.toJson()).toList(),
    };
