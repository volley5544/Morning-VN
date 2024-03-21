import 'package:json_annotation/json_annotation.dart';

import '../product_detail/product_detail_model.dart';
import '../product_detail/product_detail_title_bullet_list_model.dart';
import '../product_detail/product_detail_title_content_list_model.dart';

part 'loan_product_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoanProductDetailModel {
  @JsonKey(name: 'product_id')
  String productId;
  @JsonKey(name: 'product_type')
  String? productType;
  @JsonKey(name: 'asset_type')
  String? assetType;
  @JsonKey(name: 'installment_status')
  String? installmentStatus;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(name: 'loan')
  ProductDetailTopModel? top;
  @JsonKey(name: 'loan_advantage')
  ProductDetailTitleContentListModel? advantage;
  @JsonKey(name: 'loan_document')
  ProductDetailTitleContentListModel? document;
  @JsonKey(name: 'loan_other_document')
  ProductDetailTitleBulletListModel? otherDocument;
  @JsonKey(name: 'qualification')
  ProductDetailTitleBulletListModel? qualification;

  LoanProductDetailModel(
      {required this.productId,
      this.productType,
      this.assetType,
      this.installmentStatus,
      this.imageUrl,
      this.top,
      this.advantage,
      this.document,
      this.otherDocument,
      this.qualification});

  factory LoanProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$LoanProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoanProductDetailModelToJson(this);
}
