
import 'package:json_annotation/json_annotation.dart';
part 'product_detail_title_bullet_list_model.g.dart';


@JsonSerializable(explicitToJson: true)
class ProductDetailTitleBulletListModel {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'bulleted_list')
  List<String>? bulletList;

  ProductDetailTitleBulletListModel({this.title, required this.bulletList});

  factory ProductDetailTitleBulletListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailTitleBulletListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailTitleBulletListModelToJson(this);
}