// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_title_bullet_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailTitleBulletListModel _$ProductDetailTitleBulletListModelFromJson(
        Map<String, dynamic> json) =>
    ProductDetailTitleBulletListModel(
      title: json['title'] as String?,
      bulletList: (json['bulleted_list'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ProductDetailTitleBulletListModelToJson(
        ProductDetailTitleBulletListModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'bulleted_list': instance.bulletList,
    };
