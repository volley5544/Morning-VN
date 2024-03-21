
import 'package:json_annotation/json_annotation.dart';

import '../product_detail/product_detail_model.dart';
import '../product_detail/product_detail_title_content_list_model.dart';
import 'insurance_product_detail_choice_model.dart';
import 'insurance_product_detail_company_choice_model.dart';
import 'insurance_product_detail_table_model.dart';
part 'insurance_product_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuranceProductDetailModel{
  @JsonKey(name: 'product_id')
  String productId;
  @JsonKey(name: 'product_type')
  String? productType;
  @JsonKey(name: 'insurance_type')
  String? insuranceType;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'insurance')
  ProductDetailTopModel? insuranceTop;
  @JsonKey(name: 'insurance_advantage')
  ProductDetailTitleContentListModel? insuranceAdvantage;
  @JsonKey(name: 'insurance_table')
  InsuranceProductDetailTableModel? insuranceTable;
  @JsonKey(name: 'insurance_company_choice')
  InsuranceProductDetailCompanyChoiceModel? insuranceCompanyChoice;
  @JsonKey(name: 'insurance_choice')
  InsuranceProductDetailChoiceModel? insuranceChoice;


  InsuranceProductDetailModel({
      required this.productId,
      this.productType,
      this.insuranceType,
      this.imageUrl,
      this.insuranceTop,
      this.insuranceAdvantage,
      this.insuranceTable,
      this.insuranceCompanyChoice,
      this.insuranceChoice});

  factory InsuranceProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$InsuranceProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceProductDetailModelToJson(this);
}
