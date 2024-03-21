import 'dart:convert' as convert;

import 'package:json_annotation/json_annotation.dart';
part 'product_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductDetailTopModel {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;

  ProductDetailTopModel({this.title, this.description});
  factory ProductDetailTopModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailTopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailTopModelToJson(this);
}
