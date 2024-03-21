import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/models/loan_detail_history.dart';
import 'package:mobile_application_srisawad/models/loan_installment_detail.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';
import 'package:mobile_application_srisawad/models/qr_code_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';

import '../../util/custom_exception.dart';
import '../topup_bloc/topup_bloc.dart';

part 'loan_event.dart';
part 'loan_state.dart';

DateTime? loanListDateNow;
DateTime? historyListDateNow;

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  LoanBloc()
      : super(LoanInitial(
            isQrCodeSelected: true,
            loanDetailHistory: [],
            loanInstallmentDetail: LoanInstallmentDetailMedel(
                code: '', message: '', paymentAccountData: [], total: 0),
            loanList: [],
            paymentDetail: PaymentDetail(
              detail: LoanPaymentDetail(
                contractBankAccount: '',
                contractCloseDate: '',
                contractName: '',
                contractNo: '',
                collateralInformation: '',
                // loanTypeCode: '',
                dataDate: '',
                loanTypeIcon: '',
                // loanTypeName: '',
              ),
              qrCode: QrCode(data: [], type: ''),
              qrform: Qrform(data: [], type: ''),
              barCode: BarCode(data: [], type: ''),
              barForm: BarForm(data: [], type: ''),
              qrCodeDetail: QrCodeDetail(
                  amount: 0,
                  dataDate: '',
                  fullBarcode: '',
                  prefix: '',
                  ref1: '',
                  ref2: '',
                  taxId: '',
                  code: "",
                  message: '',
                  suffix: ''),
            ),
            loanListData: LoanListData(
                loanDetailList: [],
                sumCurrentDueAmount: 0,
                totalDataDate: ''))) {
    on<LoadLoanList>((event, emit) async {
      try {
        if (loanListDateNow == null) {
          loanListDateNow = DateTime.now();
        }

        if (state.loanList.isEmpty ||
            DateTime.now().minute > loanListDateNow!.minute + 5) {
          loanListDateNow = DateTime.now();
          emit(LoanListLoading(
              isQrCodeSelected: state.isQrCodeSelected,
              loanDetailHistory: state.loanDetailHistory,
              loanInstallmentDetail: state.loanInstallmentDetail,
              loanList: state.loanList,
              paymentDetail: state.paymentDetail,
              loanListData: state.loanListData));
          LoanListData loanListData =
              await event.loanRepository.getLoanList(event.consumerId);
          BlocProvider.of<TopupBloc>(event.context)
              .add(SetTopupList(loanList: loanListData.loanDetailList));

          emit(LoanListComplete(
              loanList: loanListData.loanDetailList,
              isQrCodeSelected: state.isQrCodeSelected,
              loanDetailHistory: state.loanDetailHistory,
              loanInstallmentDetail: state.loanInstallmentDetail,
              paymentDetail: state.paymentDetail,
              loanListData: loanListData));
        } else {
          emit(LoanListLoading(
              isQrCodeSelected: state.isQrCodeSelected,
              loanDetailHistory: state.loanDetailHistory,
              loanInstallmentDetail: state.loanInstallmentDetail,
              loanList: state.loanList,
              paymentDetail: state.paymentDetail,
              loanListData: state.loanListData));
          emit(LoanListComplete(
              loanList: state.loanList,
              isQrCodeSelected: state.isQrCodeSelected,
              loanDetailHistory: state.loanDetailHistory,
              loanInstallmentDetail: state.loanInstallmentDetail,
              paymentDetail: state.paymentDetail,
              loanListData: state.loanListData));
        }
      } on RESTApiException catch (e) {
        logger.e('bloc error RESTApiException :${e.cause.toString()} ');
        emit(LoanListError(
            isQrCodeSelected: state.isQrCodeSelected,
            loanDetailHistory: state.loanDetailHistory,
            loanInstallmentDetail: state.loanInstallmentDetail,
            loanList: state.loanList,
            paymentDetail: state.paymentDetail,
            loanListData: state.loanListData));

        if (canPop(event.context)) {
          Navigator.of(event.context).pop();
        }
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
      } catch (e) {
        emit(LoanListError(
            isQrCodeSelected: state.isQrCodeSelected,
            loanDetailHistory: state.loanDetailHistory,
            loanInstallmentDetail: state.loanInstallmentDetail,
            loanList: state.loanList,
            paymentDetail: state.paymentDetail,
            loanListData: state.loanListData));
        if (canPop(event.context)) {
          Navigator.of(event.context).pop();
        }
        serverSuspendedDialog(event.context);
      }
    });

    on<ResetLoanState>((event, emit) async {
      state.loanDetailHistory = [];
      state.loanList = [];
      state.loanListData = LoanListData(
          loanDetailList: [], sumCurrentDueAmount: 0, totalDataDate: '');
      loanListDateNow = null;
      historyListDateNow = null;
    });
  }
}

bool canPop(BuildContext context) {
  final NavigatorState? navigator = Navigator.maybeOf(context);
  return navigator != null && navigator.canPop();
}
