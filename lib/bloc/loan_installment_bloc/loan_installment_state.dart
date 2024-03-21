part of 'loan_installment_bloc.dart';

abstract class LoanInstallmentState extends Equatable {
  final LoanInstallmentDetailMedel loanInstallmentDetail;
  const LoanInstallmentState({required this.loanInstallmentDetail});

  @override
  List<Object> get props => [];
}

class LoadLoanInstallmentDetailInitial extends LoanInstallmentState {
  LoadLoanInstallmentDetailInitial({
    required super.loanInstallmentDetail,
  });
}

class LoadLoanInstallmentDetailLoading extends LoanInstallmentState {
  LoadLoanInstallmentDetailLoading({
    required super.loanInstallmentDetail,
  });
}

class LoadLoanInstallmentDetailComplete extends LoanInstallmentState {
  LoadLoanInstallmentDetailComplete({
    required super.loanInstallmentDetail,
  });
}

class LoadLoanInstallmentDetailError extends LoanInstallmentState {
  LoadLoanInstallmentDetailError({
    required super.loanInstallmentDetail,
  });
}
