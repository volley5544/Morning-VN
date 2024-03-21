import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_widgets/topup_card.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_styling.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../bloc/loan_bloc/loan_bloc.dart';
import '../../bloc/page_result/page_result_bloc.dart';
import '../../models/loan_detail.dart';
import '../../models/topup_data.dart';
import '../../models/topup_installment_number.dart';
import '../../modules/loan/index.dart';
import 'topup_widgets/term_condition_card.dart';

class TopUpListPage extends StatefulWidget {
  const TopUpListPage({Key? key}) : super(key: key);

  @override
  State<TopUpListPage> createState() => _TopUpListPageState();
}

class _TopUpListPageState extends State<TopUpListPage> {
  LoanRepository loanRepository = LoanRepository();
  @override
  void initState() {
    context
        .read<LoanBloc>()
        .add(LoadLoanList(hashThaiId, loanRepository, context));
    // BlocProvider.of<TopupBloc>(context).add(ReSetTopupComplete());
    super.initState();
  }

  Future<void> navigateToDetail(LoanDetail loanDetail) async {
    await navKey.currentState!.pushNamed('/top-up-detail-page',
        arguments: TopupConclusion(
          loanDetail: loanDetail,
          selectedInstallmentNumber: Installments(
              firstPeriodAmt: 0,
              intAmt: 0,
              lastPeriodAmt: 0,
              lastPeriodPromo: 0,
              regularPeriodAmt: 0,
              tenor: 0,
              totalAmt: 0),
          appbarTitle: '',
          isComeFromConclusionNext: false,
          loanTotalBalanceAmount: 0,
          vehicleImage: "",
          vehicleTag: '',
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
          actualAmount: 0,
          topupDataConclusion: TopupData(
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
              code: '',
              contractDate: '',
              contractDetails: ContractDetails(
                  accountStatus: '',
                  branchCode: '',
                  branchName: '',
                  canTopup: '',
                  collateralInformation: '',
                  comcode: '',
                  creditLimit: 0,
                  currentDueAmount: 0,
                  currentDueDate: '',
                  currentLtvAmount: 0,
                  effectiveInterestRate: 0,
                  firstDueDate: '',
                  lastDueDate: '',
                  licensePlateExpireDate: '',
                  licensePlateProvince: '',
                  monthlyInterestRate: 0,
                  osBalance: 0,
                  vehicleBrand: '',
                  closingBalance: 0),
              contractNo: '',
              dataDate: '',
              dbName: '',
              defaultTopupAmount: 0,
              dueDay: 0,
              firstDueDate: '',
              installmentAmount: 0,
              installmentNumber: 0,
              interestRate: 0,
              maxTopupAmount: 0,
              message: '',
              minAmountWithRate: 0,
              osBalance: 0,
              transferAmount: 0,
              lifeInsureAmt: '',
              packageId: '',
              minTopupAmount: 0),
          insuranceAmt: 0,
        ));
    BlocProvider.of<TopupBloc>(context).add(ReSetTopupComplete());
  }

  void redirectToTopupStatus(LoanDetail e) {
    Navigator.pushNamed(context, '/topup-status-detail',
        arguments: {'transNo': e.transNo, 'dbName': e.dbName, 'loanDetail': e});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'เพิ่มวงเงิน',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
          ),
          backgroundColor: HexColor('#FFFFFF'),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetButtonNavigator(true));
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: HexColor('#DB771A'),
            ),
          ),
        ),
        body: BlocBuilder<TopupBloc, TopupState>(
          builder: (context, state) {
            if (state is LoanListError) {
              return Container();
            } else if (state is LoanListLoading) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Center(child: ProgressLoading()));
            } else if (state is TopupComplete) {
              final filterTopups = state.loanList
                  .where((i) =>
                      i.topupDetail.canTopup == 'Y' &&
                      i.contractDetails.accountStatus == 'A')
                  .toList();
              if (state.loanList.isEmpty || filterTopups.isEmpty) {
                return Stack(children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: TermConditionCard(),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 249,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ไม่พบรายการสินเชื่อที่เข้าหลักเกณฑ์ การขอเพิ่มวงเงินได้',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'NotoSansThai',
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'สนใจ กรุณาติดต่อสาขาใกล้ท่าน',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'NotoSansThai',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]);
              } else
                return SingleChildScrollView(
                  child: Container(
                    color: HexColor('#FFFFFF'),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TermConditionCard(),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(21, 20, 0, 5),
                          child: Text(
                            'กรุณาเลือกสัญญาที่ต้องการเพิ่มวงเงิน',
                            textAlign: TextAlign.left,
                            style: size16WNormal,
                          ),
                        ),
                        ...(filterTopups.map((e) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Opacity(
                                opacity:
                                    e.topupDetail.canTopup == 'N' ? 0.5 : 1,
                                child: TopupLoanCard(
                                  context: context,
                                  loanDetail: e,
                                  onPayButtonTap: () {},
                                  onDetailSelected: () {},
                                  onTap: () => {
                                    if (e.topupDetail.canTopup == 'Y')
                                      {
                                        if (e.transNo != '' ||
                                            e.transNo.isNotEmpty)
                                          {redirectToTopupStatus(e)}
                                        else
                                          {
                                            {navigateToDetail(e)}
                                          }
                                      }
                                  },
                                ),
                              ),
                            )))
                      ],
                    ),
                  ),
                );
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color.fromRGBO(219, 119, 26, 1),
                  ),
                ),
              );
            }
          },
        ));
  }
}
