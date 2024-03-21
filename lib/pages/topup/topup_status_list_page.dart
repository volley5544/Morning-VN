import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_widgets/topup_status_card.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../bloc/page_result/page_result_bloc.dart';
import '../../util/custom_exception.dart';
import '../../util/logger_service.dart';
import '../../widgets/no_internet_widget.dart';

class TopUpStatusList extends StatefulWidget {
  const TopUpStatusList({Key? key}) : super(key: key);

  @override
  State<TopUpStatusList> createState() => _TopUpStatusListState();
}

class _TopUpStatusListState extends State<TopUpStatusList> {
  bool isloading = false;
  late LoanListData topUpList;
  LoanRepository loanRepository = LoanRepository();
  bool? hasConnection = null;

  doFecthData() async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        setState(() {
          isloading = true;
          hasConnection = true;
        });
        LoanListData listApi = await loanRepository.getLoanList(hashThaiId);
        // LoanListData listApi = await loanRepository.getLoanList(hashThaiId);
        listApi.loanDetailList = listApi.loanDetailList
            .where((element) =>
                element.requestStatus.isNotEmpty &&
                element.transNo.isNotEmpty &&
                element.contractDetails.accountStatus == 'A')
            .toList();
        setState(() {
          topUpList = listApi;
          isloading = false;
        });
      } else {
        setState(() {
          hasConnection = false;
        });
      }
    } on RESTApiException catch (e) {
      Navigator.of(context).pop();
      serverSuspendedDialog(context, additionalText: e.cause.toString());
    } catch (e) {
      logger.e('Fetch Topup status list Error! : ${e}');
      Navigator.of(context).pop();
      serverSuspendedDialog(context);
    }
  }

  @override
  void initState() {
    doFecthData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (hasConnection != null)
        ? (hasConnection! ? getNormalStateWidget() : getNoInternetWidget())
        : Container();
  }

  getNormalStateWidget() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#FFFFFF'),
          bottomOpacity: 0.0,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'รายการสถานะขอสินเชื่อ',
            style: GoogleFonts.notoSansThai(
                color: HexColor('#003063'),
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () async {
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetCurrentNavBarIndex(0));
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetButtonNavigator(true));
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset('assets/back-icon.svg'),
          ),
        ),
        body: (isloading
            ? ProgressLoading()
            : topUpList.loanDetailList.isEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: Center(
                      child: Text(
                        'ไม่มีรายการสถานะขอสินเชื่อ',
                        style: GoogleFonts.notoSansThai(
                            color: HexColor('#8B99A7'),
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...topUpList.loanDetailList.map(
                          (e) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/topup-status-detail',
                                      arguments: {
                                        'transNo': e.transNo,
                                        'dbName': e.dbName,
                                        'loanDetail': e
                                      });
                                },
                                child: TopupListCard(
                                  context: context,
                                  loanTypeName: e.contractDetails.loanTypeName,
                                  request_topup_amount: e.requestTopupAmount,
                                  statusCode: e.requestStatus,
                                  collateralInformation:
                                      e.contractDetails.collateralInformation,
                                  requestDate: e.requestDate,
                                  loanTypeIcon: e.contractDetails.loanTypeIcon,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )));
  }

  getNoInternetWidget() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          AppBar(
            backgroundColor: HexColor('#FFFFFF'),
            bottomOpacity: 0.0,
            elevation: 0.0,
            centerTitle: true,
            title: Text(
              'รายการสถานะขอสินเชื่อ',
              style: GoogleFonts.notoSansThai(
                  color: HexColor('#003063'),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            leading: IconButton(
              onPressed: () async {
                BlocProvider.of<PageResultBloc>(context)
                    .add(SetButtonNavigator(true));
                BlocProvider.of<PageResultBloc>(context)
                    .add(SetCurrentNavBarIndex(0));
                await Navigator.of(context).pushNamed('/home-page');
              },
              icon: SvgPicture.asset('assets/back-icon.svg'),
            ),
          ),
          Center(child: NoInternetWidget(
            onRetry: () async {
              doFecthData();
            },
          )),
        ],
      ),
    );
  }
}
