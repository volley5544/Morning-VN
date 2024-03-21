import 'dart:convert' as convert;
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/topup_status_detail_model.dart';
import 'package:mobile_application_srisawad/models/topup_status_model.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

import '../../models/topup_data.dart';

// import '../../models/topupData.dart';
import '../../services/localStorage/local_storage.dart' as ls;
import '../../models/topup_installment_number.dart';
import '../../models/topup_pdf.dart';
import '../../models/user_addresses.dart';
import '../../util/custom_exception.dart';
import '../service.dart';

List<TopupList> parseListUp(String responese) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responese);
    return List<TopupList>.from(parsed["items"].map((x) {
      return TopupList.fromJson(x);
    }));
  } catch (e) {
    return [];
  }
}

List<UserAddresses> parseAddressList(String responseBody) {
  try {
    final Map<String, dynamic> parsed = convert.jsonDecode(responseBody);
    return List<UserAddresses>.from(parsed["installments"].map((x) {
      return UserAddresses.fromJson(x);
    }));
  } catch (e) {
    logger.e('catch e $e');
    return [];
  }
}

class TopupRepository {
  Future<TopupData> getTopupDetail(String dbmane, String id) async {
    final response = await Service.rest(
        method: 'get',
        url: 'topup/detail',
        query: {'db_name': dbmane, 'contract_no': id});
    try {
      if (response['status'].toString() == '200') {
        TopupData userData = TopupData.fromJson(
          convert.jsonDecode(response['res'].toString()),
        );
        return userData;
      } else {
        // final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException('${response['res']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getTopupDetail :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getTopupDetail :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<TopupInstallmentNumber> getInstallmentNumbers({
    required String id,
    required String transactionNo,
    required double amount,
    required String dbName,
    required double topupFeeAmount,
    required double feeAmount,
    required double interestRate,
  }) async {
    var body = json.encode({
      "transno": transactionNo,
      "db_name": dbName,
      "contract_no": id,
      "loan_amount": amount,
      "interest_rate": interestRate,
      "topup_fee_amount": topupFeeAmount,
      "fee_amount": topupFeeAmount
    });
    // TODO saksit fix hard code in body
    final response = await Service.rest(
        method: 'post',
        url: 'topup/calculator',
        headers: {"content-type": "application/json"},
        body: body);
    try {
      if (response['status'].toString() == '200') {
        // Map<String, dynamic> amountParsed = convert.jsonDecode(response['res']);

        TopupInstallmentNumber topupInstallmentNumber =
            TopupInstallmentNumber.fromJson(jsonDecode(response['res']));

        return topupInstallmentNumber;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getInstallmentNumbers :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (_, stack) {
      logger.e('Exception: ' + _.toString());
      logger.e('Stacktrace: ' + stack.toString());
      throw Exception(stack.toString());
    }
  }

  Future<TopupDetailStatusModel> getTopupDetailStatus(
      String id, String dbName) async {
    //TODO Saksit $hash_thai_id/$db_name/$id
    logger.i('Initial getTopupDetailStatus function');
    String tempUrl = 'topup/status-detail/$hashThaiId/$dbName/$id';
    final response = await Service.rest(
      method: 'get',
      url: tempUrl,
    );

    try {
      if (response['status'].toString() == '200') {
        final TopupDetailStatusModel listShot = TopupDetailStatusModel.fromJson(
            convert.jsonDecode(response['res']));
        return listShot;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
      // return getTopupDetailStatus(id);
    } on RESTApiException catch (e) {
      logger.e('Caught error in getTopupDetailStatus :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in GetTopupDetailStatus "default catch" : ${e}');
      throw new Exception(e.toString());
    }
  }

  Future<UserAddresses> getUserAddressbyHashId(String id) async {
    final response = await Service.rest(
      method: 'get',
      url: 'profile/address/${id}',
    );
    try {
      if (response['status'].toString() == '200') {
        UserAddresses userAddresses = UserAddresses.fromJson(
          convert.jsonDecode(response['res'].toString()),
        );
        return userAddresses;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getUserAddressbyHashId :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getUserAddressbyHashId :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<TopupPdf> getDoccuments(TopupSubmitForm topupSubmitForm) async {
    var body = json.encode({
      "contract_no": topupSubmitForm.contractNo,
      "db_name": topupSubmitForm.dbName,
      "amount": topupSubmitForm.amount,
      "from": topupSubmitForm.from,
      "contract_bank_account": topupSubmitForm.contractBankAccount,
      "contract_bank_brandname": topupSubmitForm.contractBankBrandname,
      "contract_bank_type": topupSubmitForm.contractBankType,
      "contract_bank_branch": topupSubmitForm.contractBankBranch,
      "hash_thai_id": hashThaiId,
      "interest_rate": topupSubmitForm.interestRate,
      "installment_number": topupSubmitForm.installmentNumber,
      "amount_per_installment": topupSubmitForm.amountPerInstallment,
      "start_installment_date": topupSubmitForm.startInstallmentDate,
      "installment_date": topupSubmitForm.installmentDate,
      "vehicle_type": topupSubmitForm.vehicleType,
    });

    final response = await Service.rest(
        method: 'post',
        url: 'pdf/loan',
        headers: {"Content-Type": "application/json"},
        body: body);
    try {
      if (response['status'].toString() == '200') {
        TopupPdf topupPdf =
            TopupPdf.fromJson(convert.jsonDecode(response['res'].toString()));

        return topupPdf;
      } else {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException(
            '${parsed['errorCode']}: ${parsed['errorDescription']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in getDoccuments :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in getDoccuments :${e.toString()} ');
      throw Exception(e.toString());
    }
  }

  Future<String> saveTopupRequest(
      {required TopupConclusion topupConclusion,
      required TopupPdf topupPdf,
      required TopupSubmitForm topupSubmitForm}) async {
    final localStorageObject = ls.LocalStoragePrefernces();
    dynamic userLocation =
        await localStorageObject.getLocalStorage('userLocation', 'string');
    LatLng latLng = LatLng(0, 0);
    bool isLocationEmpty() {
      if (userLocation == null) {
        return true;
      } else {
        return false;
      }
    }

    if (!isLocationEmpty()) {
      Map<String, dynamic> maper = jsonDecode(
        userLocation.toString(),
      );
      latLng = LatLng(double.parse(maper['lat']), double.parse(maper['lng']));
    }

    var body = json.encode({
      "hash_thai_id": hashThaiId,
      "db_name": topupConclusion.loanDetail.dbName,
      "transno": topupConclusion.loanDetail.transNo,
      "contract_no": topupConclusion.loanDetail.contractNo,
      "marketing_consent": "Y",
      "sensitive_consent": "Y",
      "latitude": isLocationEmpty() ? '' : latLng.latitude.toString(),
      "longitude": isLocationEmpty() ? '' : latLng.longitude.toString(),
      "loan_amount":
          topupConclusion.topupInstallmentNumber.amount, // from user input
      "topup_fee": 0,
      "fee_amount": 0,
      "transfer_amount": topupConclusion.actualAmount,
      "interest_rate": topupConclusion.topupInstallmentNumber.interestRate,
      "interest_amount": topupConclusion.selectedInstallmentNumber.intAmt,
      "total_amount": topupConclusion.selectedInstallmentNumber.totalAmt,
      "credit_limit":
          topupConclusion.topupDataConclusion.contractDetails.creditLimit,
      "term_period": topupConclusion.selectedInstallmentNumber.tenor,
      "regular_period":
          topupConclusion.selectedInstallmentNumber.regularPeriodAmt,
      "last_period": topupConclusion.selectedInstallmentNumber.lastPeriodAmt,
      "last_period_promo":
          topupConclusion.selectedInstallmentNumber.lastPeriodPromo,
      "act_image": topupConclusion.vehicleImage,
      "property_image": topupConclusion.vehicleTag,
      "topup_request_file": topupPdf.loan,
      "topup_argeement_file": topupPdf.loanAgreement,
      "topup_receipt_file": topupPdf.receipt,
      "save_pdf": {
        "contract_no": topupSubmitForm.contractNo,
        "amount": topupSubmitForm.amount,
        "from": topupSubmitForm.from,
        "contract_bank_account": topupSubmitForm.contractBankAccount,
        "contract_bank_brandname": topupSubmitForm.contractBankBrandname,
        "contract_bank_type": topupSubmitForm.contractBankType,
        "contract_bank_branch": topupSubmitForm.contractBankBranch,
        "installment_number": topupSubmitForm.installmentNumber,
        "amount_per_installment": topupSubmitForm.amountPerInstallment,
        "start_installment_date": topupSubmitForm.startInstallmentDate,
        "installment_date": topupSubmitForm.installmentDate,
        "vehicle_type": topupSubmitForm.vehicleType,
      },
      "life_insure_amt": topupConclusion.insuranceAmt.toString()
    });

    try {
      final response = await Service.rest(
          method: 'post',
          url: 'topup',
          headers: {"Content-Type": "application/json"},
          body: body);
      logger.i('response when save topup :${response.toString()}');
      if (response['status'].toString() == '200') {
        final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        return parsed['body']['trans_no'].toString();
        // return response['trans_no'].toString();
      } else {
        // final Map<String, dynamic> parsed = convert.jsonDecode(response['res']);
        throw new RESTApiException('${response['res']}');
      }
    } on RESTApiException catch (e) {
      logger.e(
          'Caught RESTApiException error in saveTopupRequest :${e.cause.toString()} ');
      throw new RESTApiException('${e.cause}');
    } catch (e) {
      logger.e('Caught error in saveTopupRequest :${e.toString()} ');
      throw Exception(e.toString());
    }
  }
}
