// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['product_id'] as String,
      title: json['product_name'] as String?,
      type: json['product_type'] as String?,
      description: json['product_description'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'product_id': instance.id,
      'product_name': instance.title,
      'product_type': instance.type,
      'product_description': instance.description,
      'image_url': instance.imageUrl,
    };
