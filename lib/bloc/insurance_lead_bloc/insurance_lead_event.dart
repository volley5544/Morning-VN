part of 'insurance_lead_bloc.dart';

abstract class InsuranceLeadEvent extends Equatable {
  const InsuranceLeadEvent();
  @override
  List<Object?> get props => [];
}

class SaveInsuranceLeadEvent extends InsuranceLeadEvent {
  final InsuranceLeadSaveProductRequestModel request;
  final InsuranceProductRepository repository;
  final BuildContext context;
  SaveInsuranceLeadEvent(
      {required this.request, required this.repository, required this.context});
}