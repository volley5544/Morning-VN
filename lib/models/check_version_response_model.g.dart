// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_version_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckVersionResponseModel _$CheckVersionResponseModelFromJson(
        Map<String, dynamic> json) =>
    CheckVersionResponseModel(
      json['status'] as bool,
      json['playstore_url'] as String?,
      json['applestore_url'] as String?,
    );

Map<String, dynamic> _$CheckVersionResponseModelToJson(
        CheckVersionResponseModel instance) =>
    <String, dynamic>{
      'status': instance.needUpdate,
      'playstore_url': instance.playStoreUrl,
      'applestore_url': instance.appStoreUrl,
    };
