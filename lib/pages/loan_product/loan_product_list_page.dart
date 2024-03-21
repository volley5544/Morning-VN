import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/loan_product_bloc/loan_product_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/modules/loanproduct/loan_product_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'loan_product_detail_page.dart';

class LoanProductListPage extends StatefulWidget {
  const LoanProductListPage({Key? key}) : super(key: key);

  @override
  State<LoanProductListPage> createState() => _LoanProductListPage();
}

class _LoanProductListPage extends State<LoanProductListPage> {
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'บริการสินเชื่อทั้งหมด',
            style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
          ),
          backgroundColor: Colors.white,
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
        body: BlocBuilder<LoanProductBloc, LoanProductState>(
          builder: (context, state) {
            if (state is LoanProductListComplete) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                width: double.infinity,
                child: GridView.builder(
                    clipBehavior: Clip.none,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 153 / 186,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemCount: state.productList.length,
                    itemBuilder: (context, index) {
                      var data = state.productList[index];
                      return InkWell(
                        onTap: () {
                          LoanProductDetailPage.route(
                              context: context,
                              productId: state.productList[index].id);
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
                          width: double.infinity,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      data.title ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.notoSansThai(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      data.description ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.notoSansThai(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                data.imageUrl ?? ""))),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
