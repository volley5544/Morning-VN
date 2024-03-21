part of 'loan_product_detail_bloc.dart';

abstract class LoanProductDetailState extends Equatable {
   LoanProductDetailModel? productDetail;
   LoanProductDetailState({this.productDetail});

  @override
  List<Object?> get props => [productDetail];
}

class LoanProductDetailInitial extends LoanProductDetailState {
  LoanProductDetailInitial();
}

class LoanProductDetailLoading extends LoanProductDetailState {
  LoanProductDetailLoading();
}

class LoanProductDetailComplete extends LoanProductDetailState {
  LoanProductDetailComplete({required super.productDetail});
}

class LoanProductDetailError extends LoanProductDetailState {
  LoanProductDetailError();
}
class LoanProductDetailNoInternet extends LoanProductDetailState {
  LoanProductDetailNoInternet();
}
