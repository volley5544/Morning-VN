
import 'package:json_annotation/json_annotation.dart';

import '../product_detail/product_detail_title_bullet_list_model.dart';
part 'insurance_product_detail_choice_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuranceProductDetailChoiceModel{
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  List<ProductDetailTitleBulletListModel>? bulletList;

  InsuranceProductDetailChoiceModel({this.title, this.bulletList});

  factory InsuranceProductDetailChoiceModel.fromJson(Map<String, dynamic> json) =>
      _$InsuranceProductDetailChoiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceProductDetailChoiceModelToJson(this);
}