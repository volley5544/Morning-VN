// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_lead_save_product_data_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanLeadSaveProductDataRequestModel
    _$LoanLeadSaveProductDataRequestModelFromJson(Map<String, dynamic> json) =>
        LoanLeadSaveProductDataRequestModel(
          name: json['name'] as String,
          surname: json['surname'] as String,
          phoneNumber: json['phone_number'] as String,
          assetType: json['asset_type'] as String,
          installmentStatus: json['installment_status'] as String,
          creditLimit: json['credit_limit'] as String,
          expectedDate: json['expected_date'] as String,
          availableTimeToContract: json['avalible_time_to_contract'] as String,
        );

Map<String, dynamic> _$LoanLeadSaveProductDataRequestModelToJson(
        LoanLeadSaveProductDataRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'phone_number': instance.phoneNumber,
      'asset_type': instance.assetType,
      'installment_status': instance.installmentStatus,
      'credit_limit': instance.creditLimit,
      'expected_date': instance.expectedDate,
      'avalible_time_to_contract': instance.availableTimeToContract,
    };
