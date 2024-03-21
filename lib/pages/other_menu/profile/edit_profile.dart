import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mobile_application_srisawad/bloc/register_bloc/register_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';
import 'package:mobile_application_srisawad/connector/firestore/register.dart';
import 'package:mobile_application_srisawad/models/subdistrict_model.dart';
import 'package:mobile_application_srisawad/widgets/fields/scroll_field.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

import '../../../modules/userProfile/index.dart';
import '../../../util/check_string_format.dart';
import '../../../widgets/fields/scroll_date_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  @override
  void initState() {
    firstnameController.text =
        context.read<UserProfileBloc>().state.userProfileData.firstName;
    lastnameController.text =
        context.read<UserProfileBloc>().state.userProfileData.lastName;
    phoneController.text =
        context.read<UserProfileBloc>().state.userProfileData.phoneNumber;
    addressController.text =
        context.read<UserProfileBloc>().state.userProfileData.addressDetails;
    provinceController.text =
        context.read<UserProfileBloc>().state.userProfileData.addressProvince;
    districtController.text =
        context.read<UserProfileBloc>().state.userProfileData.addressDistinct;
    subdistrictController.text = context
        .read<UserProfileBloc>()
        .state
        .userProfileData
        .addressSubDistrict;
    postcodeController.text =
        context.read<UserProfileBloc>().state.userProfileData.addressPostalCode;
    currentIndexAddress = 3;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData().then((value) => setLoad());
    });

    // indexProvince = provinceList.indexWhere((item) => item.name == province);

    super.initState();
  }

  Future<void> setLoad() async {
    isLoaded = true;
    setState(() {});
  }

  RegisterConnector registerConnector = new RegisterConnector();
  List<Subdistrict> subdistrictList = [];
  List<dynamic> provinceList = [];
  List<dynamic> districtList = [];
  bool isLoaded = false;

  Future<String> getData() async {
    province = await context
        .read<UserProfileBloc>()
        .state
        .userProfileData
        .addressProvince;
    district = await context
        .read<UserProfileBloc>()
        .state
        .userProfileData
        .addressDistinct;

    subdistrict = await context
        .read<UserProfileBloc>()
        .state
        .userProfileData
        .addressSubDistrict;
    context.read<RegisterBloc>().state.dob = formateBuddhistDate(
            context.read<UserProfileBloc>().state.userProfileData.dob)
        .toString();

    indexSubdistrict =
        subdistrictList.indexWhere((item) => item.name == subdistrict);
    indexDistrict = districtList.indexWhere((item) => item.name == district);

    provinceList = await registerConnector.getProvince();
    provinceList.sort();
    districtList = await registerConnector.getDistrict(province!);
    districtList.sort();
    subdistrictList = await registerConnector.getSubDistrict(district!.trim());
    subdistrictList.sort((a, b) => a.name!.compareTo(b.name!));

    convertToList();
    scrollControllerSubdistrict =
        FixedExtentScrollController(initialItem: indexSubdistrict);
    scrollControllerProvince =
        FixedExtentScrollController(initialItem: indexProvince);
    scrollControllerDistrict =
        FixedExtentScrollController(initialItem: indexDistrict);

    return '';
  }

  final _formKey = GlobalKey<FormState>();
  bool isValidated = false;
  StorageConnector storageClient = new StorageConnector();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  MaskedTextController phoneController =
      MaskedTextController(mask: '000-000-0000');
  TextEditingController dayController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController lineIdController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController subdistrictController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  String dob = '';

  String? province = '';
  String? district = '';
  String? subdistrict = '';
  String? poscode = '';
  int? currentIndexAddress = 1;
  int indexProvince = 0;
  int indexDistrict = 0;
  int indexSubdistrict = 0;
  int indexPostcode = 0;
  UserProfile userProfile = UserProfile();

  late FixedExtentScrollController scrollControllerProvince;
  late FixedExtentScrollController scrollControllerDistrict;
  late FixedExtentScrollController scrollControllerSubdistrict;
  final phoneMasking = MaskTextInputFormatter(
      mask: '###-###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  Widget phoneTextFiled() {
    return TextField(
      keyboardType: TextInputType.phone,
      controller: phoneController,
      maxLength: 12,
      decoration: InputDecoration(
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: 'XXX-XXX-XXXX',
          hintStyle: TextStyle(
              height: 2.1,
              color: HexColor('#DBDBDB'),
              fontSize: 16,
              fontWeight: FontWeight.w600),
          errorStyle: GoogleFonts.notoSansThai()
              .merge(TextStyle(color: HexColor('#A02802'))),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: HexColor('#A02802'))),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).primaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: HexColor('#E5E5E5'))),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).primaryColor)),
          label: Text(
            'เบอร์โทรศัพท์',
            style: GoogleFonts.notoSansThai(
              fontSize: 18,
              color: HexColor('#646464'),
              fontWeight: FontWeight.w400,
            ),
          )),
      inputFormatters: <TextInputFormatter>[
        phoneMasking,
        // FilteringTextInputFormatter.digitsOnly,
      ],
    );
  }

  void addAddress(int index, int address) async {
    address == 1
        ? {
            province = provinceList[index],
            districtController.clear(),
            subdistrictController.clear(),
            postcodeController.clear(),
            scrollControllerDistrict =
                FixedExtentScrollController(initialItem: 0),
            scrollControllerSubdistrict =
                FixedExtentScrollController(initialItem: 0),
            currentIndexAddress = 1,
            indexDistrict = 0,
            districtList = await registerConnector.getDistrict(province!),
            districtList.sort(),
            if (currentIndexAddress! < 2) currentIndexAddress = 2
          }
        : address == 2
            ? {
                district = districtList[index],
                subdistrictController.clear(),
                postcodeController.clear(),
                scrollControllerSubdistrict =
                    FixedExtentScrollController(initialItem: 0),
                currentIndexAddress = 2,
                indexSubdistrict = 0,
                subdistrictList =
                    await registerConnector.getSubDistrict(district!),
                subdistrictList.sort((a, b) => a.name!.compareTo(b.name!)),
                convertToList(),
                if (currentIndexAddress! < 3) currentIndexAddress = 3
              }
            : {
                subdistrict = subList[index].name,
                poscode = subdistrictList[index].zipcode,
              };
    setState(() {});
  }

  Future<void> updateData() async {
    context.read<UserProfileBloc>().add(UpdateProfile(
        id: context.read<UserProfileBloc>().state.userProfileData.thaiId,
        firstName: firstnameController.text.trim(),
        lastName: lastnameController.text.trim(),
        dob: formateChristDate(context.read<RegisterBloc>().state.dob)
            .toString(),
        phone: phoneController.text,
        address: addressController.text,
        province: provinceController.text,
        district: districtController.text,
        subdistrict: subdistrictController.text,
        postal: postcodeController.text,
        userProfile: userProfile,
        context: context));
  }

  Widget customTextfield(
      TextEditingController controller,
      String hint,
      String label,
      bool isCenter,
      TextInputType inputType,
      int max,
      int min,
      bool readOnly,
      bool enabled) {
    return TextFormField(
      keyboardType: inputType,
      readOnly: readOnly,
      enabled: enabled,
      onChanged: (value) {
        setState(() {
          isValidated = false;
        });
        if (_formKey.currentState!.validate()) {
          setState(() {
            isValidated = true;
          });
        }
      },
      maxLength: max,
      controller: controller,
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      style: Theme.of(context).textTheme.titleMedium!,
      inputFormatters: <TextInputFormatter>[
        if (label == 'นามสกุล')
          FilteringTextInputFormatter.allow(RegExp('[ก-ฮะ-์ ]')),
        if (label == 'ชื่อ')
          FilteringTextInputFormatter.allow(RegExp('[ก-ฮะ-์]')),
      ],
      decoration: InputDecoration(
          counterText: '',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: hint,
          hintStyle: TextStyle(
              height: 2.1,
              color: HexColor('#DBDBDB'),
              fontSize: 16,
              fontWeight: FontWeight.w600),
          errorStyle: TextStyle(height: 0),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).primaryColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: HexColor('#E5E5E5'))),
          errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 1, color: HexColor('#E5E5E5'))),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: Theme.of(context).primaryColor)),
          label: Text(
            label,
            style: GoogleFonts.notoSansThai(
              fontSize: 18,
              color: HexColor('#646464'),
              fontWeight: FontWeight.w400,
            ),
          )),
      validator: (value) {
        if (value == null || value.isEmpty || value.length < min) {
          return '';
        }
        return null;
      },
    );
  }

  List<dynamic> subList = [];

  void convertToList() {
    subList = subdistrictList.map((f) => f.name).toList();
  }

  void onSelected(int index, int address) {
    address == 1
        ? provinceController.text = provinceList[index]
        : address == 2
            ? districtController.text = districtList[index]
            : {
                subdistrictController.text = subdistrictList[index].name!,
                postcodeController.text = subdistrictList[index].zipcode!
              };

    addAddress(index, address);
  }

  Widget picker(String label, TextEditingController controller, int address,
      String hint, List<dynamic> list) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () async {
        address <= currentIndexAddress!
            ? ScrollField(label, list, controller, () {}, onSelected, () {},
                address, context)
            : null;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: address <= currentIndexAddress!
                      ? HexColor('#646464')
                      : address == 4 && currentIndexAddress == 3
                          ? HexColor('#646464')
                          : HexColor('#DBDBDB'))),
          TextField(
            readOnly: true,
            enabled: false,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  height: 2.1,
                  color: HexColor('#DBDBDB'),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              suffixIcon: Icon(
                Icons.arrow_forward_ios,
                size: 10,
                color: address <= currentIndexAddress!
                    ? HexColor('#646464')
                    : HexColor('#DBDBDB'),
              ),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: HexColor('#E5E5E5')
                          .withOpacity(address <= currentIndexAddress!
                              ? 1
                              : address == 4 && currentIndexAddress == 3
                                  ? 1
                                  : 0.25))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
        builder: (blocContext, state) {
      if (state is UserProfileComplete) {
        return isLoaded
            ? Form(
                key: _formKey,
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      centerTitle: true,
                      title: Text(
                        'แก้ไขข้อมูล',
                        style: GoogleFonts.notoSansThai(
                          color: HexColor('#003063'),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: SvgPicture.asset('assets/back-icon.svg'),
                      ),
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                    ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SectionTextTitle("ข้อมูลพื้นฐาน",
                                      Color(0xFFDB771A).withOpacity(0.5), 18),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  customTextfield(
                                      firstnameController,
                                      'ระบุชื่อ (ภาษาไทย)',
                                      'ชื่อ',
                                      false,
                                      TextInputType.name,
                                      20,
                                      1,
                                      false,
                                      true),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  customTextfield(
                                      lastnameController,
                                      'ระบุนามสกุล (ภาษาไทย)',
                                      'นามสกุล',
                                      false,
                                      TextInputType.name,
                                      44,
                                      1,
                                      false,
                                      true),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  phoneTextFiled(),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text(
                                    'วัน เดือน ปีเกิด (พ.ศ.)',
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 14,
                                      color: HexColor('#646464'),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  BlocBuilder<RegisterBloc, RegisterState>(
                                      builder: (context, state) {
                                    return GestureDetector(
                                      onTap: () {
                                        print(state.dob);

                                        ScrollDateField(
                                            DateTime.parse(state.dob), context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.1,
                                                      color: state.dob.isEmpty
                                                          ? HexColor('#DBDBDB')
                                                          : HexColor(
                                                              '#003063')),
                                                ),
                                              ),
                                              child: Text(
                                                state.dob.isEmpty
                                                    ? 'วว'
                                                    : state.dob
                                                        .substring(8, 10),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: state.dob.isEmpty
                                                            ? HexColor(
                                                                '#DBDBDB')
                                                            : HexColor(
                                                                '#003063')),
                                                textAlign: TextAlign.center,
                                              )),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            '/',
                                            style: GoogleFonts.notoSansThai(
                                              fontSize: 16,
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.1,
                                                      color: state.dob.isEmpty
                                                          ? HexColor('#DBDBDB')
                                                          : HexColor(
                                                              '#003063')),
                                                ),
                                              ),
                                              child: Text(
                                                state.dob.isEmpty
                                                    ? 'ดด'
                                                    : state.dob.substring(5, 7),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: state.dob.isEmpty
                                                            ? HexColor(
                                                                '#DBDBDB')
                                                            : HexColor(
                                                                '#003063')),
                                                textAlign: TextAlign.center,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '/',
                                            style: GoogleFonts.notoSansThai(
                                              fontSize: 16,
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      width: 0.1,
                                                      color: state.dob.isEmpty
                                                          ? HexColor('#DBDBDB')
                                                          : HexColor(
                                                              '#003063')),
                                                ),
                                              ),
                                              child: Text(
                                                state.dob.isEmpty
                                                    ? 'ปป'
                                                    : state.dob
                                                        .toString()
                                                        .substring(0, 4),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                        color: state.dob.isEmpty
                                                            ? HexColor(
                                                                '#DBDBDB')
                                                            : HexColor(
                                                                '#003063')),
                                                textAlign: TextAlign.center,
                                              )),
                                        ],
                                      ),
                                    );
                                    //}
                                    // else {
                                    //   return SizedBox();
                                    // }
                                  }),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  TextFormField(
                                    initialValue: formatThaiID(
                                        state.userProfileData.thaiId),
                                    readOnly: true,
                                    enabled: false,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: HexColor('#003063')
                                                .withOpacity(0.5)),
                                    decoration: InputDecoration(
                                        label: Text(
                                      'หมายเลขบัตรประชาชน',
                                      style: GoogleFonts.notoSansThai(
                                        fontSize: 14,
                                        color: HexColor('#646464'),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )),
                                  ),
                                  SizedBox(
                                    height: 28,
                                  ),
                                  SectionTextTitle("ข้อมูลที่อยู่",
                                      Color(0xFFDB771A).withOpacity(0.5), 18),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  customTextfield(
                                      addressController,
                                      'ระบุรายละเอียดที่อยู่ปัจจุบัน',
                                      'รายละเอียดที่อยู่ปัจจุบัน',
                                      false,
                                      TextInputType.name,
                                      100,
                                      1,
                                      false,
                                      true),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  picker('จังหวัด', provinceController, 1,
                                      'เลือกจังหวัด', provinceList),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  picker('เขต/อำเภอ', districtController, 2,
                                      'เลือกเขต/อำเภอ', districtList),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  picker('แขวง/ตำบล', subdistrictController, 3,
                                      'เลือกแขวง/ตำบล', subList),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  picker('รหัสไปรษณีย์', postcodeController, 4,
                                      'เลือกรหัสไปรษณีย์', subdistrictList),
                                  SizedBox(
                                    height: 140,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat,
                    floatingActionButton: Container(
                      height: 80,
                      margin: const EdgeInsets.all(20),
                      child: TextButton(
                          onPressed: () async {
                            otpCallbackFunction() async {
                              await updateData();
                              Navigator.pushNamed(
                                context,
                                '/settings/profile',
                              );
                            }

                            Navigator.pushNamed(context, '/otp-page',
                                arguments: {
                                  'callbackFunction': otpCallbackFunction,
                                  'phoneNumber':
                                      phoneController.text.replaceAll('-', ''),
                                });
                          },
                          child: Center(
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width * 0.9,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  color: HexColor('#DB771A'),
                                  borderRadius: BorderRadius.circular(14)),
                              child: Center(
                                child: Text('บันทึก',
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                          )),
                    )))
            : Center(
                child: CircularProgressIndicator(
                  color: Color.fromRGBO(219, 119, 26, 1),
                ),
              );
      }
      return Center(
        child: CircularProgressIndicator(
          color: Color.fromRGBO(219, 119, 26, 1),
        ),
      );
    });
  }
}
