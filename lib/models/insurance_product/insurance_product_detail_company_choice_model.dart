import 'package:json_annotation/json_annotation.dart';

part 'insurance_product_detail_company_choice_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuranceProductDetailCompanyChoiceModel {
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  List<String>? imageUrlList;

  InsuranceProductDetailCompanyChoiceModel({this.title, this.imageUrlList});

  factory InsuranceProductDetailCompanyChoiceModel.fromJson(
          Map<String, dynamic> json) =>
      _$InsuranceProductDetailCompanyChoiceModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$InsuranceProductDetailCompanyChoiceModelToJson(this);
}
