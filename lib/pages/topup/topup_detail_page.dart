import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/loan_installment_payment_detail.dart';
import 'package:mobile_application_srisawad/pages/topup/setup_installment_number_page.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_styling.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_widgets/new_topup_detail.dart';
import 'package:mobile_application_srisawad/util/currentcy_format.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';
import 'package:mobile_application_srisawad/widgets/dash_line.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../models/loan_detail.dart';
import '../../models/topup_data.dart';
import '../../models/topup_installment_number.dart';
import '../../modules/topupRepo/index.dart';
import '../../util/check_string_format.dart';
import '../../widgets/dialog/change_cancel.dart';
import '../../widgets/no_internet_widget.dart';

class TopupDetailPage extends StatefulWidget {
  final TopupConclusion topupConclusion;

  const TopupDetailPage({Key? key, required this.topupConclusion})
      : super(key: key);

  @override
  State<TopupDetailPage> createState() => _TopupDetailPageState();
}

class _TopupDetailPageState extends State<TopupDetailPage> {
  TopupRepository topupRepository = TopupRepository();
  FocusNode focus = FocusNode();
  late bool inactiveNextButton = true;
  late bool isShowWarning = false;
  late bool isShowMinwarning = false;
  late bool isValueInit = true;
  late bool renderInstallmentNumber = false;
  late bool isButtonShow = true;
  late bool initLoanBalanceAmont = true;
  late bool isInsuranceSelected = true;
  late String loanTotalBalanceAmount = '';
  final CurrencyTextInputFormatter creditLimitFormatter =
      CurrencyTextInputFormatter(symbol: '', decimalDigits: 0);
  bool? hasConnection = null;

  static const _locale = 'en';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(parsingInt(s));
  TextEditingController installmentNumberController = TextEditingController();

  @override
  void initState() {
    initData();
    super.initState();
  }

  void nagivateToInstallmentNumberPage(
      LoanDetail loanDetail, TopupData topupData) {
    navKey.currentState!.pushNamed('/top-up-installment-number-page',
        arguments: TopupConclusion(
            loanDetail: loanDetail,
            selectedInstallmentNumber: Installments(
                firstPeriodAmt: widget
                    .topupConclusion.selectedInstallmentNumber.firstPeriodAmt,
                intAmt: widget.topupConclusion.selectedInstallmentNumber.intAmt,
                lastPeriodAmt: widget
                    .topupConclusion.selectedInstallmentNumber.lastPeriodAmt,
                lastPeriodPromo: widget
                    .topupConclusion.selectedInstallmentNumber.lastPeriodPromo,
                regularPeriodAmt: widget
                    .topupConclusion.selectedInstallmentNumber.regularPeriodAmt,
                tenor: widget.topupConclusion.selectedInstallmentNumber.tenor,
                totalAmt:
                    widget.topupConclusion.selectedInstallmentNumber.totalAmt),
            appbarTitle: widget.topupConclusion.appbarTitle,
            isComeFromConclusionNext:
                widget.topupConclusion.isComeFromConclusionNext,
            loanTotalBalanceAmount: widget.topupConclusion.loanTotalBalanceAmount +
                parDoubleSafty(topupData.lifeInsureAmt),
            vehicleImage: "",
            vehicleTag: '',
            topupInstallmentNumber: TopupInstallmentNumber(
                amount: 0,
                code: '',
                contractNo: '',
                feeAmount: 0,
                firstDueDate: '',
                installments: [],
                interestRate: topupData.interestRate,
                message: '',
                topupFeeAmount: 0,
                transNo: ''),
            actualAmount: getActualAmountWithInsurance(
                widget.topupConclusion.actualAmount, parDoubleSafty(topupData.lifeInsureAmt)),
            topupDataConclusion: topupData,
            insuranceAmt: isInsuranceSelected ? parDoubleSafty(topupData.lifeInsureAmt) : 0.0));
  }

  double getActualAmountWithInsurance(double starting, double lifeInsureAmt) {
    if (isInsuranceSelected) {
      return starting + lifeInsureAmt;
    }
    return starting;
  }

  double numberFromTextField(String input) {
    try {
      double value = double.parse(input);
      return value;
    } catch (e) {
      return double.parse(input.replaceAll('.', ''));
    }
  }

  void handleTextChange(String string, TopupState topupState) {
    if (string != '') {
      String cleanedValue = string.replaceAll(',', '');
      int roundedvValue = convertToHundreds(cleanedValue);
      if (roundedvValue <= topupState.topupData.maxTopupAmount &&
          numberFromTextField(cleanedValue) >=
              (topupState.topupData.minTopupAmount) &&
          installmentNumberController.text != '') {
        setState(() {
          inactiveNextButton = false;
          isShowWarning = false;
          isShowMinwarning = false;
        });
      } else if (numberFromTextField(cleanedValue) <=
          (topupState.topupData.minTopupAmount)) {
        setState(() {
          inactiveNextButton = true;
          isShowMinwarning = true;
          isShowWarning = false;
        });
      } else if ((numberFromTextField(cleanedValue)) >
          topupState.topupData.maxTopupAmount) {
        setState(() {
          inactiveNextButton = true;
          isShowWarning = true;
          isShowMinwarning = false;
        });
      }
    } else {
      installmentNumberController.value = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: string.length),
      );
      setState(() {
        inactiveNextButton = true;
        isShowWarning = false;
      });
    }
  }

  void setButtonShow(bool isShow) {
    setState(() {
      isButtonShow = isShow;
    });
  }

  setStateWrapper() {
    setState(() {});
  }

  int convertToHundreds(String inputNumber) {
    try {
      if (inputNumber.contains('.0')) {
        inputNumber = inputNumber.replaceAll('.0', '');
      }
      String text = inputNumber.replaceAll(',', '');
      int value = int.tryParse(text) ?? 0;
      int roundedValue = (value ~/ 100) * 100;
      return roundedValue;
    } catch (e) {
      logger.e('Error occur in convertToHundreds: $e');
      return 0;
    }
  }

  void _onFocusChange() {
    if (focus.hasFocus) {
      setButtonShow(false);
      if (installmentNumberController.text.contains('.00')) {
        installmentNumberController.text =
            installmentNumberController.text.replaceAll('.00', '');
      }
    } else {
      int roundedNumber = convertToHundreds(installmentNumberController.text);
      String rawNumber = roundedNumber.toString();
      if (!installmentNumberController.text.contains('.')) {
        installmentNumberController.text = convertCurrentcy(roundedNumber);
        // installmentNumberController.text + '.00';
      }
      try {
        if (!inactiveNextButton && rawNumber != '0.00') {
          widget.topupConclusion.loanTotalBalanceAmount =
              double.parse(rawNumber.replaceAll(',', ''));
          TopupState topupState = BlocProvider.of<TopupBloc>(context).state;
          context.read<TopupBloc>().add(GetInstallmentNumberByID(
              amount: double.parse(rawNumber.replaceAll(',', '')),
              contractId: widget.topupConclusion.loanDetail.contractNo,
              topupRepository: topupRepository,
              context: context,
              dbName: widget.topupConclusion.loanDetail.dbName,
              feeAmount: 0,
              interestRate: topupState.topupData.interestRate,
              topupFeeAmount: 0,
              transactionNo: widget.topupConclusion.loanDetail.transNo,
              indexSetter: IndexSetter(currentIndex: 0),
              setState: setStateWrapper));
          setState(() {
            renderInstallmentNumber = true;
            if ((widget.topupConclusion.loanTotalBalanceAmount -
                    topupState.topupData.contractDetails.closingBalance) <
                0) {
              inactiveNextButton = true;
            }
          });
        }
      } finally {
        setState(() {
          loanTotalBalanceAmount = rawNumber;
          isButtonShow = true;
        });
      }
    }
  }

  void setInitValue(TopupState state) {
    installmentNumberController.text =
        convertDoubleCurrentcy(state.topupData.maxTopupAmount);

    if (installmentNumberController.text == '0.00') {
      inactiveNextButton = true;
    } else {
      inactiveNextButton = false;
    }
    isValueInit = false;
    loanTotalBalanceAmount = state.topupData.maxTopupAmount
        .toString()
        .replaceAll(',', '')
        .replaceAll('.00', '');
    // isValueInit = false;
    if (widget
            .topupConclusion.loanDetail.paymentDetails.currentInstallmentAmount
            .toDouble() !=
        0) {
      loanTotalBalanceAmount = widget
          .topupConclusion.loanDetail.contractDetails.osBalance
          .toString()
          .replaceAll(',', '')
          .replaceAll('.00', '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await onBackPressed(context);
        return false;
      },
      child: (hasConnection != null)
          ? (hasConnection! ? getNormalStateWidget() : getNoInternetWidget())
          : Container(),
    );
  }

  Future<void> onBackPressed(BuildContext context) async {
    focus.unfocus();
    Future.delayed(const Duration(milliseconds: 250), () async {
      await changeCancellingDialog(context, () async {
        Navigator.of(context).pop();
      }, false);
    });
  }

  Future<void> initData() async {
    if (await InternetConnectionChecker().hasConnection) {
      focus.addListener(_onFocusChange);
      context.read<TopupBloc>().add(GetTopupByid(
          topupRepository: topupRepository,
          contractId: widget.topupConclusion.loanDetail.contractNo,
          context: context,
          installmentNumberController: installmentNumberController,
          dbName: widget.topupConclusion.loanDetail.dbName,
          topupConclusion: widget.topupConclusion));
      setState(() {
        hasConnection = true;
      });
    } else {
      setState(() {
        hasConnection = false;
      });
    }
  }

  void setInsurenace() {
    setState(() {
      isInsuranceSelected = !isInsuranceSelected;
    });
  }

  Widget renderActualReceiveAmount(TopupState state) {
    if (renderInstallmentNumber) {
      widget.topupConclusion.actualAmount =
          state.topupInstallmentNumber.amount -
              state.topupData.contractDetails.closingBalance;
    } else {
      widget.topupConclusion.actualAmount = state.topupData.maxTopupAmount -
          state.topupData.contractDetails.closingBalance;
    }
    return Text(
      '${convertDoubleCurrentcy(getActualAmountWithInsurance(
        parDoubleSafty(widget.topupConclusion.actualAmount.toString()),
        parDoubleSafty(state.topupData.lifeInsureAmt),
      ))} บาท',
      style: size16W600CBlackBlue
          .merge(TextStyle(fontSize: 18, color: HexColor('#003063'))),
    );
  }

  getNormalStateWidget() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'ข้อมูลยอดจัดสินเชื่อ',
            style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'NotoSansThaiSemiBold')),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () async {
              await onBackPressed(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: HexColor('#DB771A'),
            ),
          ),
        ),
        body: BlocBuilder<TopupBloc, TopupState>(
          builder: (context, state) {
            if (state is TopupLoading) {
              return ProgressLoading();
            }
            if (state is TopupError) {
              Navigator.of(context).pop();
              return Container();
            }
            if (state is TopupComplete) {
              if (isValueInit) {
                setInitValue(state);
              }
              return GestureDetector(
                onTap: () {
                  focus.unfocus();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              children: [
                                LoanInstallPaymentDetail(
                                  subTitle: 'ข้อมูลหลักประกัน',
                                  contractCreateDate: widget
                                      .topupConclusion
                                      .loanDetail
                                      .contractDetails
                                      .collateralInformation,
                                  contractName: widget.topupConclusion
                                      .loanDetail.contractDetails.loanTypeName,
                                  contractNo: widget
                                      .topupConclusion.loanDetail.contractNo,
                                  loanTypeIcon: widget.topupConclusion
                                      .loanDetail.contractDetails.loanTypeIcon,
                                ),
                                Container(
                                  height: 5,
                                  width: double.infinity,
                                  color: HexColor("#E6E6E6"),
                                ),
                                NewTopupDetail(
                                  topupState: state,
                                  loanDetail: widget.topupConclusion.loanDetail,
                                  onNumberChamge: (e, s) =>
                                      handleTextChange(e, s),
                                  controller: installmentNumberController,
                                  isWarning: isShowWarning,
                                  isShowMinwarning: isShowMinwarning,
                                  focusNode: focus,
                                  isRenderInstallmentNumber:
                                      renderInstallmentNumber,
                                  installmentNumber:
                                      state.topupInstallmentNumber,
                                  // actualRecieveAmount: 0,
                                  actualRecieveAmount:
                                      state.topupData.maxTopupAmount -
                                          state.topupData.osBalance,
                                  creditLimitFormatter: creditLimitFormatter,
                                  setInsuranceSelected: () => setInsurenace,
                                  isInsuranceSelected: isInsuranceSelected,
                                ),
                                Container(
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 26, bottom: 20),
                                      child: Text(
                                        ' ข้อมูลวันที่ ${formateBudDate(state.topupData.dataDate)} เวลา ${formateTime(state.topupData.dataDate)} น.',
                                        style: TextStyle(
                                            fontFamily: 'NotoSansThai',
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            fontWeight: FontWeight.normal,
                                            height: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 1),
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                              offset: Offset(0, 1),
                              blurRadius: 10)
                        ],
                      ),
                      child: Wrap(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 23, 24, 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'จำนวนเงินที่จะได้รับจริง',
                                  style: size14WNormal.merge(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: HexColor('#404040'))),
                                ),
                                renderActualReceiveAmount(state)
                              ],
                            ),
                          ),
                          DashedLine(
                            color: HexColor('#E5E5E5'),
                          ),
                          if (isButtonShow)
                            Opacity(
                              opacity: inactiveNextButton ? 0.5 : 1,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 22),
                                width: getActualWidth(context),
                                height: 118,
                                // decoration: setBoxDecoration(decoration),
                                child: Column(
                                  children: [
                                    Button(
                                      buttonCallBack: () => inactiveNextButton
                                          ? () => {}
                                          : nagivateToInstallmentNumberPage(
                                              widget.topupConclusion.loanDetail,
                                              state.topupData),
                                      color: 'DB771A',
                                      height: 60,
                                      isTextBlack: false,
                                      textButton: 'ถัดไป',
                                    ),
                                  ],
                                ),
                              ),
                            )
                          else
                            Container()
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
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
              style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NotoSansThaiSemiBold')),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () async {
                await onBackPressed(context);
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
