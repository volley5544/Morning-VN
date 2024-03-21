import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_application_srisawad/models/loan_lead/loan_lead_save_product_request_model.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../main.dart';
import '../../modules/loanproduct/loan_product_repository.dart';
import '../../widgets/bottompage.dart';
import '../../widgets/dialog/progress_dialog.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';

part 'loan_lead_event.dart';

part 'loan_lead_state.dart';

class LoanLeadBloc extends Bloc<LoanLeadEvent, LoanLeadState> {
  LoanLeadBloc() : super(LoanLeadInitial()) {
    on<SaveLoanLeadEvent>((event, emit) async {
      var count = 0;
      try {
        showProgressDialog(context: event.context);
        var isSuccess = await event.repository.saveLead(request: event.request);
        hideProgressDialog(event.context);
        if (isSuccess) {
          emit(LoanLeadComplete());
          await ShowBottomSvgVersion(
              event.context,
              'ส่งข้อมูลเรียบร้อย',
              'assets/success-icon.svg',
              'ข้อมูลของคุณได้ส่งให้เจ้าหน้าที่เรียบร้อย\nจะมีเจ้าหน้าที่ติดต่อกลับไปหาคุณภายหลัง',
              () {
            Navigator.of(event.context).popUntil((_) => count++ >= 2);
          }, 'ปิด', enableDrag: false);
        } else {
          emit(LoanLeadError());
          Navigator.of(event.context)
              .restorablePush(serverSuspendedDialog(event.context));
        }
      } on RESTApiException catch (e) {
        hideProgressDialog(event.context);
        emit(LoanLeadError());
        logger.e('SaveLoanLeadEvent error(RESTApiException): ${e.toString()}');
        Navigator.of(event.context).restorablePush(serverSuspendedDialog(
            event.context,
            additionalText: e.cause.toString()));
      } catch (e) {
        hideProgressDialog(event.context);
        emit(LoanLeadError());
        Navigator.of(event.context)
            .restorablePush(serverSuspendedDialog(event.context));
      }
    });
  }
}
