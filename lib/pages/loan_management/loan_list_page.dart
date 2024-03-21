import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';

import 'package:mobile_application_srisawad/widgets/loan_card.dart';

class LoanListPage extends StatefulWidget {
  const LoanListPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoanListPage> createState() => _LoanListPage();
}

// 021a8b41fb8ea3f121eeefaeef357f8c7fdda95361e24da366342cc6549215f6
class _LoanListPage extends State<LoanListPage> {
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
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetButtonNavigator(false));
    await Navigator.of(context)
        .pushNamed('/payment-detail-page', arguments: loanDetail);
    context
        .read<LoanBloc>()
        .add(LoadLoanList(hashThaiId, loanRepository, context));
  }

  Widget renderLoanList(List<LoanDetail> GetActiveAccount) {
    return Column(
      children: [
        ...(GetActiveAccount.map((e) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoanCard(
              context: context,
              loanDetail: e,
              isCurrentLoan: true,
              onPayButtonTap: () => onPayButtonTap(e, e.dbName),
              loanTypeIcon: e.contractDetails.loanTypeIcon,
            ),
          );
        }))
      ],
    );
  }

  Widget renderLoanPage(LoanState state) {
    Text emptyText = Text(
      'ไม่มีรายการสินเชื่อปัจจุบัน',
      style: TextStyle(
          fontFamily: 'NotoSansThai',
          fontSize: 18,
          fontWeight: FontWeight.w400),
    );
    switch (state.runtimeType) {
      case (LoanListComplete):
        final GetActiveAccount = state.loanList
            .where((i) => i.contractDetails.accountStatus == 'A')
            .toList();
        if (state.loanList.isEmpty || GetActiveAccount.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(child: emptyText),
          );
        } else
          return renderLoanList(GetActiveAccount);
      case (LoanListLoading):
        return Center(
          child: CircularProgressIndicator(
            color: Color.fromRGBO(219, 119, 26, 1),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'ชำระด้วย QR',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
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
          if (state is LoanInitial) {
            context
                .read<LoanBloc>()
                .add(LoadLoanList(hashThaiId, loanRepository, context));
          }
          // if (state is LoanListComplete) {
          //   return Text(state.loanList[0].contractBankBrandname);
          // }
          return Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.loanList.isEmpty
                  ? Container()
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(21, 20, 0, 15),
                        child: Text(
                          'กรุณาเลือกสินเชื่อที่ต้องการชำระ',
                          style: TextStyle(
                              color: Color.fromRGBO(64, 64, 64, 1),
                              fontFamily: 'NotoSansThai',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1),
                        ),
                      ),
                    ),
              renderLoanPage(state)
            ],
          );
        },
      )),
    );
  }
}

// Figma Flutter Generator SearchWidget - INSTANCE
