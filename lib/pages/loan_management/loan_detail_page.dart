import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/bloc/loan_payment_bloc/loan_payment_bloc.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/models/payment_detail.dart';
import 'package:mobile_application_srisawad/modules/loan/index.dart';
import 'package:mobile_application_srisawad/pages/loan_management/bar_code_page.dart';
import 'package:mobile_application_srisawad/pages/loan_management/barcode_tab_selector.dart';
import 'package:mobile_application_srisawad/pages/loan_management/show_payment_data.dart';
import 'package:mobile_application_srisawad/util/permission_handler_util.dart';
import 'package:mobile_application_srisawad/widgets/loan_widgets/bank_icon_list.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:mobile_application_srisawad/widgets/loan_widgets/bootom_button.dart';
import 'package:mobile_application_srisawad/widgets/no_internet_widget.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../util/loan_icon.dart';
import '../../widgets/flash/top_flash.dart';

class LoanDetailPage extends StatefulWidget {
  final LoanDetail loanDetail;

  const LoanDetailPage({
    Key? key,
    required this.loanDetail,
  }) : super(key: key);

  @override
  State<LoanDetailPage> createState() => _LoanDetailPage();
}

// 021a8b41fb8ea3f121eeefaeef357f8c7fdda95361e24da366342cc6549215f6
class _LoanDetailPage extends State<LoanDetailPage> {
  LoanRepository loanRepository = LoanRepository();
  late bool isQrCodeSelected = true;
  late bool isShowImage = false;
  late File _image;
  bool? hasConnection = null;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void onQrCodeSelected(bool toggleQrCode) {
    setState(() {
      isQrCodeSelected = toggleQrCode;
    });
  }

  void onBarCodeSelected() {
    setState(() {
      isShowImage = true;
    });
  }

  Future<void> downloadImage(PaymentDetail paymentDetail) async {
    PermissionHandlerUtil.requestPermission(
        context: context,
        permission: Permission.storage,
        onGranted: () async {
          await ImageGallerySaver.saveImage(
              Uint8List.fromList(Uint8List.fromList(isQrCodeSelected
                  ? paymentDetail.qrform.data.cast<int>()
                  : paymentDetail.barForm.data.cast<int>())),
              quality: 60);
          showTopFlash(
              margin: EdgeInsets.symmetric(horizontal: 22),
              duration: 2,
              barrierColor: Colors.transparent,
              contents: Container(
                width: double.infinity,
                color: Color.fromRGBO(0, 0, 0, 0.8),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                    child: Container(
                        child: Row(children: [
                      SvgPicture.asset('assets/SuccessSnackIcon.svg'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'บันทึกรูปภาพสำเร็จ',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.merge(TextStyle(
                              fontWeight: FontWeight.w400,
                              // fontFamily:
                              //     'NotoSansThaiSemiBold'
                            )),
                      )
                    ]))),
              ),
              context: context);
        });
  }

  @override
  Widget build(BuildContext context) {
    return (hasConnection != null)
        ? (hasConnection! ? getNormalStateWidget() : getNoInternetWidget())
        : Container();
  }

  Future<void> initData() async {
    if (await InternetConnectionChecker().hasConnection) {
      context.read<LoanPaymentBloc>().add(LoadPaymentDetail(
          consumerNo: widget.loanDetail.contractNo,
          context: context,
          dbName: widget.loanDetail.dbName,
          loanRepository: loanRepository));
      setState(() {
        hasConnection = true;
      });
    } else {
      setState(() {
        hasConnection = false;
      });
    }
  }

  getNormalStateWidget() {
    return Scaffold(
      appBar: isShowImage
          ? null
          : AppBar(
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
              leading: GestureDetector(
                  onTap: () {
                    // Navigator.of(context).maybePop();
                    Navigator.of(context).pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset('assets/GoBackIcon.svg'),
                  ))),
      body: BlocConsumer<LoanPaymentBloc, LoanPaymentState>(
        listener: (context, state) {
          if (state is LoanPaymentDetailNoInternet) {
            setState(() {
              hasConnection = false;
            });
          }
        },
        builder: (blocContext, state) {
          if (state is LoanPaymentDetailLoading) {
            return ProgressLoading();
          }
          if (state is LoanPaymentDetailComplete) {
            if (isShowImage) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Stack(
                  children: [
                    Center(
                      child: Hero(
                        tag: 'imageHero',
                        child: Image.memory(Uint8List.fromList(
                            state.paymentDetail.barForm.data.cast<int>())),
                      ),
                    ),
                    Positioned(
                        top: 7,
                        right: 7,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isShowImage = false;
                              });
                            },
                            child: SvgPicture.asset(
                                'assets/PrimaryClearIcon.svg')))
                  ],
                ),
              );
            }
            return Stack(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: ShowPayMentData(
                          collateralInformation:
                              state.paymentDetail.detail.collateralInformation,
                          contractCreateDate:
                              state.paymentDetail.detail.dataDate,
                          contractName:
                              widget.loanDetail.contractDetails.loanTypeName,
                          contractNo: state.paymentDetail.detail.contractNo,
                          currentInstallmentAmount:
                              state.paymentDetail.qrCodeDetail.amount,
                          loanIcon:
                              widget.loanDetail.contractDetails.loanTypeIcon,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 1,
                        color: HexColor('#E5E5E5'),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          children: [
                            BarCodeTabSelector(
                              isQrCodeSelected: isQrCodeSelected,
                              onQrCodeSelected: onQrCodeSelected,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BarCodePageg(
                              paymentDetail: state.paymentDetail,
                              isBarCodeShow: isQrCodeSelected,
                              onBarCodeSelected: onBarCodeSelected,
                            ),
                            isQrCodeSelected
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.only(top: 36),
                                    child: Text('กดรูปบาร์โค้ดเพื่อขยาย'),
                                  ),
                            const Text(
                                'คุณสามารถสแกนชำระค่างวดได้ที่ศรีสวัสดิ์ทุกสาขาหรือ'),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: BankIconList(context: context),
                            ),
                            SizedBox(
                              height: 120,
                            )
                          ],
                        ),
                      )),
                    ]),
                Positioned(
                  bottom: 0,
                  child: BootomButton(
                    onButtonTap: () {
                      downloadImage(state.paymentDetail);
                    },
                    title: 'บันทึกรูปภาพ',
                  ),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  getNoInternetWidget() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            SafeArea(
                child: isShowImage
                    ? Container()
                    : AppBar(
                        elevation: 0,
                        centerTitle: true,
                        title: Text(
                          'ชำระด้วย QR',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        backgroundColor: Colors.white,
                        leading: GestureDetector(
                            onTap: () {
                              // Navigator.of(context).maybePop();
                              Navigator.of(context).pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset('assets/GoBackIcon.svg'),
                            )))),
            Center(
              child: NoInternetWidget(onRetry: () {
                initData();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Figma Flutter Generator SearchWidget - INSTANCE
