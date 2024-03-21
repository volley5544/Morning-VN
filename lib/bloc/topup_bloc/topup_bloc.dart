import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:typed_data';
import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/topup_resticted_dialog.dart';
import 'package:path_provider/path_provider.dart';

import '../../models/loan_detail.dart';
import '../../models/topup_data.dart';
import '../../models/topup_installment_number.dart';
import '../../models/topup_pdf.dart';
import '../../models/user_addresses.dart';
import '../../modules/topupRepo/index.dart';
import '../../pages/topup/setup_installment_number_page.dart';
import '../../util/currentcy_format.dart';
import '../../util/custom_exception.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';
import '../../widgets/flash/server_suspended.dart';

part 'topup_event.dart';
part 'topup_state.dart';

DateTime? pdfDateTime;

class TopupBloc extends Bloc<TopupEvent, TopupState> {
  TopupBloc()
      : super(TopupInitial(
            topupData: TopupData(
              contractDetails: ContractDetails(
                  collateralInformation: '',
                  licensePlateExpireDate: '',
                  licensePlateProvince: '',
                  vehicleBrand: '',
                  accountStatus: '',
                  branchCode: '',
                  branchName: '',
                  canTopup: '',
                  comcode: '',
                  creditLimit: 0,
                  currentDueAmount: 0,
                  currentDueDate: '',
                  currentLtvAmount: 0,
                  effectiveInterestRate: 0,
                  firstDueDate: '',
                  lastDueDate: '',
                  monthlyInterestRate: 0,
                  osBalance: 0,
                  closingBalance: 0),
              contractNo: '',
              defaultTopupAmount: 0,
              installmentNumber: 0,
              interestRate: 0,
              maxTopupAmount: 0,
              code: '',
              carDetails: CarDetails(
                  carBrand: '',
                  carCc: '',
                  carChassisNo: '',
                  carColor: '',
                  carDesc: '',
                  carEngineNo: '',
                  carGear: '',
                  carManufactureYear: '',
                  carProvince: '',
                  carRegistration: '',
                  carRegistrationPrefix: '',
                  carSeries: ''),
              contractDate: '',
              dataDate: '',
              dbName: '',
              dueDay: 0,
              firstDueDate: '',
              installmentAmount: 0,
              message: '',
              minAmountWithRate: 0,
              osBalance: 0,
              transferAmount: 0,
              lifeInsureAmt: '',
              packageId: '',
              minTopupAmount: 0,
            ),
            loanList: [],
            topupInstallmentNumber: TopupInstallmentNumber(
                amount: 0,
                code: '',
                contractNo: '',
                feeAmount: 0,
                firstDueDate: '',
                installments: [],
                interestRate: 0,
                message: '',
                topupFeeAmount: 0,
                transNo: ''),
            userAddressesList: UserAddresses(
                currentAddress: CurrentAddress(
                    addressDetails: '',
                    addressDistrict: '',
                    addressPostalCode: '',
                    addressProvince: '',
                    addressSubDistrict: ''),
                dataDate: '',
                idCardAddress: IdCardAddress(
                    addressDetails: '',
                    addressDistrict: '',
                    addressPostalCode: '',
                    addressProvince: '',
                    addressSubDistrict: ''),
                otherAddress: OtherAddress(
                    addressDetails: '',
                    addressDistrict: '',
                    addressPostalCode: '',
                    addressProvince: '',
                    addressSubDistrict: ''),
                registrationAddress: RegistrationAddress(
                    addressDetails: '',
                    addressDistrict: '',
                    addressPostalCode: '',
                    addressProvince: '',
                    addressSubDistrict: '')),
            doccumentList: [],
            topupConsent: TopupConsent(
                contactDoccument: false, contactRequst: false, paySlip: false),
            decodedTopupPdf: DecodedTopupPdf(
                loan: '',
                loanAgreement: '',
                receipt: '',
                topupPdfEncoded:
                    TopupPdf(loan: '', loanAgreement: '', receipt: '')),
            topupSubmitForm: topupSubmitForm)) {
    on<SetTopupList>((event, emit) {
      state.loanList = event.loanList;
      emit(TopupComplete(
          loanList: state.loanList,
          topupData: state.topupData,
          topupInstallmentNumber: state.topupInstallmentNumber,
          userAddressesList: state.userAddressesList,
          doccumentList: state.doccumentList,
          topupConsent: state.topupConsent,
          decodedTopupPdf: state.decodedTopupPdf,
          topupSubmitForm: state.topupSubmitForm));
    });
    on<GetTopupByid>((event, emit) async {
      try {
        emit(TopupLoading(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
        TopupData topupData = await event.topupRepository
            .getTopupDetail(event.dbName, event.contractId);
        event.installmentNumberController.text =
            convertDoubleCurrentcy(topupData.maxTopupAmount);
        event.topupConclusion.loanTotalBalanceAmount = topupData.maxTopupAmount;
        event.topupConclusion.actualAmount =
            topupData.maxTopupAmount - topupData.osBalance;
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
      } on RESTApiException catch (e) {
        emit(TopupError(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
        final Map<String, dynamic> parsed =
            convert.jsonDecode(e.cause.toString());
        if (parsed['errorflag'] == 'Y') {
          topupRestrictedDialog(event.context,
              additionalText: parsed['errorDescription'].toString());
        } else {
          serverSuspendedDialog(event.context,
              additionalText:
                  '${parsed['errorCode']}: ${parsed['errorDescription']}');
        }
        Navigator.of(event.context).pop();
        // Navigator.of(event.context).restorablePush();
      } catch (error) {
        emit(TopupError(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
        serverSuspendedDialog(event.context, additionalText: error.toString());
        Navigator.of(event.context).pop();
        Navigator.of(event.context)
            .restorablePush(serverSuspendedDialog(event.context));
      }
    });
    on<GetInstallmentNumberByID>((event, emit) async {
      try {
        emit(TopupLoading(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
        TopupInstallmentNumber topupInstallmentNumber =
            await event.topupRepository.getInstallmentNumbers(
                id: event.contractId,
                amount: event.amount,
                dbName: event.dbName,
                feeAmount: event.feeAmount,
                interestRate: event.interestRate,
                topupFeeAmount: event.topupFeeAmount,
                transactionNo: event.transactionNo);
        event.indexSetter.currentIndex =
            topupInstallmentNumber.installments.length - 1;
        event.setState();
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
      } on RESTApiException catch (e) {
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));

        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
      } catch (e) {
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));

        logger.e('Error when sending calculate from topup detail: $e');
        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context);
      }
    });
    on<GetUsreAddreses>((event, emit) async {
      try {
        emit(TopupLoading(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
        UserAddresses userAddressesList =
            await event.topupRepository.getUserAddressbyHashId(
          event.hashThaiId,
        );
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
      } on RESTApiException catch (e) {
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
        logger.e('Error in bloc: $e');
        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
      } catch (e) {
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
        logger.e('Error in bloc: $e');
        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context);
      }
    });
    on<GetContractDoccument>((event, emit) async {
      try {
        bool fetchNow = false;
        Future<void> dosofetchme() async {
          if (fetchNow) {
            emit(TopupLoading(
                loanList: state.loanList,
                topupData: state.topupData,
                topupInstallmentNumber: state.topupInstallmentNumber,
                userAddressesList: state.userAddressesList,
                doccumentList: state.doccumentList,
                topupConsent: state.topupConsent,
                decodedTopupPdf: state.decodedTopupPdf,
                topupSubmitForm: state.topupSubmitForm));
            TopupPdf topupPdf = await event.topupRepository.getDoccuments(
              event.topupSubmitForm,
            );
            state.topupSubmitForm = event.topupSubmitForm;
            io.Directory appDocDir = await getApplicationDocumentsDirectory();
            String appDocPath = appDocDir.path;
            String contactDoccument = "$appDocPath/contactDoccument.pdf";
            String contactRequst = "$appDocPath/contactRequst.pdf";
            String paySlip = "$appDocPath/paySlip.pdf";
            io.File contactDoccumentFile = io.File(contactDoccument);
            io.File contactRequstFile = io.File(contactRequst);
            io.File paySlipFile = io.File(paySlip);
            Uint8List contactDoccumentFileResult =
                base64.decode(topupPdf.loan.split(',')[1]);
            Uint8List contactRequstFileResult =
                base64.decode(topupPdf.loanAgreement.split(',')[1]);
            Uint8List paySlipFileResult =
                base64.decode(topupPdf.receipt.split(',')[1]);
            contactDoccumentFile.writeAsBytesSync(contactDoccumentFileResult);
            contactRequstFile.writeAsBytesSync(contactRequstFileResult);
            paySlipFile.writeAsBytesSync(paySlipFileResult);
            emit(TopupComplete(
                loanList: state.loanList,
                topupData: state.topupData,
                topupInstallmentNumber: state.topupInstallmentNumber,
                userAddressesList: state.userAddressesList,
                doccumentList: state.doccumentList,
                topupConsent: state.topupConsent,
                decodedTopupPdf: DecodedTopupPdf(
                    loan: contactDoccument,
                    loanAgreement: contactRequst,
                    receipt: paySlip,
                    topupPdfEncoded: topupPdf),
                topupSubmitForm: state.topupSubmitForm));
          }
        }

        if (pdfDateTime == null) {
          pdfDateTime = DateTime.now();
        }

        if (state.decodedTopupPdf.loan == '' &&
            state.decodedTopupPdf.loanAgreement == '' &&
            state.decodedTopupPdf.receipt == '') {
          fetchNow = true;
          await dosofetchme();
        } else {
          if (DateTime.now().minute > pdfDateTime!.minute + 5) {
            pdfDateTime = DateTime.now();
            fetchNow = true;
            await dosofetchme();
          } else {
            fetchNow = true;
            emit(TopupComplete(
                loanList: state.loanList,
                topupData: state.topupData,
                topupInstallmentNumber: state.topupInstallmentNumber,
                userAddressesList: state.userAddressesList,
                doccumentList: state.doccumentList,
                topupConsent: state.topupConsent,
                decodedTopupPdf: state.decodedTopupPdf,
                topupSubmitForm: state.topupSubmitForm));
          }
        }
        fetchNow = false;
      } on RESTApiException catch (e) {
        emit(TopupError(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));

        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context,
            additionalText: e.cause.toString());
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
      } catch (e) {
        logger.e('Error in pdf former: $e');
        emit(TopupError(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));

        Navigator.of(event.context).pop();
        serverSuspendedDialog(event.context);
        emit(TopupComplete(
            loanList: state.loanList,
            topupData: state.topupData,
            topupInstallmentNumber: state.topupInstallmentNumber,
            userAddressesList: state.userAddressesList,
            doccumentList: state.doccumentList,
            topupConsent: state.topupConsent,
            decodedTopupPdf: state.decodedTopupPdf,
            topupSubmitForm: state.topupSubmitForm));
      }
    });
    on<SetTopupConsent>((event, emit) async {
      emit(TopupLoading(
          loanList: state.loanList,
          topupData: state.topupData,
          topupInstallmentNumber: state.topupInstallmentNumber,
          userAddressesList: state.userAddressesList,
          doccumentList: state.doccumentList,
          topupConsent: state.topupConsent,
          decodedTopupPdf: state.decodedTopupPdf,
          topupSubmitForm: state.topupSubmitForm));
      emit(TopupComplete(
          loanList: state.loanList,
          topupData: state.topupData,
          topupInstallmentNumber: state.topupInstallmentNumber,
          userAddressesList: state.userAddressesList,
          doccumentList: state.doccumentList,
          topupConsent: event.topupConsent,
          decodedTopupPdf: state.decodedTopupPdf,
          topupSubmitForm: state.topupSubmitForm));
    });
    on<SetTopupComplete>((event, emit) async {
      emit(TopupComplete(
          loanList: state.loanList,
          topupData: state.topupData,
          topupInstallmentNumber: state.topupInstallmentNumber,
          userAddressesList: state.userAddressesList,
          doccumentList: state.doccumentList,
          topupConsent: state.topupConsent,
          decodedTopupPdf: state.decodedTopupPdf,
          topupSubmitForm: state.topupSubmitForm));
    });
    on<ReSetTopupComplete>((event, emit) async {
      state.topupConsent = TopupConsent(
          contactDoccument: false, contactRequst: false, paySlip: false);
      emit(TopupComplete(
          loanList: state.loanList,
          topupData: state.topupData,
          topupInstallmentNumber: state.topupInstallmentNumber,
          userAddressesList: state.userAddressesList,
          doccumentList: state.doccumentList,
          topupConsent: state.topupConsent,
          decodedTopupPdf: state.decodedTopupPdf,
          topupSubmitForm: state.topupSubmitForm));
    });
    on<ResetTopupState>((event, emit) async {
      state.loanList = [];
      pdfDateTime = null;
    });
  }
}
