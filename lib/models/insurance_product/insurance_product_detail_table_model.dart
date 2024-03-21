
import 'package:json_annotation/json_annotation.dart';
part 'insurance_product_detail_table_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuranceProductDetailTableModel{
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'content')
  String? imageUrl;

  InsuranceProductDetailTableModel({this.title, this.imageUrl});

  factory InsuranceProductDetailTableModel.fromJson(Map<String, dynamic> json) =>
      _$InsuranceProductDetailTableModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceProductDetailTableModelToJson(this);
}