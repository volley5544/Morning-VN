part of 'loan_product_detail_bloc.dart';

abstract class LoanProductDetailEvent extends Equatable {
  const LoanProductDetailEvent();
  @override
  List<Object?> get props => [];

}
class LoadLoanProductDetailEvent extends LoanProductDetailEvent {
  final String productId;
  final LoanProductRepository repository;
  final BuildContext context;
  LoadLoanProductDetailEvent(
      {required this.productId, required this.repository, required this.context});
}