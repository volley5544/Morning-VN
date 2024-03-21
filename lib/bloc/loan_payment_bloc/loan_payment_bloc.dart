import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/models/loan_detail_history.dart';
import 'package:mobile_application_srisawad/models/loan_installment_detail.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';

part 'loan_payment_event.dart';
part 'loan_payment_state.dart';

class LoanPaymentBloc extends Bloc<LoanPaymentEvent, LoanPaymentState> {
  LoanPaymentBloc()
      : super(LoanPaymentInitial(
            loanPaymentDetail: loanInstallmentDetailMedelDefault,
            paymentDetail: paymentDetailDefault)) {
    on<LoadPaymentDetail>((event, emit) async {
      if (await InternetConnectionChecker().hasConnection) {
        try {
          emit(LoanPaymentDetailLoading(
            loanPaymentDetail: state.loanPaymentDetail,
            paymentDetail: paymentDetailDefault,
          ));
          PaymentDetail paymentDetail = await event.loanRepository
              .getPaymentDetail(event.consumerNo, event.dbName);
          emit(LoanPaymentDetailComplete(
            loanPaymentDetail: state.loanPaymentDetail,
            paymentDetail: paymentDetail,
          ));
        } on RESTApiException catch (e) {
          logger.e('bloc error RESTApiException :${e.cause.toString()} ');
          emit(LoanPaymentDetailError(
            loanPaymentDetail: state.loanPaymentDetail,
            paymentDetail: paymentDetailDefault,
          ));
          Navigator.of(event.context).pop();
          serverSuspendedDialog(event.context,
              additionalText: e.cause.toString());
        } catch (e) {
          logger.e('bloc error : ${e.toString()}');
          emit(LoanPaymentDetailError(
            loanPaymentDetail: state.loanPaymentDetail,
            paymentDetail: paymentDetailDefault,
          ));
          Navigator.of(event.context).pop();
          serverSuspendedDialog(event.context, additionalText: e.toString());
        }
      } else {
        emit(LoanPaymentDetailNoInternet(
          loanPaymentDetail: state.loanPaymentDetail,
          paymentDetail: paymentDetailDefault,
        ));
      }
    });
  }
}
