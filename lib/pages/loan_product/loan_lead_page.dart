import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/models/loan_lead/loan_lead_save_product_data_request_model.dart';
import 'package:mobile_application_srisawad/models/loan_product/loan_product_detail_model.dart';
import 'package:mobile_application_srisawad/models/user_profile_data.dart';
import 'package:mobile_application_srisawad/pages/loan_product/loan_product_detail_page.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/util/color_util.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

import '../../bloc/loan_lead_bloc/loan_lead_bloc.dart';
import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../models/loan_lead/loan_lead_save_product_request_model.dart';
import '../../modules/loanproduct/loan_product_repository.dart';
import '../../modules/userProfile/index.dart';
import '../../services/localStorage/notify_storage.dart';
import '../../widgets/bottompage.dart';
import '../../widgets/dialog/product_picker_dialog.dart';
import '../../widgets/lead_button.dart';

class LoanLeadPage extends StatefulWidget {
  const LoanLeadPage({Key? key, required this.productDetail}) : super(key: key);
  final LoanProductDetailModel productDetail;

  @override
  State<LoanLeadPage> createState() => _LoanLeadPageState();
}

class _LoanLeadPageState extends State<LoanLeadPage> {
  LoanProductRepository repository = LoanProductRepository();
  UserProfile userProfile = UserProfile();
  final CurrencyTextInputFormatter _creditLimitFormatter =
      CurrencyTextInputFormatter(symbol: '', decimalDigits: 0);
  TextEditingController expectedDateController = TextEditingController();
  TextEditingController availableTimeToContractController =
      TextEditingController();
  UserProfileData? userProfileData;
  int? selectedCustomerAvailablePeriodIndex = null;
  int? selectedAvailableTimeToContractIndex = null;
  bool isEnableLeadButton = false;
  bool? selectedLoanStatus;
  bool isSelectEndLoanStatus = false;
  bool isSelectContinueLoanStatus = false;
  List<String> expectedDateList = [
    "ภายในวันนี้หรือด่วนที่สุด",
    "ภายในสัปดาห์นี้",
    "ภายในเดือนนี้",
    "ยังไม่ระบุ",
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
    expectedDateController.dispose();
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
            body: Column(children: [
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
                      MainTitle("สนใจขอสินเชื่อ").styleSecondary(),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
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
                          TextTitle(userProfileState.userProfileData.firstName)
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
                          TextTitle(userProfileState.userProfileData.phoneNumber
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
                          Body("ประเภทสินทรัพย์").styleSecondary(),
                          SizedBox(
                            height: 6,
                          ),
                          TextTitle(widget.productDetail.top?.title ?? "")
                              .styleSecondary(),
                          SizedBox(
                            height: 14,
                          ),
                          Body("สถานะการผ่อน").styleSecondary(),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoanStatusBoxWidget(
                                  text: "ผ่อนหมดแล้ว",
                                  isSelected: isSelectEndLoanStatus,
                                  onSelected: () {
                                    selectLoanEndLoanStatus();
                                  }),
                              SizedBox(
                                width: 8,
                              ),
                              LoanStatusBoxWidget(
                                text: "ผ่อนยังไม่หมด",
                                isSelected: isSelectContinueLoanStatus,
                                onSelected: () {
                                  selectLoanContinueStatus();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Body("วงเงินสินเชื่อที่ต้องการ").styleSecondary(),
                          SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            maxLength: 18,
                            autofocus: false,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.notoSansThai(
                              color: HexColor('#003063'),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              hintStyle: GoogleFonts.notoSansThai(
                                color: HexColor('#003063'),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                              hintText: "0",
                              suffix: Largetitle("บาท").styleSecondary(),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: HexColor('#E5E5E5')),
                              ),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              _creditLimitFormatter
                            ],
                            onChanged: (value) {
                              checkIsEnableButton();
                            },
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Body("ระยะเวลาที่ต้องการเงิน").styleSecondary(),
                          SizedBox(
                            height: 2,
                          ),
                          InkWell(
                            onTap: () {
                              showPickerDialog(
                                  context: context,
                                  title: "เลือกระยะเวลาที่ต้องการ",
                                  dataList: expectedDateList,
                                  initialIndex:
                                      selectedCustomerAvailablePeriodIndex,
                                  onSelectedListener: (index) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());

                                    selectedCustomerAvailablePeriodIndex =
                                        index;
                                    expectedDateController.text =
                                        expectedDateList[index];
                                    checkIsEnableButton();
                                  });
                            },
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                TextField(
                                  showCursor: true,
                                  enabled: false,
                                  controller: expectedDateController,
                                  style: GoogleFonts.notoSansThai(
                                    color: HexColor("#003063"),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  decoration: InputDecoration(
                                    hintStyle: GoogleFonts.notoSansThai(
                                      color: HexColor('#DBDBDB'),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    labelStyle: GoogleFonts.notoSansThai(
                                      color: HexColor('#DBDBDB'),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: HexColor('#E5E5E5')),
                                    ),
                                    hintText: "ระบุระยะเวลาที่ต้องการเงิน",
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
                                  controller: availableTimeToContractController,
                                  decoration: InputDecoration(
                                    hintStyle: GoogleFonts.notoSansThai(
                                      color: HexColor('#DBDBDB'),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1, color: HexColor('#E5E5E5')),
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
                        ]),
                  ),
                ),
              ),
            ]),
            bottomNavigationBar: BottomAppBar(
                color: Colors.white,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 22.0, right: 22.0, bottom: 22),
                  child: LeadButton(
                    backgroundColor: "DB771A",
                    isEnable: isEnableLeadButton,
                    text: 'ส่งข้อมูล',
                    buttonCallBack: () {
                      context.read<LoanLeadBloc>().add(SaveLoanLeadEvent(
                          repository: repository,
                          context: context,
                          request: LoanLeadSaveProductRequestModel(
                              hashThaiId,
                              widget.productDetail.productType ?? "",
                              LoanLeadSaveProductDataRequestModel(
                                  name: userProfileData?.firstName ?? "",
                                  surname: userProfileData?.lastName ?? "",
                                  phoneNumber:
                                      userProfileData?.phoneNumber ?? "",
                                  assetType:
                                      widget.productDetail.top?.title ?? "",
                                  installmentStatus:
                                      getSelectedInstallmentStatus(),
                                  creditLimit: _creditLimitFormatter
                                      .getUnformattedValue()
                                      .toString(),
                                  expectedDate: expectedDateController.text,
                                  availableTimeToContract:
                                      availableTimeToContractController
                                          .text))));
                    },
                  ),
                )),
          );
        } else {
          return Container();
        }
      },
    );
  }

  checkIsEnableButton() {
    setState(() {
      if (_creditLimitFormatter.getUnformattedValue() > 0 &&
          expectedDateController.text.isNotEmpty &&
          availableTimeToContractController.text.isNotEmpty &&
          (isSelectContinueLoanStatus || isSelectEndLoanStatus)) {
        isEnableLeadButton = true;
      } else {
        isEnableLeadButton = false;
      }
    });
  }

  void selectLoanEndLoanStatus() {
    if (isSelectEndLoanStatus != true) {
      setState(() {
        isSelectEndLoanStatus = !isSelectEndLoanStatus;
        isSelectContinueLoanStatus = false;
      });
      checkIsEnableButton();
    }
  }

  void selectLoanContinueStatus() {
    if (isSelectContinueLoanStatus != true) {
      setState(() {
        isSelectContinueLoanStatus = !isSelectContinueLoanStatus;
        isSelectEndLoanStatus = false;
      });
      checkIsEnableButton();
    }
  }

  String getSelectedInstallmentStatus() {
    if (isSelectEndLoanStatus) return "ผ่อนหมดแล้ว";
    if (isSelectContinueLoanStatus) return "ผ่อนยังไม่หมด";
    return "";
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
                    MainTitle("สนใจขอสินเชื่อ").styleSecondary(),
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
}

class LoanStatusBoxWidget extends StatelessWidget {
  const LoanStatusBoxWidget({
    required this.text,
    this.isSelected,
    required this.onSelected,
    super.key,
  });

  final bool? isSelected;
  final String text;
  final Function onSelected;

  BoxDecoration getBoxDecoration() {
    if (isSelected == null || isSelected == false) {
      return BoxDecoration(
          border: Border.all(color: HexColor("E5E5E5"), width: 1),
          color: HexColor("FFFFFF"),
          borderRadius: BorderRadius.circular(14));
    } else {
      return BoxDecoration(
          border: Border.all(color: HexColor(ColorUtil.PRIMARY), width: 2),
          color: HexColor("FCEFE4"),
          borderRadius: BorderRadius.circular(14));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onSelected.call();
        },
        child: Container(
          alignment: Alignment.center,
          child: Subtitle1(text).styleSecondary(),
          padding: EdgeInsets.all(13),
          decoration: getBoxDecoration(),
        ),
      ),
    );
  }
}
