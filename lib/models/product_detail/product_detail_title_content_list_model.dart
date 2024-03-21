
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_application_srisawad/models/product_detail/product_detail_content_model.dart';
part 'product_detail_title_content_list_model.g.dart';

@JsonSerializable()
class ProductDetailTitleContentListModel {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  List<ProductDetailContentModel>? content;

  ProductDetailTitleContentListModel({this.title, required this.content});

  factory ProductDetailTitleContentListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailTitleContentListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailTitleContentListModelToJson(this);
}