import 'package:json_annotation/json_annotation.dart';
part 'check_version_response_model.g.dart';

@JsonSerializable()
class CheckVersionResponseModel{
  @JsonKey(name: 'status')
  bool needUpdate;
  @JsonKey(name: 'playstore_url')
  String? playStoreUrl;
  @JsonKey(name: 'applestore_url')
  String? appStoreUrl;
  CheckVersionResponseModel(this.needUpdate, [this.playStoreUrl, this.appStoreUrl]);

  factory CheckVersionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CheckVersionResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CheckVersionResponseModelToJson(this);
}