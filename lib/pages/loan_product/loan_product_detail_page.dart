import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/widgets/button.dart';
import 'package:mobile_application_srisawad/widgets/product_detail/product_detail_top_section.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../bloc/loan_product_detail_bloc/loan_product_detail_bloc.dart';
import '../../models/product_detail/product_detail_title_content_list_model.dart';
import '../../modules/loanproduct/loan_product_repository.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/product_detail/product_detail_title_bullet_list_section.dart';
import '../../widgets/product_detail/product_detail_title_grid_list_section.dart';
import '../../widgets/text_compent.dart';

class LoanProductDetailPage extends StatefulWidget {
  LoanProductDetailPage({Key? key, required this.productId}) : super(key: key);
  final String productId;

  static String ARGS_PRODUCT_ID = "product_id";

  @override
  State<LoanProductDetailPage> createState() => _LoanProductDetailPageState();

  static Future<dynamic> route(
      {required BuildContext context, required String productId}) async {
    return Navigator.of(context).pushNamed('/loan-product-detail',
        arguments: {ARGS_PRODUCT_ID: productId});
  }

  static Future<dynamic> routeAndClear(
      {required BuildContext context, required String productId}) {
    return Navigator.pushNamedAndRemoveUntil(
        context,
        '/loan-product-detail',
        arguments: {ARGS_PRODUCT_ID: productId},
        (Route<dynamic> route) => false);
  }

  static navigate(dynamic args) {
    return LoanProductDetailPage(productId: args[ARGS_PRODUCT_ID]);
  }
}

class _LoanProductDetailPageState extends State<LoanProductDetailPage> {
  LoanProductRepository repository = LoanProductRepository();

  @override
  void initState() {
    reloadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoanProductDetailBloc, LoanProductDetailState>(
        builder: (context, state) {
      if (state is LoanProductDetailNoInternet) {
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
                    reloadData();
                  },
                ),
              ),
            ],
          ),
        );
      } else if (state is LoanProductDetailLoading) {
        return Scaffold(
          body: Center(child: ProgressLoading()),
        );
      } else if (state is LoanProductDetailComplete) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Stack(
                  children: [
                    Image.asset('assets/bg_loan_detail.jpg',
                        width: double.infinity, fit: BoxFit.fitWidth),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SafeArea(
                          child: getImageLogo(state.productDetail?.imageUrl),
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProductDetailTopSection(
                                      data: state.productDetail?.top,
                                    ),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    LoanAdvantageSection(
                                      data: state.productDetail?.advantage,
                                    ),
                                    SizedBox(
                                      height: 23,
                                    ),
                                    ProductDetailTitleGridListSection(
                                      data: state.productDetail?.document,
                                    ),
                                    SizedBox(
                                      height: 34,
                                    ),
                                    ProductDetailTitleBulletListSection(
                                      data: state.productDetail?.otherDocument,
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                    ProductDetailTitleBulletListSection(
                                      data: state.productDetail?.qualification,
                                    ),
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
                        color: HexColor("#FFFFFF"),
                        'assets/back-icon.svg',
                        height: 38,
                        width: 38,
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
                  Navigator.of(context)
                      .pushNamed('/loan-lead', arguments: state.productDetail);
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
    });
  }

  getImageLogo(String? url) {
    if (url != null && (url).isNotEmpty) {
      return Image.network(
        url,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/logo_loan_detail.png');
        },
        width: getActualWidth(context) / 1.7,
        alignment: Alignment.bottomCenter,
      );
    } else {
      return Image(
          width: getActualWidth(context) / 1.7,
          alignment: Alignment.bottomCenter,
          image: AssetImage('assets/logo_loan_detail.png'));
    }
  }

  void checkInternet(
      {required Function onConnected, required Function onNotConnected}) async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (hasConnection) {
      onConnected.call();
    } else {
      onNotConnected.call();
    }
  }

  void reloadData() {
    context.read<LoanProductDetailBloc>().add(LoadLoanProductDetailEvent(
        productId: widget.productId, repository: repository, context: context));
  }

  void onClickBackButton() {
    Navigator.of(context).pop("back");
  }
}

class LoanAdvantageSection extends StatelessWidget {
  LoanAdvantageSection({Key? key, this.data}) : super(key: key);
  ProductDetailTitleContentListModel? data;

  @override
  Widget build(BuildContext context) {
    if (data != null &&
        data!.title != null &&
        data!.title!.isNotEmpty &&
        data!.content != null &&
        data!.content!.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Subtitle2(data!.title!).styleSecondary(),
          ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 7),
              padding: EdgeInsets.only(top: 13),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data!.content!.length,
              itemBuilder: (context, index) {
                var item = data!.content![index];
                if (item.imageUrl != null &&
                    item.imageUrl!.isNotEmpty &&
                    item.description != null &&
                    item.description!.isNotEmpty) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.imageUrl ?? ""))),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Subtitle2(item.description!).styleGrey(),
                      )
                    ],
                  );
                } else {
                  return Container();
                }
              })
        ],
      );
    } else {
      return Container();
    }
  }
}
