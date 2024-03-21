import 'package:json_annotation/json_annotation.dart';
part 'insurance_lead_save_product_data_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class InsuranceLeadSaveProductDataRequestModel{
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'surname')
  String surname;
  @JsonKey(name: 'asset_type')
  String assetType;
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  @JsonKey(name: 'insurance_type')
  String insuranceType;
  @JsonKey(name: 'insurance_class')
  String insuranceClass;
  @JsonKey(name: 'avalible_time_to_contract')
  String availableTimeToContract;

  InsuranceLeadSaveProductDataRequestModel({
      required this.name,
      required this.surname,
      required this.assetType,
      required this.phoneNumber,
      required this.insuranceType,
      required this.insuranceClass,
      required this.availableTimeToContract});

  factory InsuranceLeadSaveProductDataRequestModel.fromJson(Map<String, dynamic> json) =>
      _$InsuranceLeadSaveProductDataRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceLeadSaveProductDataRequestModelToJson(this);
}