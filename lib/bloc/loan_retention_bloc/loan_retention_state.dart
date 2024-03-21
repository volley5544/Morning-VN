part of 'loan_retention_bloc.dart';

abstract class LoanRetentionState extends Equatable {
  final loanRetentionNumber;
  const LoanRetentionState({required this.loanRetentionNumber});

  @override
  List<Object> get props => [];
}

class LoanRetentionInitial extends LoanRetentionState {
  LoanRetentionInitial({super.loanRetentionNumber});
}

class LoanRetentionLoading extends LoanRetentionState {
  LoanRetentionLoading({super.loanRetentionNumber});
}

class LoanRetentionComplete extends LoanRetentionState {
  LoanRetentionComplete({super.loanRetentionNumber});
}

class LoanRetentionError extends LoanRetentionState {
  LoanRetentionError({super.loanRetentionNumber});
}
