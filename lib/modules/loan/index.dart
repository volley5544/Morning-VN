import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/models/loan_detail_history.dart';
import 'package:mobile_application_srisawad/models/loan_installment_detail.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';
import 'package:mobile_application_srisawad/models/qr_code_detail.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'dart:convert' as convert;

import '../../util/custom_exception.dart';

List<LoanDetail> parseLoanDetailList(String responseBody) {
  try {
    final parsed = convert.jsonDecode(responseBody);
    return List<LoanDetail>.from(parsed['results'].map((x) {
      return LoanDetail.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch when parse list e $e');
    return [];
  }
}

List<PaymentAccountData> parsePaymentAccountData(String responseBody) {
  try {
    final parsed = convert.jsonDecode(responseBody);
    return List<PaymentAccountData>.from(
        parsed['loanDetail']['accounts'].map((x) {
      return PaymentAccountData.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch when parse e $e');
    return [];
  }
}

List<LoanDetail> parsePaymentDetail(String responseBody) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responseBody);
    return List<LoanDetail>.from(parsed["items"].map((x) {
      return LoanDetail.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch e $e');
    return [];
  }
}

List<HistoryResult> parseLoanDetailHistory(String responseBody) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responseBody);
    return List<HistoryResult>.from(parsed["data"].map((x) {
      return HistoryResult.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch e $e');
    return [];
  }
}

class LoanRepository {
  Future<LoanListData> getLoanList(String consumerId) async {
    final response = await Service.rest(
      method: 'get',
      url: 'loan/list',
      query: {'hash_thai_id': consumerId},
    );
    try {
      if (response['status'].toString() == '200') {
        final stringArr = response['res'];
        final List<LoanDetail> loanList = parseLoanDetailList(stringArr);

        final Map<String, dynamic> parsed = convert.jsonDecode(stringArr);
        LoanListData loanListData = LoanListData(
            loanDetailList: loanList,
            sumCurrentDueAmount: parsed['sum_current_due_amount'].toDouble(),
            totalDataDate: parsed['total_data_date']);
        return loanListData;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e('Caught error in getLoanList :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getLoanList :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<PaymentDetail> getPaymentDetail(
      String consumerNo, String dbName) async {
    final response = await Service.rest(
      method: 'get',
      url: 'payment',
      query: {'id': consumerNo, 'db_name': dbName},
    );
    try {
      if (response['status'].toString() == '200') {
        final PaymentDetail loanList = PaymentDetail.fromJson(
            convert.jsonDecode(response['res'].toString()));
        return loanList;
      } else {
//         {
//     "errorCode": "THA00001",
//     "errorDescription": "ENOENT: no such file or directory, open '../assets/qrcode-form.png'"
// }
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e('Caught error in getPaymentDetail :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getPaymentDetail :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  LoanInstallmentDetailMedel defaultLoanPaymentDetail =
      LoanInstallmentDetailMedel(
          code: '', message: '', paymentAccountData: [], total: 0);

  Future<LoanInstallmentDetailMedel> getLoanInstallmentDetail(
      String consumerNo, String dbName) async {
    final response = await Service.rest(
      method: 'get',
      url: 'loan/detail',
      query: {'contract_no': consumerNo, 'db_name': dbName},
    );
    try {
      if (response['status'].toString() == '200') {
        final LoanInstallmentDetailMedel loanInstallmentDetail =
            LoanInstallmentDetailMedel.fromJson(
                convert.jsonDecode(response['res'].toString()));
        return loanInstallmentDetail;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getLoanInstallmentDetail :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getLoanInstallmentDetail :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<List<HistoryResult>> getLoanDetailHistory(String contractNo) async {
    final response = await Service.rest(
      method: 'get',
      url: 'payment/history/$contractNo',
    );
    try {
      if (response['status'].toString() == '200') {
        var map = convert.jsonDecode(response['res'].toString());
        final List<HistoryResult> loanDetailHistory =
            parseLoanDetailHistory(response['res']);
        return loanDetailHistory;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e('Caught error in getLoanDetailHistory :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getLoanDetailHistory :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
