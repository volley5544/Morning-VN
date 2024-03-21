import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../bloc/topup_bloc/topup_bloc.dart';
import '../../main.dart';
import '../../models/loan_detail.dart';
import '../../models/topup_data.dart';
import '../../models/topup_installment_number.dart';
import '../../modules/topupRepo/index.dart';
import '../../util/currentcy_format.dart';
import '../../util/width_until.dart';
import '../../widgets/loan_widgets/bootom_button.dart';
import '../../widgets/no_internet_widget.dart';
import 'topup_styling.dart';
import 'topup_widgets/topup_selectable_card.dart';

class IndexSetter {
  late int currentIndex;
  IndexSetter({required this.currentIndex});
}

class SetupInstallmentNumberPage extends StatefulWidget {
  final TopupConclusion topupConclusion;

  const SetupInstallmentNumberPage({
    Key? key,
    required this.topupConclusion,
  }) : super(key: key);

  @override
  State<SetupInstallmentNumberPage> createState() =>
      _SetupInstallmentNumberPageState();
}

class _SetupInstallmentNumberPageState
    extends State<SetupInstallmentNumberPage> {
  late Installments selectedInstallmentNumber;
  // late int currentIndex = 0;
  bool? hasConnection = null;
  final TopupRepository topupRepository = TopupRepository();
  late IndexSetter indexSetter = IndexSetter(currentIndex: 0);

  @override
  void initState() {
    // TODO Find values for all these mock value
    initData();
    super.initState();
  }

  void nagivateToInstallmentNumberPage(
      LoanDetail loanDetail, TopupInstallmentNumber topupInstallmentNumber) {
    navKey.currentState!.pushNamed('/top-up-extends-tax',
        arguments: TopupConclusion(
            loanDetail: loanDetail,
            selectedInstallmentNumber: selectedInstallmentNumber,
            appbarTitle: widget.topupConclusion.appbarTitle,
            isComeFromConclusionNext:
                widget.topupConclusion.isComeFromConclusionNext,
            loanTotalBalanceAmount:
                widget.topupConclusion.loanTotalBalanceAmount,
            vehicleImage: widget.topupConclusion.vehicleImage,
            vehicleTag: widget.topupConclusion.vehicleTag,
            topupInstallmentNumber: topupInstallmentNumber,
            actualAmount: widget.topupConclusion.actualAmount,
            topupDataConclusion: widget.topupConclusion.topupDataConclusion,
            insuranceAmt: widget.topupConclusion.insuranceAmt));
  }

  void onCardSelected(int index, Installments installment) {
    setState(() {
      indexSetter.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (hasConnection != null)
        ? (hasConnection! ? getNormalStateWidget() : getNoInternetWidget())
        : Container();
  }

  void setSateWrapper() {
    setState(() {});
  }

  Future<void> initData() async {
    if (await InternetConnectionChecker().hasConnection) {
      context.read<TopupBloc>().add(GetInstallmentNumberByID(
          amount: widget.topupConclusion.loanTotalBalanceAmount,
          contractId: widget.topupConclusion.loanDetail.contractNo,
          topupRepository: topupRepository,
          context: context,
          dbName: widget.topupConclusion.loanDetail.dbName,
          feeAmount: widget.topupConclusion.topupInstallmentNumber.feeAmount,
          interestRate:
              widget.topupConclusion.topupInstallmentNumber.interestRate,
          topupFeeAmount:
              widget.topupConclusion.topupInstallmentNumber.topupFeeAmount,
          transactionNo: widget.topupConclusion.loanDetail.transNo,
          indexSetter: indexSetter,
          setState: setSateWrapper));
      setState(() {
        hasConnection = true;
      });
    } else {
      setState(() {
        hasConnection = false;
      });
    }
  }

  getNormalStateWidget() {
    double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'ข้อมูลยอดจัดสินเชื่อ',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
          ),
          backgroundColor: HexColor('#FFFFFF'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: HexColor('#DB771A'),
            ),
          ),
        ),
        backgroundColor: HexColor('#FFFFFF'),
        body: BlocBuilder<TopupBloc, TopupState>(
          builder: (blocContext, state) {
            if (state is TopupLoading) {
              return ProgressLoading();
            }
            if (state is TopupError) {
              // TODO : Add Navigator POP when Error.
              return Container();
            }
            if (state is TopupComplete) {
              return Container(
                height: MediaQuery.of(context).size.height - appBarHeight,
                // color: Colors.amber,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        // height: MediaQuery.of(context).size.height - appBarHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: widthAdjuster(
                                  screenWidth:
                                      MediaQuery.of(context).size.width),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'ยอดจัดสินเชื่อใหม่',
                                      style: size14WNormal,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Text(
                                        '${convertDoubleCurrentcy(state.topupInstallmentNumber.amount)} บาท',
                                        style: size24W600),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 21, top: 14),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          'กรุณาเลือกจำนวนงวดสำหรับการผ่อนชำระ',
                                          style: size16WNormal),
                                    ),
                                  ),
                                  ...(state.topupInstallmentNumber.installments
                                      .map(
                                        (Installments installment) {
                                          int index = state
                                              .topupInstallmentNumber
                                              .installments
                                              .indexOf(installment);
                                          if (index ==
                                              indexSetter.currentIndex) {
                                            selectedInstallmentNumber =
                                                installment;
                                          }
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 14),
                                            child: GestureDetector(
                                              onTap: () => onCardSelected(
                                                  state.topupInstallmentNumber
                                                      .installments
                                                      .indexOf(installment),
                                                  installment),
                                              child: TopupSelectableCard(
                                                  installmentNumber:
                                                      installment.tenor,
                                                  amountPerInstallment:
                                                      installment
                                                          .regularPeriodAmt,
                                                  isCardSelected: index ==
                                                          indexSetter
                                                              .currentIndex
                                                      ? true
                                                      : false),
                                            ),
                                          );
                                        },
                                      )
                                      .toList()
                                      .reversed),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 125),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: BootomButton(
                        onButtonTap: () => nagivateToInstallmentNumberPage(
                            widget.topupConclusion.loanDetail,
                            state.topupInstallmentNumber),
                        title: 'ยืนยัน',
                      ),
                    )
                  ],
                ),
              );
            }
            return Center(child: Text('Error'));
          },
        ));
  }

  getNoInternetWidget() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              'ข้อมูลยอดจัดสินเชื่อ',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
            ),
            backgroundColor: HexColor('#FFFFFF'),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: HexColor('#DB771A'),
              ),
            ),
          ),
          Center(child: NoInternetWidget(
            onRetry: () async {
              initData();
            },
          )),
        ],
      ),
    );
  }
}
