import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/models/product_detail/product_model.dart';
import 'package:mobile_application_srisawad/modules/loanproduct/loan_product_repository.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

part 'loan_product_event.dart';

part 'loan_product_state.dart';

class LoanProductBloc extends Bloc<LoanProductEvent, LoanProductState> {
  LoanProductBloc() : super(LoanProductInitial(productList: [])) {
    on<LoadLoanProductListEvent>((event, emit) async {
      try {
        if (state.productList.isEmpty) {
          emit(LoanProductListLoading(productList: []));
          await event.repository.getLoanProductList().then((data) {
            state.productList = data;
            emit(LoanProductListComplete(productList: state.productList));
          }, onError: (e) {
            emit(LoanProductListError(productList: state.productList));
          });
        }
      } on RESTApiException catch (e) {
        // logger.e('bloc error RESTApiException :${e.cause.toString()} ');
        emit(LoanProductListError(productList: state.productList));
        logger.e(
            'LoadLoanProductListEvent error(RESTApiException): ${e.toString()}');
      } catch (e) {
        emit(LoanProductListError(productList: state.productList));
      }
    });
  }
}
