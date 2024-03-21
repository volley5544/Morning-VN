import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/widgets/loan_card.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

class PersonalLoanList extends StatefulWidget {
  LoanState loanState;

  PersonalLoanList({Key? key, required this.loanState}) : super(key: key);

  @override
  State<PersonalLoanList> createState() => _PersonalLoanListState();
}

class _PersonalLoanListState extends State<PersonalLoanList> {
  LoanRepository loanRepository = LoanRepository();
  var currentIndex = 0;
  var carouselController = CarouselController();

  @override
  void initState() {
    context
        .read<LoanBloc>()
        .add(LoadLoanList(hashThaiId, loanRepository, context));
    super.initState();
  }

  void onDetailSelected(LoanDetail loanDetail) {
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetButtonNavigator(false));
    Navigator.of(context)
        .pushNamed('/loan-installment-detail', arguments: loanDetail)
        .then((_) => setState(() {
              BlocProvider.of<PageResultBloc>(context)
                  .add(const SetButtonNavigator(true));
            }));
    ;
  }

  void onPayButtonTap(LoanDetail loanDetail, String dbName) {
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetButtonNavigator(false));
    Navigator.of(context)
        .pushNamed('/payment-detail-page', arguments: loanDetail);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SectionTextTitle("สินเชื่อของฉัน"),
            InkWell(
                onTap: () {
                  BlocProvider.of<PageResultBloc>(context)
                      .add(const SetButtonNavigator(false));
                  Navigator.of(context).pushNamed('/loan-installment-list');
                },
                child: Text(
                  'ดูทั้งหมด',
                  style: GoogleFonts.notoSansThai(
                    decoration: TextDecoration.underline,
                    color: HexColor('#DB771A'),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ))
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Builder(builder: (context) {
        if (widget.loanState is LoanListLoading) {
          return Container(
            height: 153,
            child: CircularProgressIndicator(
              color: Color.fromRGBO(219, 119, 26, 1),
            ),
            alignment: Alignment.center,
          );
        } else if (widget.loanState is LoanListComplete) {
          final GetActiveAccount = widget.loanState.loanList
              .where((i) => i.contractDetails.accountStatus == 'A')
              .toList();
          if (widget.loanState.loanList.isEmpty || GetActiveAccount.isEmpty) {
            return SizedBox(
              width: double.infinity,
              height: 92,
              child: Center(
                child: Text(
                  'ไม่มีรายการสินเชื่อปัจจุบัน',
                  style: TextStyle(
                      fontFamily: 'NotoSansThai',
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            );
          } else {
            return Column(children: [
              Container(
                width: double.infinity,
                // height: 159,
                constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).textScaleFactor != 1 ? 170 : 150,
                ),
                child: CarouselSlider(
                  items: GetActiveAccount.map((name) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: LoanCard(
                          loanCardWidth: getActualWidth(context) * 0.9,
                          context: context,
                          loanDetail: name,
                          onPayButtonTap: () =>
                              onPayButtonTap(name, name.dbName),
                          isDetail: true,
                          onDetailSelected: () => onDetailSelected(name),
                          isCurrentLoan: true,
                          loanTypeIcon: name.contractDetails.loanTypeIcon,
                        ),
                      )).toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                      // height: 170,
                      clipBehavior: Clip.none,
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      viewportFraction: 0.93,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: GetActiveAccount.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => carouselController.animateToPage(entry.key),
                    child: Row(
                      children: [
                        Container(
                            width: currentIndex == entry.key ? 28.0 : 8,
                            height: 8.0,
                            margin: EdgeInsets.fromLTRB(4, 14, 4, 4),
                            // EdgeInsets.symmetric(
                            //     vertical: 16.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: currentIndex == entry.key
                                    ? HexColor('#DB771A').withOpacity(
                                        currentIndex == entry.key ? 1 : 0.4)
                                    : HexColor('#E5E5E5'))),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ]);
          }
        } else if (widget.loanState is LoanListError) {
          return Center(
            child: Container(
              height: 153,
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .merge(TextStyle())),
                  TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(vertical: 12, horizontal: 42)),
                      ),
                      onPressed: () => context.read<LoanBloc>().add(
                          LoadLoanList(hashThaiId, loanRepository, context)),
                      child: Text("ลองอีกครั้ง",
                          style: Theme.of(context).textTheme.bodyMedium!.merge(
                              TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary)))),
                ],
              ),
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(54),
            child: CircularProgressIndicator(
              color: Color.fromRGBO(219, 119, 26, 1),
            ),
          );
        }
      }),
    ]);
  }
}
