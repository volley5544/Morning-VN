// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_title_content_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailTitleContentListModel _$ProductDetailTitleContentListModelFromJson(
        Map<String, dynamic> json) =>
    ProductDetailTitleContentListModel(
      title: json['title'] as String?,
      content: (json['content'] as List<dynamic>?)
          ?.map((e) =>
              ProductDetailContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductDetailTitleContentListModelToJson(
        ProductDetailTitleContentListModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
    };
