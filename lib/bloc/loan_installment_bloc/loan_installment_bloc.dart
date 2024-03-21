import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/models/loan_detail_history.dart';
import 'package:mobile_application_srisawad/models/loan_installment_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';

part 'loan_installment_event.dart';
part 'loan_installment_state.dart';

DateTime? historyListDateNow;

class LoanInstallmentBloc
    extends Bloc<LoanInstallmentEvent, LoanInstallmentState> {
  LoanInstallmentBloc()
      : super(LoadLoanInstallmentDetailInitial(
            loanInstallmentDetail: loanInstallmentDetailMedelDefault)) {
    on<LoadLoanInstallmentDetail>((event, emit) async {
      try {
        emit(LoadLoanInstallmentDetailLoading(
          loanInstallmentDetail: state.loanInstallmentDetail,
        ));
        LoanInstallmentDetailMedel loanInstallmentDetail = await event
            .loanRepository
            .getLoanInstallmentDetail(event.consumerNo, event.dbName);
        emit(LoadLoanInstallmentDetailComplete(
          loanInstallmentDetail: loanInstallmentDetail,
        ));
      } on RESTApiException catch (e) {
        logger.e('bloc error RESTApiException :${e.cause.toString()} ');
        emit(LoadLoanInstallmentDetailError(
          loanInstallmentDetail: state.loanInstallmentDetail,
        ));
        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
        emit(LoadLoanInstallmentDetailComplete(
          loanInstallmentDetail: state.loanInstallmentDetail,
        ));
      } catch (e) {
        emit(LoadLoanInstallmentDetailError(
          loanInstallmentDetail: state.loanInstallmentDetail,
        ));
        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context);
        emit(LoadLoanInstallmentDetailComplete(
          loanInstallmentDetail: state.loanInstallmentDetail,
        ));
      }
    });
  }
}
