import 'package:json_annotation/json_annotation.dart';
part 'loan_lead_save_product_data_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanLeadSaveProductDataRequestModel{
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'surname')
  String surname;
  @JsonKey(name: 'phone_number')
  String phoneNumber;
  @JsonKey(name: 'asset_type')
  String assetType;
  @JsonKey(name: 'installment_status')
  String installmentStatus;
  @JsonKey(name: 'credit_limit')
  String creditLimit;
  @JsonKey(name: 'expected_date')
  String expectedDate;
  @JsonKey(name: 'avalible_time_to_contract')
  String availableTimeToContract;

  LoanLeadSaveProductDataRequestModel({
      required this.name,
      required this.surname,
      required this.phoneNumber,
      required this.assetType,
      required this.installmentStatus,
      required this.creditLimit,
      required this.expectedDate,
      required this.availableTimeToContract});

  factory LoanLeadSaveProductDataRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoanLeadSaveProductDataRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanLeadSaveProductDataRequestModelToJson(this);
}