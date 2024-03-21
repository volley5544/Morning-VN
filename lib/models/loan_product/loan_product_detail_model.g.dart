// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_product_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanProductDetailModel _$LoanProductDetailModelFromJson(
        Map<String, dynamic> json) =>
    LoanProductDetailModel(
      productId: json['product_id'] as String,
      productType: json['product_type'] as String?,
      assetType: json['asset_type'] as String?,
      installmentStatus: json['installment_status'] as String?,
      imageUrl: json['image_url'] as String?,
      top: json['loan'] == null
          ? null
          : ProductDetailTopModel.fromJson(
              json['loan'] as Map<String, dynamic>),
      advantage: json['loan_advantage'] == null
          ? null
          : ProductDetailTitleContentListModel.fromJson(
              json['loan_advantage'] as Map<String, dynamic>),
      document: json['loan_document'] == null
          ? null
          : ProductDetailTitleContentListModel.fromJson(
              json['loan_document'] as Map<String, dynamic>),
      otherDocument: json['loan_other_document'] == null
          ? null
          : ProductDetailTitleBulletListModel.fromJson(
              json['loan_other_document'] as Map<String, dynamic>),
      qualification: json['qualification'] == null
          ? null
          : ProductDetailTitleBulletListModel.fromJson(
              json['qualification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoanProductDetailModelToJson(
        LoanProductDetailModel instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'product_type': instance.productType,
      'asset_type': instance.assetType,
      'installment_status': instance.installmentStatus,
      'image_url': instance.imageUrl,
      'loan': instance.top?.toJson(),
      'loan_advantage': instance.advantage?.toJson(),
      'loan_document': instance.document?.toJson(),
      'loan_other_document': instance.otherDocument?.toJson(),
      'qualification': instance.qualification?.toJson(),
    };
