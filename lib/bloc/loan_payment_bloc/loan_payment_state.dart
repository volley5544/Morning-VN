part of 'loan_payment_bloc.dart';

abstract class LoanPaymentState extends Equatable {
  final LoanInstallmentDetailMedel loanPaymentDetail;
  final PaymentDetail paymentDetail;
  const LoanPaymentState(
      {required this.loanPaymentDetail, required this.paymentDetail});

  @override
  List<Object> get props => [];
}

class LoanPaymentInitial extends LoanPaymentState {
  LoanPaymentInitial({
    required super.loanPaymentDetail,
    required super.paymentDetail,
  });
}

class LoanPaymentDetailError extends LoanPaymentState {
  LoanPaymentDetailError({
    required super.loanPaymentDetail,
    required super.paymentDetail,
  });
}

class LoanPaymentDetailLoading extends LoanPaymentState {
  LoanPaymentDetailLoading({
    required super.loanPaymentDetail,
    required super.paymentDetail,
  });
}

class LoanPaymentDetailComplete extends LoanPaymentState {
  LoanPaymentDetailComplete({
    required super.loanPaymentDetail,
    required super.paymentDetail,
  });
}

class LoanPaymentDetailNoInternet extends LoanPaymentState {
  LoanPaymentDetailNoInternet({
    required super.loanPaymentDetail,
    required super.paymentDetail,
  });
}
