part of 'loan_payment_bloc.dart';

abstract class LoanPaymentEvent extends Equatable {
  const LoanPaymentEvent();

  @override
  List<Object> get props => [];
}

class LoadPaymentDetail extends LoanPaymentEvent {
  final String consumerNo;
  final String dbName;
  final LoanRepository loanRepository;
  final BuildContext context;
  const LoadPaymentDetail(
      {required this.consumerNo,
      required this.dbName,
      required this.loanRepository,
      required this.context});
}
