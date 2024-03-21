part of 'loan_lead_bloc.dart';

abstract class LoanLeadEvent extends Equatable {
  const LoanLeadEvent();
  @override
  List<Object?> get props => [];
}

class SaveLoanLeadEvent extends LoanLeadEvent {
  final LoanLeadSaveProductRequestModel request;
  final LoanProductRepository repository;
  final BuildContext context;
  SaveLoanLeadEvent(
      {required this.request, required this.repository, required this.context});
}