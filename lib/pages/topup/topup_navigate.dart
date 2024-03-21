import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_styling.dart';
import 'package:mobile_application_srisawad/widgets/dialog/topup_resticted_dialog.dart';

import '../../models/topup_data.dart';
import '../../models/topup_pdf.dart';
import '../../modules/topupRepo/index.dart';
import '../../util/custom_exception.dart';
import '../../util/width_until.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';

Widget renderTopupSuccessButton(
    BuildContext context, String tranNo, String dbName, LoanDetail loanDetail) {
  return Column(
    children: [
      Container(
        width: widthAdjuster(screenWidth: MediaQuery.of(context).size.width),
        height: 60,
        decoration: BoxDecoration(
            color: HexColor('#DB771A'),
            borderRadius: BorderRadius.circular(14)),
        child: TextButton(
          onPressed: () async {
            ResetToptupConsent(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home-page',
              (route) => false,
            );
            await Navigator.pushNamed(context, '/topup-status-detail',
                arguments: {
                  'transNo': tranNo,
                  'dbName': dbName,
                  'loanDetail': loanDetail
                });
            Navigator.pop(context);
          },
          child: Text('ดูสถานะการขอเพิ่มวงเงิน',
              style: size16W600CBlue
                  .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          width: widthAdjuster(screenWidth: MediaQuery.of(context).size.width),
          height: 60,
          decoration: BoxDecoration(
              color: HexColor('#FCEFE4'),
              borderRadius: BorderRadius.circular(14)),
          child: TextButton(
            onPressed: () {
              ResetToptupConsent(context);
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetButtonNavigator(true));
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetCurrentNavBarIndex(0));
              Navigator.pushNamed(context, '/home-page');
            },
            child: Text('กลับสู่หน้าแรกแอปพลิเคชัน',
                style: size16W600CBlue.merge(TextStyle(
                    color: HexColor('#DB771A'),
                    fontFamily: 'NotoSansThaiSemiBold'))),
          ),
        ),
      ),
    ],
  );
}

//TODO [Saksit] fix save topup with app fields mapped
Future<String> saveTopup(
    {required BuildContext context,
    required TopupRepository topupRepository,
    required TopupConclusion topupConclusion,
    required TopupPdf topupPdf,
    required TopupSubmitForm topupSubmitForm}) async {
  try {
    LoanRepository loanRepository = LoanRepository();

    String transNo = await topupRepository.saveTopupRequest(
        topupConclusion: topupConclusion,
        topupPdf: topupPdf,
        topupSubmitForm: topupSubmitForm);
    BlocProvider.of<LoanBloc>(context).add(ResetLoanState());
    BlocProvider.of<LoanBloc>(context)
        .add(LoadLoanList(hashThaiId, loanRepository, context));
    return Future.value(transNo);
  } on RESTApiException catch (e) {
    final Map<String, dynamic> parsed = convert.jsonDecode(e.cause.toString());
    if (parsed['errorflag'] == 'Y') {
      topupRestrictedDialog(context,
          additionalText: parsed['errorDescription'].toString());
    } else {
      serverSuspendedDialog(context,
          additionalText:
              '${parsed['errorCode']}: ${parsed['errorDescription']}');
    }
    // topupRestrictedDialog(context, additionalText: e.cause.toString());
    return Future.value('n');
  } catch (e) {
    serverSuspendedDialog(context, additionalText: e.toString());
    return Future.value('n');
  }
}

void ResetToptupConsent(BuildContext context) {
  context.read<TopupBloc>().add(SetTopupConsent(
      topupConsent: TopupConsent(
          contactDoccument: false, contactRequst: false, paySlip: false)));
}
