part of 'insurance_product_bloc.dart';

abstract class InsuranceProductState extends Equatable {
  late List<ProductModel> productList;

  InsuranceProductState({required this.productList});

  @override
  List<Object> get props => [productList];
}

class InsuranceProductInitial extends InsuranceProductState {
  InsuranceProductInitial({required super.productList});
}

class InsuranceProductListComplete extends InsuranceProductState {
  InsuranceProductListComplete({required super.productList});
}

class InsuranceProductListLoading extends InsuranceProductState {
  InsuranceProductListLoading({required super.productList});
}

class InsuranceProductListError extends InsuranceProductState {
  InsuranceProductListError({required super.productList});
}

class InsuranceProductDetailComplete extends InsuranceProductState {
  InsuranceProductDetailComplete({required super.productList});
}

class InsuranceProductDetailLoading extends InsuranceProductState {
  InsuranceProductDetailLoading({required super.productList});
}

class InsuranceProductDetailError extends InsuranceProductState {
  InsuranceProductDetailError({required super.productList});
}