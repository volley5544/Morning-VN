import 'package:json_annotation/json_annotation.dart';

import 'insurance_lead_save_product_data_request_model.dart';

part 'insurance_lead_save_product_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuranceLeadSaveProductRequestModel{
  @JsonKey(name: 'hash_thai_id')
  String hashThaiId;
  @JsonKey(name: 'product_type')
  String productType;
  @JsonKey(name: 'data')
  InsuranceLeadSaveProductDataRequestModel data;

  InsuranceLeadSaveProductRequestModel(this.hashThaiId, this.productType, this.data);

  factory InsuranceLeadSaveProductRequestModel.fromJson(Map<String, dynamic> json) =>
      _$InsuranceLeadSaveProductRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceLeadSaveProductRequestModelToJson(this);
}