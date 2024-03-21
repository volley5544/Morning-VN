import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/register_bloc/register_bloc.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';
import 'package:mobile_application_srisawad/connector/firestore/register.dart';
import 'package:mobile_application_srisawad/models/subdistrict_model.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';

import '../../util/check_validate.dart';
import '../../widgets/fields/profile_fields.dart';
import '../../widgets/fields/scroll_date_field.dart';
import '../../widgets/fields/scroll_field.dart';

class RegisterProfile extends StatefulWidget {
  const RegisterProfile({Key? key}) : super(key: key);

  @override
  State<RegisterProfile> createState() => _RegisterProfile();
}

class _RegisterProfile extends State<RegisterProfile> {
  @override
  void initState() {
    scrollControllerProvince =
        FixedExtentScrollController(initialItem: indexProvince);
    scrollControllerDistrict =
        FixedExtentScrollController(initialItem: indexDistrict);
    scrollControllerSubdistrict =
        FixedExtentScrollController(initialItem: indexSubdistrict);
    context.read<RegisterBloc>().state.dob = '';

    super.initState();
  }

  RegisterConnector registerConnector = new RegisterConnector();
  List<Subdistrict> subdistrictList = [];
  List<dynamic> provinceList = [];
  List<dynamic> districtList = [];

  Future<String> getProvince() async {
    provinceList = await registerConnector.getProvince();
    provinceList.sort();
    return '';
  }

  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormState>();
  bool isRegisterLoading = false;
  bool isValidated = false;
  StorageConnector storageClient = new StorageConnector();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
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
  //int index = 0;
  int indexProvince = 0;
  int indexDistrict = 0;
  int indexSubdistrict = 0;
  int indexPostcode = 0;
  int indexDay = 0;
  int indexMonth = 0;
  int indexYear = 0;

  late FixedExtentScrollController scrollControllerProvince;
  late FixedExtentScrollController scrollControllerDistrict;
  late FixedExtentScrollController scrollControllerSubdistrict;
  late FixedExtentScrollController scrollControllerDay;
  late FixedExtentScrollController scrollControllerMonth;
  late FixedExtentScrollController scrollControllerYear;

  void addAddress(int index, int address) async {
    setState(() {});
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
            : address == 3
                ? {
                    subdistrict = subdistrictList[index].name,
                    poscode = subdistrictList[index].zipcode,
                  }
                : {};

    if (_formKey.currentState!.validate() &&
        poscode!.isNotEmpty &&
        context.read<RegisterBloc>().state.dob.isNotEmpty) {
      isValidated = true;
    } else {
      isValidated = false;
    }
  }

  void check() {
    isValidated = firstnameController.text.isNotEmpty
        ? lastnameController.text.isNotEmpty
            ? addressController.text.isNotEmpty
                ? poscode!.isNotEmpty
                    ? context.read<RegisterBloc>().state.dob.isNotEmpty
                        ? true
                        : false
                    : false
                : false
            : false
        : false;
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
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      style: Theme.of(context).textTheme.titleMedium!,
      inputFormatters: [
        if (label == 'นามสกุล')
          FilteringTextInputFormatter.allow(RegExp('[ก-ฮะ-์ ]')),
        if (label == 'ชื่อ')
          FilteringTextInputFormatter.allow(RegExp('[ก-ฮะ-์]')),
        // if (label == 'ชื่อ')
        //   FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s")),
        if (label == 'ไลน์ไอดี (LINE ID)')
          FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z-._]")),
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

  Widget emailTextfield(TextEditingController controller, String hint,
      String label, bool isCenter, TextInputType inputType, int max, int min) {
    return TextFormField(
      keyboardType: inputType,
      maxLength: max,
      controller: controller,
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      style: Theme.of(context).textTheme.titleMedium!,
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
      validator: (input) => isEmailValid(input!)
          ? null
          : "กรุณาใส่อีเมลให้ถูกต้อง (เช่น srisawad@example.com)",
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
      onPressed: () {
        address <= currentIndexAddress! && label != 'รหัสไปรษณีย์'
            ? ScrollField(label, list, controller, () {
                // controller.clear();
                // Navigator.of(context, rootNavigator: true).pop(_showDialog);
              }, onSelected, () {}, address, context)
            // ? _showDialog(bottomSelect(hint, controller, address, list))
            : null;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: address <= currentIndexAddress!
                      ? HexColor('#646464')
                      : HexColor('#DBDBDB'))),
          TextFormField(
            readOnly: true,
            enabled: false,
            controller: controller,
            textAlign: address < 5 ? TextAlign.start : TextAlign.center,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                  height: 2.1,
                  color: HexColor('#DBDBDB'),
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
              suffixIcon: address < 4
                  ? Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: address <= currentIndexAddress!
                          ? HexColor('#646464')
                          : HexColor('#DBDBDB'),
                    )
                  : null,
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: HexColor('#E5E5E5')
                          .withOpacity(address <= currentIndexAddress!
                              ? 1
                              : address > 4
                                  ? 1
                                  : 0.25))),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
        builder: (blocContext, state) {
      return FutureBuilder(
          future: getProvince(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'สมัครสมาชิก',
                    style: GoogleFonts.notoSansThai(
                      color: HexColor('#003063'),
                      fontSize: 24,
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
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  if (state is RegisterLoading) {
                                    return Flexible(
                                        flex: 1,
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          color:
                                              Color.fromRGBO(219, 119, 26, 1),
                                        )));
                                  }
                                  if (state is RegisterComplete) {
                                    return TextFormField(
                                      initialValue: state.thaiId,
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
                                    );
                                  }
                                  return Text("un impleneted");
                                },
                              ),
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  check();
                                  if (state is RegisterComplete) {
                                    return TextFormField(
                                      initialValue: state.phoneNumber,
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
                                        'เบอร์โทรศัพท์มือถือ',
                                        style: GoogleFonts.notoSansThai(
                                          fontSize: 14,
                                          color: HexColor('#646464'),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )),
                                    );
                                  }
                                  return Text("un impleneted");
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'กรุณากรอกข้อมูลเพิ่มเติม',
                                style: GoogleFonts.notoSansThai(
                                  fontSize: 18,
                                  color: HexColor('#003063'),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SectionTextTitle(
                                  "ข้อมูลพื้นฐาน",
                                  Color.fromRGBO(219, 119, 26, 1)
                                      .withOpacity(0.5),
                                  18),
                              Form(
                                key: _formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                        height: 12,
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
                                        height: 14,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          print(state.dob);
                                          ScrollDateField(
                                              state.dob.isNotEmpty
                                                  ? DateTime.parse(state.dob)
                                                  : DateTime(
                                                      DateTime.now().year + 543,
                                                      DateTime.now().month,
                                                      DateTime.now().day,
                                                    ),
                                              context);
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
                                                        color: HexColor(
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
                                                          color: state
                                                                  .dob.isEmpty
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
                                                        color: HexColor(
                                                            '#003063')),
                                                  ),
                                                ),
                                                child: Text(
                                                  state.dob.isEmpty
                                                      ? 'ดด'
                                                      : state.dob
                                                          .substring(5, 7),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium!
                                                      .copyWith(
                                                          color: state
                                                                  .dob.isEmpty
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
                                                        color: HexColor(
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
                                                          color: state
                                                                  .dob.isEmpty
                                                              ? HexColor(
                                                                  '#DBDBDB')
                                                              : HexColor(
                                                                  '#003063')),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      SectionTextTitle(
                                          "ข้อมูลที่อยู่",
                                          Color(0xFFDB771A).withOpacity(0.5),
                                          18),
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
                                      picker('แขวง/ตำบล', subdistrictController,
                                          3, 'เลือกแขวง/ตำบล', subList),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      picker(
                                          'รหัสไปรษณีย์',
                                          postcodeController,
                                          4,
                                          'เลือกรหัสไปรษณีย์',
                                          subdistrictList),
                                    ]),
                              ),
                              SizedBox(
                                height: 28,
                              ),
                              SectionTextTitle("ข้อมูลติดต่ออื่นๆ",
                                  Color(0xFFDB771A).withOpacity(0.5), 18),
                              SizedBox(
                                height: 14,
                              ),
                              Form(
                                key: _emailKey,
                                child: emailTextfield(
                                    emailController,
                                    'ระบุอีเมล',
                                    'อีเมล',
                                    false,
                                    TextInputType.emailAddress,
                                    255,
                                    1),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              customTextfield(
                                  lineIdController,
                                  'ระบุไลน์ไอดี',
                                  'ไลน์ไอดี (LINE ID)',
                                  false,
                                  TextInputType.emailAddress,
                                  20,
                                  1,
                                  false,
                                  true),
                              SizedBox(
                                height: 22,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    print(state.dob);
                                    if (state.dob.isNotEmpty) if (_formKey
                                        .currentState!
                                        .validate()) {
                                      if (_emailKey.currentState!.validate()) {
                                        context.read<RegisterBloc>().add(
                                            GetDataFromField(
                                                state.thaiId,
                                                state.phoneNumber,
                                                firstnameController.text.trim(),
                                                lastnameController.text.trim(),
                                                state.dob.toString(),
                                                addressController.text.trim(),
                                                province!,
                                                district!,
                                                subdistrict!,
                                                poscode!,
                                                emailController.text,
                                                lineIdController.text,
                                                false));

                                        await Navigator.pushNamed(
                                            context, '/check-information');
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: isValidated
                                              ? HexColor('#DB771A')
                                              : HexColor('#DB771A')
                                                  .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Center(
                                        child: Text('ยืนยัน',
                                            style: GoogleFonts.notoSansThai(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 33,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(219, 119, 26, 1),
              ),
            );
          });
    });
  }
}
