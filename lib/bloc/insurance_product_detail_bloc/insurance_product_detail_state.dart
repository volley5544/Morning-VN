part of 'insurance_product_detail_bloc.dart';

abstract class InsuranceProductDetailState extends Equatable {
  InsuranceProductDetailModel? productDetail;
  InsuranceProductDetailState({this.productDetail});

  @override
  List<Object?> get props => [productDetail];
}

class InsuranceProductDetailInitial extends InsuranceProductDetailState {
  InsuranceProductDetailInitial();
}

class InsuranceProductDetailLoading extends InsuranceProductDetailState {
  InsuranceProductDetailLoading();
}

class InsuranceProductDetailComplete extends InsuranceProductDetailState {
  InsuranceProductDetailComplete({required super.productDetail});
}

class InsuranceProductDetailError extends InsuranceProductDetailState {
  InsuranceProductDetailError();
}
class InsuranceProductDetailNoInternet extends InsuranceProductDetailState {
  InsuranceProductDetailNoInternet();
}
