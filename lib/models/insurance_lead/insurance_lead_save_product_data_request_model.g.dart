// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_lead_save_product_data_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceLeadSaveProductDataRequestModel
    _$InsuranceLeadSaveProductDataRequestModelFromJson(
            Map<String, dynamic> json) =>
        InsuranceLeadSaveProductDataRequestModel(
          name: json['name'] as String,
          surname: json['surname'] as String,
          assetType: json['asset_type'] as String,
          phoneNumber: json['phone_number'] as String,
          insuranceType: json['insurance_type'] as String,
          insuranceClass: json['insurance_class'] as String,
          availableTimeToContract: json['avalible_time_to_contract'] as String,
        );

Map<String, dynamic> _$InsuranceLeadSaveProductDataRequestModelToJson(
        InsuranceLeadSaveProductDataRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'asset_type': instance.assetType,
      'phone_number': instance.phoneNumber,
      'insurance_type': instance.insuranceType,
      'insurance_class': instance.insuranceClass,
      'avalible_time_to_contract': instance.availableTimeToContract,
    };
