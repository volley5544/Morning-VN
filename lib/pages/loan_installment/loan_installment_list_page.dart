import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_retention_bloc/loan_retention_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';

import 'package:mobile_application_srisawad/widgets/loan_card.dart';

class LoanInstallmentListPage extends StatefulWidget {
  const LoanInstallmentListPage({Key? key}) : super(key: key);

  @override
  State<LoanInstallmentListPage> createState() => _LoanInstallmentListPage();
}

class _LoanInstallmentListPage extends State<LoanInstallmentListPage> {
  late bool isCurrrentLoanSelected = true;
  late String selectedLoanType = 'สินเชื่อมอเตอร์ไซค์';
  LoanRepository loanRepository = LoanRepository();
  @override
  void initState() {
    context
        .read<LoanBloc>()
        .add(LoadLoanList(hashThaiId, loanRepository, context));
    super.initState();
  }

  void dispose() {
    //...
    super.dispose();
    //...
  }

  Future<void> onPayButtonTap(LoanDetail loanDetail, String dbName) async {
    await Navigator.of(context)
        .pushNamed('/payment-detail-page', arguments: loanDetail);
    context
        .read<LoanBloc>()
        .add(LoadLoanList(hashThaiId, loanRepository, context));
  }

  void onLoanOptionSelected(bool isSelected) {
    setState(() {
      isCurrrentLoanSelected = isSelected;
      selectedLoanType = isSelected ? 'สินเชื่อมอเตอร์ไซค์' : 'สินเชื่อเก่า';
    });
    if (!isSelected) {
      context.read<LoanRetentionBloc>().add(LoadLoanRetention());
    }
  }

  Future<void> onDetailSelected(LoanDetail loanDetail) async {
    await Navigator.of(context)
        .pushNamed('/loan-installment-detail', arguments: loanDetail);
  }

  Widget buttonOptions(
      {required bool isCurrent,
      required String title,
      required Function onLoanOptionSelected}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () => onLoanOptionSelected(),
        child: Container(
          // width: 127,
          height: 44,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.16),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            color: isCurrent ? HexColor('003063') : HexColor('#FFFFFF'),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isCurrent ? HexColor('#FFFFFF') : HexColor('003063'),
                    fontFamily: 'NotoSansThaiSemiBold',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    height: 1.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emtyListComponent() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              isCurrrentLoanSelected
                  ? 'ไม่มีรายการสินเชื่อปัจจุบัน'
                  : 'ไม่มีรายการสินเชื่อเก่า',
              style: TextStyle(
                  fontFamily: 'NotoSansThai',
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderOldListConponent(LoanRetentionState state) {
    switch (state.runtimeType) {
      case LoanRetentionLoading:
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          child: const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(219, 119, 26, 1),
            ),
          ),
        );
      case LoanRetentionComplete:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: isCurrrentLoanSelected
                  ? Text(
                      'ไม่มีรายการสินเชื่อปัจจุบัน',
                      style: TextStyle(
                          fontFamily: 'NotoSansThai',
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    )
                  : Text(
                      'ไม่พบข้อมูลสัญญาเก่า (ย้อนหลัง ${state.loanRetentionNumber} ปี)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'NotoSansThai',
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
            ),
          ],
        );
      case LoanRetentionError:
        return errorWidget();
      default:
        return Container();
    }
  }

  Widget renderOldEmptyList() {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.65,
      child: BlocBuilder<LoanRetentionBloc, LoanRetentionState>(
        builder: (context, state) {
          return renderOldListConponent(state);
        },
      ),
    );
  }

  Widget errorWidget() {
    return Center(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/file-load-error.svg',
              height: 50,
              width: 50,
            ),
            SizedBox(
              height: 4,
            ),
            Text("ไม่สามารถแสดงรายการได้ในขณะนี้",
                style:
                    Theme.of(context).textTheme.bodyMedium!.merge(TextStyle())),
            TextButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(vertical: 12, horizontal: 42)),
                ),
                onPressed: () => context
                    .read<LoanBloc>()
                    .add(LoadLoanList(hashThaiId, loanRepository, context)),
                child: Text("ลองอีกครั้ง",
                    style: Theme.of(context).textTheme.bodyMedium!.merge(
                        TextStyle(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.tertiary)))),
          ],
        ),
      ),
    );
  }

  Widget renderEmptyComps() {
    if (isCurrrentLoanSelected) {
      return emtyListComponent();
    } else {
      return renderOldEmptyList();
    }
  }

  Widget renderListConponent(LoanState state) {
    switch (state.runtimeType) {
      case LoanListLoading:
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.7,
          child: const Center(
            child: CircularProgressIndicator(
              color: Color.fromRGBO(219, 119, 26, 1),
            ),
          ),
        );
      case LoanListComplete:
        if (state.loanList.isNotEmpty) {
          List<LoanDetail> listToberendered = state.loanList
              .where((i) => isCurrrentLoanSelected
                  ? i.contractDetails.accountStatus == 'A'
                  : i.contractDetails.accountStatus == 'C')
              .toList();
          if (listToberendered.isNotEmpty) {
            return Column(
              children: [
                ...(listToberendered.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LoanCard(
                      context: context,
                      loanDetail: e,
                      onPayButtonTap: () => onPayButtonTap(e, e.dbName),
                      isDetail: true,
                      onDetailSelected: () => onDetailSelected(e),
                      isCurrentLoan: isCurrrentLoanSelected,
                      loanTypeIcon: e.contractDetails.loanTypeIcon,
                    ),
                  );
                }))
              ],
            );
          } else {
            return renderEmptyComps();
          }
        } else {
          return renderEmptyComps();
        }
      case LoanListError:
        return errorWidget();
      default:
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(219, 119, 26, 1),
                ),
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'รายการสินเชื่อของฉัน',
          style: Theme.of(context).textTheme.titleMedium!.merge(TextStyle(
              fontWeight: FontWeight.w600, fontFamily: 'NotoSansThaiSemiBold')),
        ),
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(child: BlocBuilder<LoanBloc, LoanState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(21, 14, 0, 5),
                child: Row(
                  children: [
                    buttonOptions(
                        title: 'สินเชื่อปัจจุบัน',
                        onLoanOptionSelected: () => onLoanOptionSelected(true),
                        isCurrent: isCurrrentLoanSelected),
                    buttonOptions(
                        title: 'สินเชื่อเก่า',
                        onLoanOptionSelected: () => onLoanOptionSelected(false),
                        isCurrent: !isCurrrentLoanSelected),
                  ],
                ),
              ),
              renderListConponent(state),
            ],
          );
        },
      )),
    );
  }
}

// Figma Flutter Generator SearchWidget - INSTANCE
