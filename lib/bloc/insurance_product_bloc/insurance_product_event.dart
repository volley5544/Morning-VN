part of 'insurance_product_bloc.dart';

abstract class InsuranceProductEvent extends Equatable {
  const InsuranceProductEvent();

  @override
  List<Object?> get props => [];
}

class LoadInsuranceProductListEvent extends InsuranceProductEvent {
  final InsuranceProductRepository repository;
  final BuildContext context;

  const LoadInsuranceProductListEvent(this.repository, this.context);
}

class LoadInsuranceProductDetailEvent extends InsuranceProductEvent {
  final int id;
  final InsuranceProductRepository repository;
  final BuildContext context;

  const LoadInsuranceProductDetailEvent({
    required this.id,
    required this.repository,
    required this.context,
  });
}
