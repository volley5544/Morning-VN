import 'package:json_annotation/json_annotation.dart';
part 'product_detail_content_model.g.dart';

@JsonSerializable()
class ProductDetailContentModel {
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'description')
  String? description;

  ProductDetailContentModel({this.imageUrl, this.description});
  factory ProductDetailContentModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailContentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailContentModelToJson(this);
}