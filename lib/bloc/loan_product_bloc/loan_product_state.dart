part of 'loan_product_bloc.dart';

abstract class LoanProductState extends Equatable {
  late List<ProductModel> productList;

  LoanProductState({required this.productList});

  @override
  List<Object> get props => [productList];
}

class LoanProductInitial extends LoanProductState {
  LoanProductInitial({required super.productList});
}

class LoanProductListLoading extends LoanProductState {
  LoanProductListLoading({required super.productList});
}

class LoanProductListComplete extends LoanProductState {
  LoanProductListComplete({required super.productList});
}

class LoanProductListError extends LoanProductState {
  LoanProductListError({required super.productList});
}
