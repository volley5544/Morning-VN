part of 'loan_bloc.dart';

abstract class LoanEvent extends Equatable {
  const LoanEvent();

  @override
  List<Object> get props => [];
}

class LoadLoanList extends LoanEvent {
  final String consumerId;
  final LoanRepository loanRepository;
  final BuildContext context;
  const LoadLoanList(this.consumerId, this.loanRepository, this.context);
}

class LoadLoanDetail extends LoanEvent {
  final String consumerNo;
  final String dbName;
  final LoanRepository loanRepository;
  final BuildContext context;
  const LoadLoanDetail(
      this.consumerNo, this.dbName, this.loanRepository, this.context);
}

class SetLoadLoanListComplete extends LoanEvent {
  final String consumerId;
  final LoanRepository loanRepository;
  const SetLoadLoanListComplete(this.consumerId, this.loanRepository);
}

class ResetLoanState extends LoanEvent {
  const ResetLoanState();
}
