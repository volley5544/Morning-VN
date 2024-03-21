import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  ProductModel(
      {required this.id,
      required this.title,
      required this.type,
      required this.description,
      required this.imageUrl});

  @JsonKey(name: 'product_id')
  String id;
  @JsonKey(name: 'product_name')
  String? title;
  @JsonKey(name: 'product_type')
  String? type;
  @JsonKey(name: 'product_description')
  String? description;
  @JsonKey(name: 'image_url')
  String? imageUrl;


  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
