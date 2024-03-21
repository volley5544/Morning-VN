import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_detail.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_styling.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_widgets/back_account_infonaion.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dialog/server_suspended_dialog.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/models/topup_status_detail_model.dart';
import 'package:mobile_application_srisawad/modules/topupRepo/index.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_widgets/timeline_card.dart';
import 'package:mobile_application_srisawad/pages/topup/topup_widgets/topup_status_detail_card.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';

import '../../util/width_until.dart';
import '../../util/currentcy_format.dart';
import '../../widgets/no_internet_widget.dart';
import '../../widgets/topic_widget.dart';
import 'topup_status_file_page.dart';

class TopupStatusDetailPage extends StatefulWidget {
  LoanDetail loanDetail;
  final String transNo;
  final String dbName;

  TopupStatusDetailPage({
    required LoanDetail this.loanDetail,
    required String this.transNo,
    super.key,
    required this.dbName,
  });

  @override
  State<TopupStatusDetailPage> createState() => _TopupStatusDetailPageState();
}

class _TopupStatusDetailPageState extends State<TopupStatusDetailPage> {
  bool isLoading = false;
  bool? hasConnection = null;
  TopupRepository topupRepository = TopupRepository();
  TopupDetailStatusModel detailStatusModel = TopupDetailStatusModel(
    contractName: '-',
    contractNo: '-',
    contractBankAccount: '-',
    contractBankBrandname: '-',
    loanTypeCode: '-',
    loanTypeName: '-',
    requestDate: '-',
    requestStatus: '-',
    collateralInformationl: '-',
    amount: 0,
    amountPerInstallment: 0,
    installmentNumber: 0,
    totalAmountWithRate: 0,
    interestRate: 0,
    topupRequestFile: '',
    topupArgeementFile: '',
    topupReceiptFile: '',
    branchImage: '',
    actualReceiveAmount: 0,
    loanTypeIcon: '',
  );

  static const configKey = [
    {'label': 'ยอดจัดสินเชื่อ', 'valueField': 'amount'},
    {'label': 'ค่างวด', 'valueField': 'intstallment_amount'},
    {'label': 'จำนวนงวด', 'valueField': 'installment_number'},
    {'label': 'ดอกเบี้ย', 'valueField': 'interest'},
    {'label': 'จำนวนเงินที่จะได้รับ', 'valueField': 'actual_paid'},
  ];

  Map<String, dynamic> setModelEncode(
      TopupDetailStatusModel detailStatusModel) {
    return {
      'amount': convertDoubleCurrentcy(detailStatusModel.amount),
      'intstallment_amount':
          convertDoubleCurrentcy(detailStatusModel.amountPerInstallment),
      'installment_number': detailStatusModel.installmentNumber.toString(),
      'interest': detailStatusModel.interestRate.toString(),
      'actual_paid': convertCurrentcy(detailStatusModel.actualReceiveAmount),
    };
  }

  Map<String, dynamic> textFieldSuffix() {
    return {
      'amount': ' บาท',
      'intstallment_amount': ' บาท',
      'installment_number': ' งวด',
      'interest': '%',
      'actual_paid': ' บาท'
    };
  }

  Widget renderInstallmentData(
      Map<String, String> key, TopupDetailStatusModel detailStatusModel) {
    TextStyle rightContentStyle = TextStyle(
        fontSize: 16,
        color: HexColor('#404040'),
        fontFamily: 'NotoSansThaiSemiBold');
    TextStyle leftContentStyle = TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: HexColor('#404040'),
        fontFamily: 'NotoSansThai');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${key['label']}',
                style:
                    size14WNormal.merge(TextStyle(color: HexColor('#404040'))),
              ),
              Text(
                '${setModelEncode(detailStatusModel)[key['valueField']]}${textFieldSuffix()[key['valueField']]}',
                style: TextStyle(
                    color: HexColor('#404040'),
                    fontFamily: 'NotoSansThai',
                    fontSize: 16,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w600,
                    height: 1),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          color: HexColor('#E5E5E5'),
        )
      ],
    );
  }

  final ObjectDetail = TopupRepository();
  getFecthData() async {
    try {
      if (await InternetConnectionChecker().hasConnection) {
        setState(() {
          isLoading = true;
          hasConnection = true;
        });
        // TODO Saksit add dbname
        final result = await ObjectDetail.getTopupDetailStatus(
            widget.loanDetail.transNo == ''
                ? widget.transNo
                : widget.loanDetail.transNo,
            widget.loanDetail.dbName);
        setState(() {
          detailStatusModel = result;
          isLoading = false;
        });
      } else {
        setState(() {
          hasConnection = false;
        });
      }
    } on RESTApiException catch (e) {
      Navigator.of(context).pop();
      serverSuspendedDialog(context, additionalText: e.cause.toString());
    } catch (e) {
      serverSuspendedDialog(context, additionalText: e.toString());
    }
  }

  @override
  void initState() {
    getFecthData();
    super.initState();
  }

  renderPdfFile(String fileName, String fileTitle) async {
    io.Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String _path = "$appDocPath/${fileName}.pdf";
    io.File _doccumentFile = io.File(_path);
    dynamic _DoccumentFilebytes;
    if (fileName == 'requestDocument') {
      _DoccumentFilebytes =
          base64.decode(detailStatusModel.topupRequestFile.split(',')[1]);
    }
    if (fileName == 'paySlip') {
      _DoccumentFilebytes =
          base64.decode(detailStatusModel.topupReceiptFile.split(',')[1]);
    }
    if (fileName == 'contactDocument') {
      _DoccumentFilebytes =
          base64.decode(detailStatusModel.topupArgeementFile.split(',')[1]);
    }

    await _doccumentFile.writeAsBytes(_DoccumentFilebytes.buffer.asUint8List());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TopupStatusFile(
                fileTitle: '${fileTitle}', filePath: _doccumentFile.path)));
  }

  @override
  Widget build(BuildContext context) {
    return (hasConnection != null)
        ? (hasConnection! ? getNormalStateWidget() : getNoInternetWidget())
        : Container();
  }

  getNormalStateWidget() {
    colorSected(String statusCode) {
      if (statusCode == 'รออนุมัติ') {
        return HexColor('#E8903E');
      }
      if (statusCode == 'โอนเงินสำเร็จ') {
        return HexColor('#1A9F3F');
      }
      if (statusCode == 'ไม่ผ่านการตรวจสอบ') {
        return HexColor('#646464');
      }
      if (statusCode == 'รอตรวจสอบและโอนเงิน') {
        return HexColor('#1D71B8');
      }
      if (statusCode == 'อยู่ระหว่างดำเนินการ') {
        return HexColor('#404040');
      }
    }

    Widget getBankImage() {
      if (detailStatusModel.branchImage.isNotEmpty) {
        return ClipRRect(
            child: Image.memory(
              getdDtaUrlImage(detailStatusModel.branchImage),
              width: 48,
              height: 48,
            ),
            borderRadius: BorderRadius.circular(48 / 2));
      } else {
        return Container(
          color: Colors.white,
          width: 48,
          height: 48,
        );
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('รายละเอียดการขอสินเชื่อ',
              style: TextStyle(
                      color: HexColor('#003063'),
                      fontSize: 16,
                      fontWeight: FontWeight.w600)
                  .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
          elevation: 0,
          leading: IconButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset('assets/back-icon.svg'),
          ),
        ),
        body: (isLoading
            ? Center(
                child: ProgressLoading(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: HexColor('#FFFFFF'),
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: renderLoanTypeIcon(
                                  detailStatusModel.loanTypeIcon)),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 24, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(detailStatusModel.loanTypeName,
                                      style: GoogleFonts.notoSansThai(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: HexColor('#003063'))),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'เลขที่สัญญา',
                                          style: GoogleFonts.notoSansThai(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor('#404040')),
                                        ),
                                        Text(
                                          detailStatusModel.contractNo,
                                          style: GoogleFonts.notoSansThai(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: HexColor('#404040')),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ข้อมูลหลักประกัน',
                                          style: GoogleFonts.notoSansThai(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: HexColor('#404040')),
                                        ),
                                        Text(
                                          detailStatusModel
                                              .collateralInformationl,
                                          style: GoogleFonts.notoSansThai(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: HexColor('#404040')),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          TopicWidget(
                            title: 'สถานะขอสินเชื่อ',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Text(
                                  'วันที่ขอสินเชื่อ',
                                  style: GoogleFonts.notoSansThai(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: HexColor('#646464')),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: Text(
                                  formateBudDate(
                                    detailStatusModel.requestDate,
                                  ),
                                  style: TextStyle(
                                      color: HexColor("#404040"),
                                      fontFamily: 'NotoSansThai',
                                      fontSize: 14,
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      height: 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TimelineCard(
                                    statusCode:
                                        detailStatusModel.requestStatus),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 24),
                                child: Text(
                                  detailStatusModel.requestStatus,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.merge(
                                        TextStyle(
                                            color: colorSected(detailStatusModel
                                                .requestStatus)),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          TopicWidget(
                            title: 'รายละเอียดสัญญา',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ...(configKey.map((key) {
                            return renderInstallmentData(
                                key, detailStatusModel);
                          })),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TopicWidget(
                                title: 'ข้อมูลเลขที่บัญชี',
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 20),
                              //   child: Text(
                              //     'เลขบัญชี',
                              //     style: GoogleFonts.notoSansThai(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w400,
                              //         color: HexColor('#646464')),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              BackAccountInfomation(
                                branchImage: detailStatusModel.branchImage,
                                contractBankAccount:
                                    detailStatusModel.contractBankAccount,
                                contractBankBrandname:
                                    detailStatusModel.contractBankBrandname,
                              ),
                              TopicWidget(
                                title: 'เอกสารประกอบสัญญา',
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ButtonType(
                                NameType: 'ใบคำขอสินเชื่อ',
                                onpress: () async {
                                  await renderPdfFile(
                                      'requestDocument', 'ใบคำขอสินเชื่อ');
                                },
                              ),
                              ButtonType(
                                NameType: 'ใบรับเงิน',
                                onpress: () async {
                                  await renderPdfFile('paySlip', 'ใบรับเงิน');
                                },
                              ),
                              ButtonType(
                                NameType: 'เอกสารสัญญา',
                                onpress: () async {
                                  await renderPdfFile(
                                      'contactDocument', 'เอกสารสัญญา');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )));
  }

  getNoInternetWidget() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text('รายละเอียดการขอสินเชื่อ',
                style: TextStyle(
                        color: HexColor('#003063'),
                        fontSize: 16,
                        fontWeight: FontWeight.w600)
                    .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
            elevation: 0,
            leading: IconButton(
              onPressed: () async {
                Navigator.of(context).pushNamed('/topup-status-list');
              },
              icon: SvgPicture.asset('assets/back-icon.svg'),
            ),
          ),
          Center(child: NoInternetWidget(
            onRetry: () async {
              getFecthData();
            },
          )),
        ],
      ),
    );
  }
}
