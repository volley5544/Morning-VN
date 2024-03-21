part of 'loan_retention_bloc.dart';

abstract class LoanRetentionEvent extends Equatable {
  const LoanRetentionEvent();

  @override
  List<Object> get props => [];
}

class LoadLoanRetention extends LoanRetentionEvent {
  const LoadLoanRetention();
}
