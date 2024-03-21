import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/models/loan_detail_history.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';

part 'loan_history_event.dart';
part 'loan_history_state.dart';

DateTime? historyListDateNow;

class LoanHistoryBloc extends Bloc<LoanHistoryEvent, LoanHistoryState> {
  LoanHistoryBloc() : super(LoanHistoryInitial(loanDetailHistory: [])) {
    on<LoadLoanHistory>((event, emit) async {
      try {
        emit(LoadLoanInstallmenHistoryLoading(
          loanDetailHistory: state.loanDetailHistory,
        ));
        List<HistoryResult> loanDetailHistory =
            await event.loanRepository.getLoanDetailHistory(event.contractId);
        emit(LoadLoanInstallmenHistoryComplete(
          loanDetailHistory: loanDetailHistory,
        ));
      } on RESTApiException catch (e) {
        logger.e('bloc error RESTApiException :${e.cause.toString()} ');
        emit(LoadLoanInstallmentHistoryError(
          loanDetailHistory: state.loanDetailHistory,
        ));
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
        emit(LoadLoanInstallmenHistoryComplete(
          loanDetailHistory: state.loanDetailHistory,
        ));
      } catch (e) {
        emit(LoadLoanInstallmentHistoryError(
          loanDetailHistory: state.loanDetailHistory,
        ));
        serverSuspendedDialog(event.context);
        emit(LoadLoanInstallmenHistoryComplete(
          loanDetailHistory: state.loanDetailHistory,
        ));
      }
    });
  }
}
