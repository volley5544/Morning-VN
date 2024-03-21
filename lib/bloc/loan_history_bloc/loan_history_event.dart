part of 'loan_history_bloc.dart';

abstract class LoanHistoryEvent extends Equatable {
  const LoanHistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadLoanHistory extends LoanHistoryEvent {
  final String contractId;
  final LoanRepository loanRepository;
  final BuildContext context;
  const LoadLoanHistory(this.contractId, this.loanRepository, this.context);
}
