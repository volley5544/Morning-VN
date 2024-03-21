import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/insurance_product/insurance_product_detail_model.dart';
import '../../modules/insurance_product/insurance_product_repository.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';

part 'insurance_product_detail_event.dart';

part 'insurance_product_detail_state.dart';

class InsuranceProductDetailBloc
    extends Bloc<InsuranceProductDetailEvent, InsuranceProductDetailState> {
  InsuranceProductDetailBloc() : super(InsuranceProductDetailInitial()) {
    on<LoadInsuranceProductDetailEvent>((event, emit) async {
      bool hasConnection = await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        emit(InsuranceProductDetailNoInternet());
      } else {
        emit(InsuranceProductDetailError());
        try {
          emit(InsuranceProductDetailLoading());
          var data = await event.repository
              .getProductDetail(productId: event.productId);
          if (data == null) {
            emit(InsuranceProductDetailError());
            Navigator.of(event.context).pop();
            Navigator.of(event.context)
                .restorablePush(serverSuspendedDialog(event.context));
          } else {
            state.productDetail = data;
            emit(InsuranceProductDetailComplete(
                productDetail: state.productDetail));
          }
        } on RESTApiException catch (e) {
          // logger.e('bloc error RESTApiException :${e.cause.toString()} ');
          logger.e(
              'LoadInsuranceProductDetailEvent error(RESTApiException): ${e.toString()}');
          emit(InsuranceProductDetailError());
          Navigator.of(event.context).pop();
          Navigator.of(event.context).restorablePush(serverSuspendedDialog(
              event.context,
              additionalText: e.cause.toString()));
        } catch (e) {
          emit(InsuranceProductDetailError());
          Navigator.of(event.context).pop();
          Navigator.of(event.context)
              .restorablePush(serverSuspendedDialog(event.context));
        }
      }
    });
  }
}
