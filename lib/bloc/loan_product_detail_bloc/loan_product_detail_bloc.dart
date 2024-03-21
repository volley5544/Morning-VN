import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/loan_product/loan_product_detail_model.dart';
import '../../modules/loanproduct/loan_product_repository.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';

part 'loan_product_detail_event.dart';

part 'loan_product_detail_state.dart';

class LoanProductDetailBloc
    extends Bloc<LoanProductDetailEvent, LoanProductDetailState> {
  LoanProductDetailBloc() : super(LoanProductDetailInitial()) {
    on<LoadLoanProductDetailEvent>((event, emit) async {
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        emit(LoanProductDetailNoInternet());
      } else {
        try {
          emit(LoanProductDetailLoading());
          var data = await event.repository
              .getLoanProductDetail(productId: event.productId);
          if (data == null) {
            emit(LoanProductDetailError());
            Navigator.of(event.context).pop();
            Navigator.of(event.context)
                .restorablePush(serverSuspendedDialog(event.context));
          } else {
            state.productDetail = data;
            emit(LoanProductDetailComplete(productDetail: state.productDetail));
          }
        } on RESTApiException catch (e) {
          logger.e(
              'LoadInsuranceProductDetailEvent error(RESTApiException): ${e.cause.toString()}');
          emit(LoanProductDetailError());
          Navigator.of(event.context).pop();
          Navigator.of(event.context).restorablePush(serverSuspendedDialog(
              event.context,
              additionalText: e.cause.toString()));
        } catch (e) {
          emit(LoanProductDetailError());
          Navigator.of(event.context).pop();
          Navigator.of(event.context)
              .restorablePush(serverSuspendedDialog(event.context));
        }
      }
    });
  }
}
