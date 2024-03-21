part of 'loan_product_bloc.dart';

abstract class LoanProductEvent extends Equatable {
  const LoanProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadLoanProductListEvent extends LoanProductEvent {
  final LoanProductRepository repository;
  final BuildContext context;

  const LoadLoanProductListEvent(this.repository, this.context);
}