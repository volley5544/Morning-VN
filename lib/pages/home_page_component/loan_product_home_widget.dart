import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_product_bloc/loan_product_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/modules/loanproduct/loan_product_repository.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

import '../loan_product/loan_product_detail_page.dart';

class LoanProductHomeWidget extends StatefulWidget {
  final bool? isExist;
  const LoanProductHomeWidget({super.key, this.isExist});

  @override
  State<LoanProductHomeWidget> createState() => _LoanProductHomeWidgetState();
}

class _LoanProductHomeWidgetState extends State<LoanProductHomeWidget> {
  LoanProductRepository repository = LoanProductRepository();

  @override
  void initState() {
    context
        .read<LoanProductBloc>()
        .add(LoadLoanProductListEvent(repository, context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanProductBloc, LoanProductState>(
        builder: (context, state) {
      if (state is LoanProductListComplete) {
        return Padding(
            padding: EdgeInsets.only(top: widget.isExist! ? 17 : 0, bottom: 20),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SectionTextTitle("บริการสินเชื่อ"),
                    InkWell(
                        onTap: () {
                          BlocProvider.of<PageResultBloc>(context)
                              .add(const SetButtonNavigator(false));
                          Navigator.of(context)
                              .pushNamed('/loan-product-list')
                              .then((value) {
                            BlocProvider.of<PageResultBloc>(context)
                                .add(const SetButtonNavigator(true));
                          });
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
              SizedBox(height: 6),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 22),
                width: double.infinity,
                height: getActualWidth(context) / 2.3,
                child: ListView.separated(
                  clipBehavior: Clip.none,
                  itemCount: state.productList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return InkWell(
                      onTap: () async {
                        BlocProvider.of<PageResultBloc>(context)
                            .add(const SetButtonNavigator(false));
                        final result = await LoanProductDetailPage.route(
                            context: context,
                            productId: state.productList[index].id);
                        if (result == "back") {
                          BlocProvider.of<PageResultBloc>(context)
                              .add(const SetButtonNavigator(true));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: HexColor("#29000000"),
                                  blurRadius: 10,
                                  offset: Offset(0, 4))
                            ],
                            borderRadius: BorderRadius.circular(14),
                            color: HexColor("#F18700")),
                        width: getActualWidth(context) / 2.9,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    state.productList[index].title ?? "",
                                    style: GoogleFonts.notoSansThai(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    state.productList[index].description ?? "",
                                    style: GoogleFonts.notoSansThai(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(state
                                                    .productList[index]
                                                    .imageUrl ??
                                                ""))),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: 10,
                    );
                  },
                ),
              )
            ]));
      } else {
        return Container();
      }
    });
  }
}
