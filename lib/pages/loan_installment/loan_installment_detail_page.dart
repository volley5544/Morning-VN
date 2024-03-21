import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_history_bloc/loan_history_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_installment_bloc/loan_installment_bloc.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/loan_installment_conclusion_detail.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/loan_installment_payment_detail.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/loan_installment_tab_content.dart';
import 'package:mobile_application_srisawad/pages/loan_installment/sliding_loan_options.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/util/currentcy_format.dart';
import 'package:mobile_application_srisawad/util/loan_icon.dart';

import 'package:mobile_application_srisawad/widgets/loan_widgets/bootom_button.dart';

class LoanInstallmentDetailPage extends StatefulWidget {
  final LoanDetail loanDetail;
  const LoanInstallmentDetailPage({
    Key? key,
    required this.loanDetail,
  }) : super(key: key);

  @override
  State<LoanInstallmentDetailPage> createState() =>
      _LoanInstallmentDetailPage();
}

// 021a8b41fb8ea3f121eeefaeef357f8c7fdda95361e24da366342cc6549215f6
class _LoanInstallmentDetailPage extends State<LoanInstallmentDetailPage> {
  LoanRepository loanRepository = LoanRepository();
  late String focusedOption = 'ข้อมูลสินเชื่อ';
  final List<String> optionsList = [
    'ข้อมูลสินเชื่อ',
    'ข้อมูลการชำระ',
    'ประวัติการชำระ'
  ];
  final List<String> loanDetailKeys = [
    'totalLoanBalanceAmount',
    'totalPayBalanceLeftAmount',
    'installmentNumber',
    'contractBranchCreatedName',
    'contractCreateDate',
    'loanTypeName',
  ];

  @override
  void initState() {
    // TODO fix hard code
    context.read<LoanInstallmentBloc>().add(LoadLoanInstallmentDetail(
        widget.loanDetail.contractNo,
        loanRepository,
        context,
        widget.loanDetail.dbName));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        boxHeight = getBoxSize(widgetKey.currentContext!);
        topBarHeight = getBoxSize(topBarKey.currentContext!);
        bottomBarHeight = getBoxSize(bottomBarKey.currentContext!);
      });
    });
    super.initState();
  }

  void dispose() {
    //...
    super.dispose();
    //...
  }

  GlobalKey widgetKey = GlobalKey();
  GlobalKey topBarKey = GlobalKey();
  GlobalKey bottomBarKey = GlobalKey();
  double? boxHeight;
  double? topBarHeight;
  double? bottomBarHeight;

  double getBoxSize(BuildContext context) {
    final box = context.findRenderObject() as RenderBox;
    return box.size.height;
  }

  void onLoanOptionSelected(String selectedOption) {
    if (selectedOption == 'ประวัติการชำระ') {
      context.read<LoanHistoryBloc>().add(LoadLoanHistory(
          widget.loanDetail.contractNo, loanRepository, context));
    }
    setState(() {
      focusedOption = selectedOption;
    });
  }

  Future<void> onPayButtonTap(LoanDetail loanDetail, String dbName) async {
    await Navigator.of(context)
        .pushNamed('/payment-detail-page', arguments: loanDetail);
    context.read<LoanInstallmentBloc>().add(LoadLoanInstallmentDetail(
        widget.loanDetail.contractNo,
        loanRepository,
        context,
        widget.loanDetail.dbName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            key: topBarKey,
            elevation: 0,
            centerTitle: true,
            title: Text(
              'รายละเอียดสินเชื่อ',
              style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'NotoSansThaiSemiBold')),
            ),
            backgroundColor: HexColor('#FFFFFF'),
            leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(context);
                },
                child: Container(
                  // color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/GoBackIcon.svg'),
                  ),
                ))),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  Column(
                    key: widgetKey,
                    children: [
                      LoanInstallPaymentDetail(
                        contractCreateDate:
                            widget.loanDetail.paymentDetails.payBeforeDate,
                        contractName:
                            '${widget.loanDetail.contractDetails.loanTypeName}',
                        contractNo: widget.loanDetail.contractNo,
                        loanTypeIcon:
                            widget.loanDetail.contractDetails.loanTypeIcon,
                      ),
                      LoanInstallmentConclusionDetail(
                        // loanDetail: widget.loanDetail,
                        leftTitle: 'งวด',
                        rightTitle: 'ยอดครบกำหนดชำระ',
                        leftContent:
                            '${widget.loanDetail.paymentDetails.currentInstallmentNumber}/${widget.loanDetail.paymentDetails.totalInstallment}',
                        rightContent: convertDoubleCurrentcy(widget.loanDetail
                                .paymentDetails.currentInstallmentAmount)
                            .toString(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Container(
                          color: HexColor('#FAFAFA'),
                          height: 54,
                          child: ListView(
                            padding: const EdgeInsets.only(
                              left: 11,
                              right: 11,
                            ),
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...(optionsList.map((name) => SlidingLoanOptions(
                                    onLoanOptionSelected: onLoanOptionSelected,
                                    optionName: name,
                                    focusedOption: focusedOption,
                                  )))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Text(boxSize!.height.toString()),
                  if (boxHeight != null)
                    BlocBuilder<LoanInstallmentBloc, LoanInstallmentState>(
                      builder: (context, state) {
                        return LoanInstallTabContent(
                          loanDetail: widget.loanDetail,
                          loanDetailKeys: loanDetailKeys,
                          context: context,
                          focusedOption: focusedOption,
                          state: state,
                          heightAllComponents:
                              boxHeight! + topBarHeight! + bottomBarHeight!,
                        );
                      },
                    )
                ],
              ),
            ),
            Container(
              key: bottomBarKey,
              child: BootomButton(
                onButtonTap: () {
                  onPayButtonTap(widget.loanDetail, widget.loanDetail.dbName);
                },
                title: 'ชำระเงิน',
              ),
            )
          ],
        ));
  }
}
