import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/product_detail/product_model.dart';
import '../../modules/insurance_product/insurance_product_repository.dart';

part 'insurance_product_event.dart';

part 'insurance_product_state.dart';

class InsuranceProductBloc
    extends Bloc<InsuranceProductEvent, InsuranceProductState> {
  InsuranceProductBloc() : super(InsuranceProductInitial(productList: [])) {
    on<LoadInsuranceProductListEvent>((event, emit) async {
      try {
        if (state.productList.isEmpty) {
          emit(InsuranceProductListLoading(productList: []));
          await event.repository.getProductList().then((data) {
            state.productList = data;
            emit(InsuranceProductListComplete(productList: state.productList));
          }, onError: (e) {
            emit(InsuranceProductListError(productList: state.productList));
          });
        }
      } on RESTApiException catch (e) {
        // logger.e('bloc error RESTApiException :${e.cause.toString()} ');
        emit(InsuranceProductListError(productList: state.productList));
        logger.e(
            'LoadInsuranceProductListEvent error(RESTApiException): ${e.toString()}');
      } catch (e) {
        emit(InsuranceProductListError(productList: state.productList));
      }
    });
  }
}
