part of 'loan_installment_bloc.dart';

abstract class LoanInstallmentEvent extends Equatable {
  const LoanInstallmentEvent();

  @override
  List<Object> get props => [];
}

class LoadLoanInstallmentDetail extends LoanInstallmentEvent {
  final String consumerNo;
  final LoanRepository loanRepository;
  final BuildContext context;
  final String dbName;
  const LoadLoanInstallmentDetail(
      this.consumerNo, this.loanRepository, this.context, this.dbName);
}
