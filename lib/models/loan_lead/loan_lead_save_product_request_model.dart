import 'package:json_annotation/json_annotation.dart';

import 'loan_lead_save_product_data_request_model.dart';
part 'loan_lead_save_product_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanLeadSaveProductRequestModel{
  @JsonKey(name: 'hash_thai_id')
  String hashThaiId;
  @JsonKey(name: 'product_type')
  String productType;
  @JsonKey(name: 'data')
  LoanLeadSaveProductDataRequestModel data;

  LoanLeadSaveProductRequestModel(this.hashThaiId, this.productType, this.data);

  factory LoanLeadSaveProductRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoanLeadSaveProductRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanLeadSaveProductRequestModelToJson(this);
}