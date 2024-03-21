import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

import '../../bloc/insurance_lead_bloc/insurance_lead_bloc.dart';
import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../main.dart';
import '../../models/insurance_lead/insurance_lead_save_product_data_request_model.dart';
import '../../models/insurance_lead/insurance_lead_save_product_request_model.dart';
import '../../models/insurance_product/insurance_product_detail_model.dart';
import '../../models/user_profile_data.dart';
import '../../modules/insurance_product/insurance_product_repository.dart';
import '../../modules/userProfile/index.dart';
import '../../services/localStorage/notify_storage.dart';
import '../../widgets/bottompage.dart';
import '../../widgets/dialog/product_picker_dialog.dart';
import '../../widgets/lead_button.dart';
import 'insurance_product_detail_page.dart';

class InsuranceLeadPage extends StatefulWidget {
  const InsuranceLeadPage({Key? key, required this.productDetail})
      : super(key: key);
  final InsuranceProductDetailModel productDetail;

  @override
  State<InsuranceLeadPage> createState() => _InsuranceLeadPageState();
}

class _InsuranceLeadPageState extends State<InsuranceLeadPage> {
  InsuranceProductRepository repository = InsuranceProductRepository();
  UserProfile userProfile = UserProfile();
  TextEditingController insuranceClassController = TextEditingController();
  TextEditingController availableTimeToContractController =
      TextEditingController();
  UserProfileData? userProfileData;
  int? selectedInsuranceClassIndex = null;
  int? selectedAvailableTimeToContractIndex = null;
  bool isEnableLeadButton = false;
  List<String> insuranceClassList = [
    "1",
    "2+",
    "3+",
    "3",
  ];

  List<String> availableTimeToContractList = [
    "8.30 - 12.00 น.",
    "12.01 - 13.00 น.",
    "13.01 - 17.30 น.",
  ];

  @override
  void initState() {
    _getUserData(
      context,
      userProfile,
    );
    super.initState();
  }

  Future _getUserData(BuildContext context, UserProfile userProfile) async {
    context
        .read<UserProfileBloc>()
        .add(GetUserProFileData(userProfile, hashThaiId, context));
  }

  @override
  void dispose() {
    insuranceClassController.dispose();
    availableTimeToContractController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, userProfileState) {
        if (userProfileState is UserProfileLoading) {
          return getLoadingLayout();
        } else if (userProfileState is UserProfileComplete) {
          userProfileData = userProfileState.userProfileData;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          padding: EdgeInsets.only(left: 0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: SvgPicture.asset(
                            'assets/back-icon.svg',
                            height: 38,
                            width: 38,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        MainTitle("สนใจทำประกัน").styleSecondary(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 14,
                            ),
                            Body("ชื่อ").styleSecondary(),
                            SizedBox(
                              height: 6,
                            ),
                            TextTitle(
                                    userProfileState.userProfileData.firstName)
                                .styleSecondary(),
                            SizedBox(
                              height: 14,
                            ),
                            Body("นามสกุล").styleSecondary(),
                            SizedBox(
                              height: 6,
                            ),
                            TextTitle(userProfileState.userProfileData.lastName)
                                .styleSecondary(),
                            SizedBox(
                              height: 14,
                            ),
                            Body("เบอร์โทรศัพท์").styleSecondary(),
                            SizedBox(
                              height: 6,
                            ),
                            TextTitle(userProfileState
                                    .userProfileData.phoneNumber
                                    .formatPhoneNumber())
                                .styleSecondary(),
                            SizedBox(
                              height: 17,
                            ),
                            SectionTextTitle("กรอกข้อมูลเพิ่มเติม",
                                Color(0xFFDB771A).withOpacity(0.5), 18),
                            SizedBox(
                              height: 14,
                            ),
                            Body("ประเภทประกันรถ").styleSecondary(),
                            SizedBox(
                              height: 6,
                            ),
                            TextTitle(
                                    widget.productDetail.insuranceTop?.title ??
                                        "")
                                .styleSecondary(),
                            SizedBox(
                              height: 14,
                            ),
                            Body("ชั้นประกันที่สนใจ").styleSecondary(),
                            SizedBox(
                              height: 2,
                            ),
                            InkWell(
                              onTap: () {
                                showPickerDialog(
                                    context: context,
                                    title: "เลือกชั้นประกันที่สนใจ",
                                    dataList: insuranceClassList,
                                    initialIndex: selectedInsuranceClassIndex,
                                    onSelectedListener: (index) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      selectedInsuranceClassIndex = index;
                                      insuranceClassController.text =
                                          insuranceClassList[index];
                                      checkIsEnableButton();
                                    });
                              },
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextFormField(
                                    showCursor: true,
                                    enabled: false,
                                    controller: insuranceClassController,
                                    decoration: InputDecoration(
                                      hintStyle: GoogleFonts.notoSansThai(
                                        color: HexColor('#DBDBDB'),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      hintText: "เลือกชั้นประกันที่สนใจ",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 17),
                                    child: SvgPicture.asset(
                                      'assets/CaretRight.svg',
                                      height: 10,
                                      width: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Body("เวลาที่สะดวกให้ติดต่อ").styleSecondary(),
                            InkWell(
                              onTap: () {
                                showPickerDialog(
                                    context: context,
                                    title: "เลือกเวลาที่สะดวกให้ติดต่อ",
                                    dataList: availableTimeToContractList,
                                    initialIndex:
                                        selectedAvailableTimeToContractIndex,
                                    onSelectedListener: (index) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      selectedAvailableTimeToContractIndex =
                                          index;
                                      availableTimeToContractController.text =
                                          availableTimeToContractList[index];
                                      checkIsEnableButton();
                                    });
                              },
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  TextFormField(
                                    showCursor: true,
                                    enabled: false,
                                    controller:
                                        availableTimeToContractController,
                                    decoration: InputDecoration(
                                      hintStyle: GoogleFonts.notoSansThai(
                                        color: HexColor('#DBDBDB'),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      hintText: "ระบุเวลาที่สะดวกให้ติดต่อ",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 17),
                                    child: SvgPicture.asset(
                                      'assets/CaretRight.svg',
                                      height: 10,
                                      width: 5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ])),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              color: Colors.white,
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 22.0, right: 22.0, bottom: 22),
                child: LeadButton(
                  backgroundColor: "DB771A",
                  isEnable: isEnableLeadButton,
                  text: 'ส่งข้อมูล',
                  buttonCallBack: () {
                    context
                        .read<InsuranceLeadBloc>()
                        .add(SaveInsuranceLeadEvent(
                            repository: repository,
                            context: context,
                            request: InsuranceLeadSaveProductRequestModel(
                                hashThaiId,
                                widget.productDetail.productType ?? "",
                                InsuranceLeadSaveProductDataRequestModel(
                                  name: userProfileData?.firstName ?? "",
                                  surname: userProfileData?.lastName ?? "",
                                  assetType: widget
                                          .productDetail.insuranceTop?.title ??
                                      "",
                                  phoneNumber:
                                      userProfileData?.phoneNumber ?? "",
                                  insuranceType: widget
                                          .productDetail.insuranceTop?.title ??
                                      "",
                                  insuranceClass: insuranceClassController.text,
                                  availableTimeToContract:
                                      availableTimeToContractController.text,
                                ))));
                  },
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget getLoadingLayout() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(left: 0),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: SvgPicture.asset(
                        'assets/back-icon.svg',
                        height: 38,
                        width: 38,
                      ),
                    ),
                    MainTitle("สนใจทำประกัน").styleSecondary(),
                  ],
                ),
              ),
              Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                color: Color.fromRGBO(219, 119, 26, 1),
              )))
            ]),
      ),
    );
  }

  checkIsEnableButton() {
    setState(() {
      if (insuranceClassController.text.isNotEmpty &&
          availableTimeToContractController.text.isNotEmpty) {
        isEnableLeadButton = true;
      } else {
        isEnableLeadButton = false;
      }
    });
  }
}
