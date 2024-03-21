part of 'insurance_lead_bloc.dart';

abstract class InsuranceLeadState extends Equatable {
  const InsuranceLeadState();
  @override
  List<Object?> get props => [];
}

class InsuranceLeadInitial extends InsuranceLeadState {
  InsuranceLeadInitial();
}

class InsuranceLeadLoading extends InsuranceLeadState {
  InsuranceLeadLoading();
}

class InsuranceLeadComplete extends InsuranceLeadState {
  InsuranceLeadComplete();
}

class InsuranceLeadError extends InsuranceLeadState {
  InsuranceLeadError();
}
