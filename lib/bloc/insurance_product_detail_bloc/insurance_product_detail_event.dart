part of 'insurance_product_detail_bloc.dart';

abstract class InsuranceProductDetailEvent extends Equatable {
  const InsuranceProductDetailEvent();
  @override
  List<Object?> get props => [];

}
class LoadInsuranceProductDetailEvent extends InsuranceProductDetailEvent {
  final String productId;
  final InsuranceProductRepository repository;
  final BuildContext context;
  LoadInsuranceProductDetailEvent(
      {required this.productId, required this.repository, required this.context});
}