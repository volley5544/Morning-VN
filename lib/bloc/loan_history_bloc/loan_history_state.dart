part of 'loan_history_bloc.dart';

abstract class LoanHistoryState extends Equatable {
  final List<HistoryResult> loanDetailHistory;
  const LoanHistoryState({required this.loanDetailHistory});

  @override
  List<Object> get props => [];
}

class LoanHistoryInitial extends LoanHistoryState {
  LoanHistoryInitial({required super.loanDetailHistory});
}

class LoadLoanInstallmenHistoryLoading extends LoanHistoryState {
  LoadLoanInstallmenHistoryLoading({
    required super.loanDetailHistory,
  });
}

class LoadLoanInstallmenHistoryComplete extends LoanHistoryState {
  LoadLoanInstallmenHistoryComplete({
    required super.loanDetailHistory,
  });
}

class LoadLoanInstallmentHistoryError extends LoanHistoryState {
  LoadLoanInstallmentHistoryError({
    required super.loanDetailHistory,
  });
}
