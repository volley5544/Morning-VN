import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/insurance_lead/insurance_lead_save_product_request_model.dart';
import '../../modules/insurance_product/insurance_product_repository.dart';
import '../../widgets/bottompage.dart';
import '../../widgets/dialog/progress_dialog.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';

part 'insurance_lead_event.dart';
part 'insurance_lead_state.dart';

class InsuranceLeadBloc extends Bloc<InsuranceLeadEvent, InsuranceLeadState> {
  InsuranceLeadBloc() : super(InsuranceLeadInitial()) {
    on<SaveInsuranceLeadEvent>((event, emit) async {
      var count = 0;
      showProgressDialog(context: event.context);
      try {
        var isSuccess = await event.repository.saveLead(request: event.request);
        hideProgressDialog(event.context);
        if (isSuccess) {
          await ShowBottomSvgVersion(
              event.context,
              'ส่งข้อมูลเรียบร้อย',
              'assets/success-icon.svg',
              'ข้อมูลของคุณได้ส่งให้เจ้าหน้าที่เรียบร้อย\nจะมีเจ้าหน้าที่ติดต่อกลับไปหาคุณภายหลัง',
              () {
            Navigator.of(event.context).popUntil((_) => count++ >= 2);
          }, 'ปิด', enableDrag: false);
        } else {
          emit(InsuranceLeadError());
          Navigator.of(event.context)
              .restorablePush(serverSuspendedDialog(event.context));
        }
      } on RESTApiException catch (e) {
        hideProgressDialog(event.context);
        emit(InsuranceLeadError());
        logger.e(
            'SaveInsuranceLeadEvent error(RESTApiException): ${e.toString()}');
        Navigator.of(event.context).restorablePush(serverSuspendedDialog(
            event.context,
            additionalText: e.cause.toString()));
      } catch (e) {
        hideProgressDialog(event.context);
        emit(InsuranceLeadError());
        Navigator.of(event.context)
            .restorablePush(serverSuspendedDialog(event.context));
      }
    });
  }
}
