import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/insurance_product_bloc/insurance_product_bloc.dart';
import '../../modules/insurance_product/insurance_product_repository.dart';
import 'insurance_product_detail_page.dart';

class InsuranceProductListPage extends StatefulWidget {
  const InsuranceProductListPage({Key? key}) : super(key: key);

  @override
  State<InsuranceProductListPage> createState() => _InsuranceProductListPage();
}

class _InsuranceProductListPage extends State<InsuranceProductListPage> {
  InsuranceProductRepository repository = InsuranceProductRepository();

  @override
  void initState() {
    context.read<InsuranceProductBloc>()
        .add(LoadInsuranceProductListEvent(repository, context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'บริการประกันทั้งหมด',
            style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
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
        body: BlocBuilder<InsuranceProductBloc, InsuranceProductState>(
          builder: (context, state) {
            if (state is InsuranceProductListComplete) {
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
                        onTap: (){
                          InsuranceProductDetailPage.route(
                              context:context,
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
                              color: HexColor("#1D71B8")),
                          width: double.infinity,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      data.title??"",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.notoSansThai(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      data.description??"",
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
                                            image: NetworkImage(data.imageUrl??""))),
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
              return const Padding(
                padding: EdgeInsets.all(54),
                child: Text('404'),
              );
            }
          },
        ));
  }
}

// Figma Flutter Generator SearchWidget - INSTANCE
