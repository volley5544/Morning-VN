import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/widgets/image_selector.dart';
import 'package:mime/mime.dart';

import '../../main.dart';
import '../../models/loan_detail.dart';
import '../../models/topup_data.dart';
import '../../models/topup_installment_number.dart';
import '../../util/check_string_format.dart';
import '../../util/logger_service.dart';
import '../../util/width_until.dart';
import '../../widgets/loan_widgets/bootom_button.dart';
import '../loan_installment/loan_installment_payment_detail.dart';
import 'topup_styling.dart';
import 'topup_widgets/upload_vehicle_image.dart';

class TopupExtendsTax extends StatefulWidget {
  final TopupConclusion topupConclusion;
  const TopupExtendsTax({
    Key? key,
    required this.topupConclusion,
  }) : super(key: key);

  @override
  State<TopupExtendsTax> createState() => _TopupExtendsTaxState();
}

class _TopupExtendsTaxState extends State<TopupExtendsTax> {
  File? _vehicle;
  File? _circleTag;
  late bool inactiveNextButton = true;
  final ImagePicker _picker = ImagePicker();
  late OverlayEntry overlayEntry;
  late Offset indicatorOffset;
  static const configKey = [
    {'label': 'ทะเบียนจังหวัด', 'valueField': 'collateral_information'},
    {'label': 'วันหมดอายุทะเบียน', 'valueField': 'license_plate_expire_date'},
    {'label': 'ยี่ห้อสินค้า', 'valueField': 'vehicle_brand'},
    {'label': 'รุ่นสินค้า', 'valueField': 'amount_per_installment'},
  ];

  Map<String, dynamic> setModelEncode(TopupData topupData) {
    return {
      'collateral_information': topupData.contractDetails.licensePlateProvince,
      'license_plate_expire_date':
          formateBudDate(topupData.contractDetails.licensePlateExpireDate),
      'amount_per_installment': topupData.carDetails.carSeries,
      'vehicle_brand': topupData.carDetails.carBrand,
    };
  }

  Widget rederTopupProperty(Map<String, String> key, TopupState state) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${key['label']}',
                  style: size14WNormal
                      .merge(TextStyle(color: HexColor('#404040')))),
              Text('${setModelEncode(state.topupData)[key['valueField']]}',
                  style: size16WNormal.merge(TextStyle(
                      fontWeight: FontWeight.w600, color: HexColor('#404040'))))
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

  Future<void> imgFromCamera(String imageType) async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera, imageQuality: 75, maxWidth: 1080);
    // if (pickedFile != null) {
    //   final File imageFile = File(pickedFile.path);
    //   final int fileSizeInBytes = await imageFile.length();
    //   final double fileSizeInKB = fileSizeInBytes / 1024;
    //   print('File size: ${fileSizeInKB.toStringAsFixed(2)} KB');
    // }
    setState(() {
      if (pickedFile != null) {
        if (imageType == 'vehical') {
          _vehicle = File(pickedFile.path);
        }
        if (imageType == 'circleTag') {
          _circleTag = File(pickedFile.path);
        }
      } else {
        logger.i('no image');
      }
    });
  }

  void setImageNull(String imageType) {
    if (imageType == 'vehical') {
      setState(() {
        _vehicle = null;
      });
    }
    if (imageType == 'circleTag') {
      setState(() {
        _circleTag = null;
      });
    }
  }

  // TODO get image width to render cross icon
  Widget renderPickedImage(String imageType, File? photo) {
    if (photo != null) {
      return Center(
        child: Stack(
          children: [
            Container(
              height: 203,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      File(photo.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 0,
                right: 10,
                child: GestureDetector(
                  onTap: () => setImageNull(imageType),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: SvgPicture.asset(
                      'assets/BlackClearIcon.svg',
                    ),
                  ),
                )),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: widthAdjuster(screenWidth: MediaQuery.of(context).size.width),
        child: UploadVehicleImage(
          onButtonTap: () {
            _showPicker(imageType);
          },
        ),
      );
    }
  }

  Future<void> imgFromGallery(String imageType) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        if (imageType == 'vehical') {
          _vehicle = File(pickedFile.path);
        }
        if (imageType == 'circleTag') {
          _circleTag = File(pickedFile.path);
        }
      } else {
        logger.i('no image');
      }
    });
  }

  String converImageToString(File file) {
    List<int> imageBytes = file.readAsBytesSync();
    final lookupType = lookupMimeType(file.path);
    String base64Image = base64Encode(imageBytes);
    return 'data:$lookupType;base64,$base64Image';
    ;
  }

  void _showPicker(String imageType) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        context: context,
        builder: (BuildContext bc) {
          return ImageSelector(
            imgFromCamera: (e) async {
              Navigator.pop(context);
              await imgFromCamera(imageType);
            },
          );
        });
  }

  void nagivateToTopupCheckInfomation(LoanDetail loanDetail) {
    navKey.currentState!.pushNamed('/top-up-check-infomation',
        arguments: TopupConclusion(
            loanDetail: loanDetail,
            selectedInstallmentNumber:
                widget.topupConclusion.selectedInstallmentNumber,
            isComeFromConclusionNext:
                widget.topupConclusion.isComeFromConclusionNext,
            appbarTitle: widget.topupConclusion.appbarTitle,
            loanTotalBalanceAmount:
                widget.topupConclusion.loanTotalBalanceAmount,
            vehicleImage: converImageToString(_vehicle!),
            vehicleTag: converImageToString(_circleTag!),
            topupInstallmentNumber:
                widget.topupConclusion.topupInstallmentNumber,
            actualAmount: widget.topupConclusion.actualAmount,
            topupDataConclusion: widget.topupConclusion.topupDataConclusion,
            insuranceAmt: widget.topupConclusion.insuranceAmt));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('ข้อมูลการต่อภาษี',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
        backgroundColor: HexColor('#FFFFFF'),
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
      body: BlocBuilder<TopupBloc, TopupState>(
        builder: (context, state) {
          if (state is TopupError) {
            return Container();
          }
          if (state is TopupComplete) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: LoanInstallPaymentDetail(
                                subTitle: 'ข้อมูลหลักประกัน',
                                contractCreateDate: widget
                                    .topupConclusion
                                    .loanDetail
                                    .contractDetails
                                    .collateralInformation,
                                contractName: widget.topupConclusion.loanDetail
                                    .contractDetails.loanTypeName,
                                contractNo: widget
                                    .topupConclusion.loanDetail.contractNo,
                                loanTypeIcon: widget.topupConclusion.loanDetail
                                    .contractDetails.loanTypeIcon,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: HexColor('#FFFFFF'),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.16),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Wrap(
                                  children: [
                                    ...(configKey.map((element) =>
                                        rederTopupProperty(element, state))),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 24, left: 24, bottom: 8),
                                      child: Text(
                                        'กรุณาอัปโหลดรูปภาพรถยนต์*',
                                        style: size14WNormal.merge(TextStyle(
                                            color: HexColor("#646464"))),
                                      ),
                                    ),
                                    renderPickedImage('vehical', _vehicle),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 24, left: 24, bottom: 8),
                                      child: Text(
                                          'กรุณาอัปโหลดรูปภาพป้ายวงกลม*',
                                          style: size14WNormal.merge(TextStyle(
                                              color: HexColor("#646464")))),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: renderPickedImage(
                                          'circleTag', _circleTag),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BootomButton(
                  isOpacity:
                      (_vehicle != null && _circleTag != null) ? false : true,
                  onButtonTap: (_vehicle != null && _circleTag != null)
                      ? () => nagivateToTopupCheckInfomation(
                          widget.topupConclusion.loanDetail)
                      : () {},
                  title: 'ยืนยัน',
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
