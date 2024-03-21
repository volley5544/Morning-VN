part of 'loan_lead_bloc.dart';

abstract class LoanLeadState extends Equatable {
  const LoanLeadState();

  @override
  List<Object?> get props => [];
}

class LoanLeadInitial extends LoanLeadState {
  LoanLeadInitial();
}

class LoanLeadLoading extends LoanLeadState {
  LoanLeadLoading();
}

class LoanLeadComplete extends LoanLeadState {
  LoanLeadComplete();
}

class LoanLeadError extends LoanLeadState {
  LoanLeadError();
}
