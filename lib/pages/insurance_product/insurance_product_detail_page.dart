import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';
import 'package:mobile_application_srisawad/widgets/product_detail/product_detail_title_grid_list_section.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

import '../../bloc/insurance_product_detail_bloc/insurance_product_detail_bloc.dart';
import '../../models/insurance_product/insurance_product_detail_choice_model.dart';
import '../../models/insurance_product/insurance_product_detail_company_choice_model.dart';
import '../../models/insurance_product/insurance_product_detail_table_model.dart';
import '../../modules/insurance_product/insurance_product_repository.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/product_detail/product_detail_title_bullet_list_section.dart';
import '../../widgets/product_detail/product_detail_top_section.dart';

class InsuranceProductDetailPage extends StatefulWidget {
  InsuranceProductDetailPage({Key? key, required this.productId})
      : super(key: key);
  final String productId;

  static String ARGS_PRODUCT_ID = "product_id";

  static Future<dynamic> route(
      {required BuildContext context, required String productId}) async {
    return Navigator.of(context).pushNamed('/insurance-product-detail',
        arguments: {ARGS_PRODUCT_ID: productId});
  }

  static Future<dynamic> routeAndClear(
      {required BuildContext context, required String productId}) {
    return Navigator.pushNamedAndRemoveUntil(
        context,
        '/insurance-product-detail',
        arguments: {ARGS_PRODUCT_ID: productId},
        (Route<dynamic> route) => false);
  }

  static navigate(dynamic args) {
    return InsuranceProductDetailPage(productId: args[ARGS_PRODUCT_ID]);
  }

  @override
  State<InsuranceProductDetailPage> createState() =>
      _InsuranceProductDetailPageState();
}

class _InsuranceProductDetailPageState
    extends State<InsuranceProductDetailPage> {
  InsuranceProductRepository repository = InsuranceProductRepository();

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InsuranceProductDetailBloc, InsuranceProductDetailState>(
      builder: (context, state) {
        if (state is InsuranceProductDetailNoInternet) {
          return Container(
            color: Colors.white,
            child: Stack(
              children: [
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          onClickBackButton();
                        },
                        icon: SvgPicture.asset(
                          color: Colors.black,
                          'assets/back-icon.svg',
                          height: 38,
                          width: 38,
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: NoInternetWidget(
                    onRetry: () {
                      initData();
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is InsuranceProductDetailLoading) {
          return Scaffold(
            body: Center(child: ProgressLoading()),
          );
        } else if (state is InsuranceProductDetailComplete) {
          return Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Stack(
                    children: [
                      Image.asset('assets/bg_loan_detail.jpg',
                          width: double.infinity, fit: BoxFit.fitWidth),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SafeArea(
                            child: getImageLogo(state.productDetail?.imageUrl),
                          ),
                          Column(
                            children: [
                              Container(
                                width: getActualWidth(context),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 19),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ProductDetailTopSection(
                                        data: state.productDetail?.insuranceTop,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ProductDetailTitleGridListSection(
                                        data: state
                                            .productDetail?.insuranceAdvantage,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      InsuranceTable(
                                        data:
                                            state.productDetail?.insuranceTable,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      InsuranceCompanyChoice(
                                        data: state.productDetail
                                            ?.insuranceCompanyChoice,
                                      ),
                                      SizedBox(
                                        height: 35,
                                      ),
                                      InsuranceChoice(
                                        data: state
                                            .productDetail?.insuranceChoice,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.7),
                          Color.fromRGBO(0, 0, 0, 0),
                        ],
                      )),
                    ),
                    SafeArea(
                      child: IconButton(
                        onPressed: () {
                          onClickBackButton();
                        },
                        icon: SvgPicture.asset(
                          'assets/back-icon.svg',
                          height: 38,
                          width: 38,
                          color: HexColor("#FFFFFF"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22),
                child: Button(
                  color: "DB771A",
                  isTextBlack: false,
                  // width: double.infinity,
                  height: 60,
                  textButton: 'สนใจสมัคร',
                  buttonCallBack: () {
                    Navigator.of(context).pushNamed('/insurance-lead',
                        arguments: state.productDetail);
                  },
                ),
              ),
            ),
          );
        } else {
          return SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    onClickBackButton();
                  },
                  icon: SvgPicture.asset(
                    color: Colors.black,
                    'assets/back-icon.svg',
                    height: 38,
                    width: 38,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void initData() {
    context.read<InsuranceProductDetailBloc>().add(
        LoadInsuranceProductDetailEvent(
            productId: widget.productId,
            repository: repository,
            context: context));
  }

  void onClickBackButton() {
    Navigator.of(context).pop("back");
  }

  getImageLogo(String? url) {
    if (url != null && (url).isNotEmpty) {
      return Image.network(
        url,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/logo_insurance_detail.png');
        },
        width: getActualWidth(context) / 0.3,
        alignment: Alignment.bottomCenter,
      );
    } else {
      return Image(
          width: getActualWidth(context) / 0.3,
          alignment: Alignment.bottomCenter,
          image: AssetImage('assets/logo_insurance_detail.png'));
    }
  }
}

class InsuranceTable extends StatelessWidget {
  const InsuranceTable({Key? key, required this.data}) : super(key: key);
  final InsuranceProductDetailTableModel? data;

  @override
  Widget build(BuildContext context) {
    if (data != null &&
        data!.title != null &&
        data!.title!.isNotEmpty &&
        data!.imageUrl != null &&
        data!.imageUrl!.isNotEmpty) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child:
                    TextTitle(data!.title!, TextAlign.center).styleSecondary()),
            SizedBox(
              height: 14,
            ),
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(13)),
                child: Image.network(data!.imageUrl!, fit: BoxFit.fitWidth))
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

class InsuranceCompanyChoice extends StatelessWidget {
  InsuranceCompanyChoice({Key? key, this.data}) : super(key: key);
  InsuranceProductDetailCompanyChoiceModel? data;

  @override
  Widget build(BuildContext context) {
    if (data != null &&
        data!.title != null &&
        data!.title!.isNotEmpty &&
        data!.imageUrlList != null &&
        data!.imageUrlList!.isNotEmpty) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Text(
                  data!.title ?? "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSansThai(
                      color: HexColor("#1D71B8"),
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
            GridView.builder(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 33,
                    mainAxisSpacing: 14),
                itemCount: data!.imageUrlList!.length,
                itemBuilder: (context, index) {
                  var item = data!.imageUrlList![index];
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor("E5E5E5"), width: 1),
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(item))),
                  );
                })
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}

class InsuranceChoice extends StatelessWidget {
  InsuranceChoice({Key? key, this.data}) : super(key: key);
  InsuranceProductDetailChoiceModel? data;

  @override
  Widget build(BuildContext context) {
    if (data != null &&
        data!.title != null &&
        data!.title!.isNotEmpty &&
        data!.bulletList != null &&
        data!.bulletList!.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                data!.title ?? "",
                style: GoogleFonts.notoSansThai(
                    color: HexColor("#1D71B8"),
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
          ),
          ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 39),
              padding: EdgeInsets.only(top: 14),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.bulletList!.length,
              itemBuilder: (context, index) {
                var section = data!.bulletList![index];
                return ProductDetailTitleBulletListSection(data: section);
              })
        ],
      );
    } else {
      return Container();
    }
  }
}
