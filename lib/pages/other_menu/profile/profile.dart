import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';
import 'package:mobile_application_srisawad/models/user_profile_data.dart';
import 'package:mobile_application_srisawad/modules/userProfile/index.dart';
import 'package:mobile_application_srisawad/pages/other_menu/profile/display_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_application_srisawad/modules/mapSearch/index.dart'
    as mapRepo;

import '../../../bloc/register_bloc/register_bloc.dart';
import '../../../main.dart';
import '../../../util/check_string_format.dart';
import '../../../util/logger_service.dart';
import '../../../widgets/bottompage.dart';
import '../../../widgets/fields/profile_fields.dart';
import '../../../services/localStorage/local_storage.dart' as ls;
import '../../../widgets/flash/top_flash.dart';
import '../../../widgets/no_internet_widget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  StorageConnector storageConnector = StorageConnector();
  StorageConnector storageClient = new StorageConnector();
  ls.LocalStoragePrefernces localStorageObject = ls.LocalStoragePrefernces();
  final mapRepo.MapSearch mapSearchRepo = mapRepo.MapSearch();
  late String userThaiId = '';
  bool? hasConnection = null;

  static const configKey = [
    {'label': 'ชื่อ', 'valueField': 'first_name'},
    {'label': 'นามสกุล', 'valueField': 'last_name'},
    {'label': 'เบอร์โทรศัพท์', 'valueField': 'phone_number'},
    {'label': 'วัน เดือน ปีเกิด (พ.ศ.)', 'valueField': 'dob'},
    {'label': 'หมายเลขบัตรประชาชน', 'valueField': 'thai_id'},
  ];
  UserProfile userProfile = UserProfile();

  Map<String, dynamic> setModelEncode(UserProfileData userProfileData) {
    return {
      'is_existing_customer': userProfileData.isExistingCustomer,
      'thai_id': userProfileData.thaiId,
      'title': userProfileData.title,
      'first_name': userProfileData.firstName,
      'last_name': userProfileData.lastName,
      'phone_number': userProfileData.phoneNumber,
      'dob': userProfileData.dob,
      'email': userProfileData.email,
      'address_details': userProfileData.addressDetails,
      'address_sub_district': userProfileData.addressSubDistrict,
      'address_distinct': userProfileData.addressDistinct,
      'address_province': userProfileData.addressProvince,
      'address_postal_code': userProfileData.addressPostalCode,
      'line_id': userProfileData.lineId,
    };
  }

  void getUserThaiId() async {
    if (await InternetConnectionChecker().hasConnection) {
      logger.i('user profile ${hashThaiId}');
      BlocProvider.of<UserProfileBloc>(context)
          .add(GetUserProFileData(userProfile, hashThaiId, context));
      // setState(() {
      userThaiId = hashThaiId;
      // });
      setState(() {
        hasConnection = true;
      });
    } else {
      setState(() {
        hasConnection = false;
      });
    }
  }

  @override
  void initState() {
    getUserThaiId();
    super.initState();
  }

  Timer? timer;

  uploadFile(File capturedPhoto, BuildContext context) async {
    context.read<UserProfileBloc>().add(SetDisplayImage(
        userProfile: userProfile,
        imagePath: '',
        imageFile: Uint8List(0),
        inputContext: context,
        capturedPhoto: capturedPhoto));
  }

  Widget renderUserProperty(Map<String, String> key, UserProfileState state) {
    switch (key['label'] as String) {
      case 'หมายเลขบัตรประชาชน':
        return ProfileFields(
            keyName: key['label'] as String,
            keyValue: setModelEncode(state.userProfileData)[key['valueField']]
                    .replaceAllMapped(
                        RegExp(r'(\d{1})(\d{4})(\d{5})(\d{2})(\d+)'),
                        (Match m) => "${m[1]}-${m[2]}-${m[3]}-${m[4]}-${m[5]}")
                as String);
      case 'วัน เดือน ปีเกิด (พ.ศ.)':
        return ProfileFields(
            keyName: key['label'] as String,
            keyValue: formateBudDate(
                setModelEncode(state.userProfileData)[key['valueField']]
                    as String));
      // DateFormat.yMd().format(DateTime.parse(
      //     setModelEncode(state.userProfileData)[key['valueField']]
      //         as String)));
      case 'เบอร์โทรศัพท์':
        return ProfileFields(
            keyName: key['label'] as String,
            keyValue: setModelEncode(state.userProfileData)[key['valueField']]
                .replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'),
                    (Match m) => "${m[1]}-${m[2]}-${m[3]}") as String);
      default:
        return ProfileFields(
            keyName: key['label'] as String,
            keyValue: setModelEncode(state.userProfileData)[key['valueField']]
                as String);
    }
  }

  Future<void> launchCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return (hasConnection != null)
        ? (hasConnection! ? getNormalStateWidget() : getNoInternetWidget())
        : Container();
  }

  showPopup() {
    ShowTwoBottomPngVersion(
      context,
      'กรุณาติดต่อสาขา',
      'assets/branch-image.png',
      'กรุณาติดต่อที่สาขาหรือแผนกบริการลูกค้า\nเพื่อทำการแก้ไขข้อมูลพื้นฐาน',
      () async {
        BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
        BlocProvider.of<PageResultBloc>(context).add(SetCurrentNavBarIndex(1));
        Navigator.pushNamed(context, '/map-page').then((value) {
          BlocProvider.of<PageResultBloc>(context)
              .add(SetButtonNavigator(true));
          BlocProvider.of<PageResultBloc>(context)
              .add(SetCurrentNavBarIndex(0));

          Navigator.of(context).pushNamedAndRemoveUntil(
            '/home-page',
            (route) => false,
          );
        });
      },
      'ค้นหาสาขาใกล้เคียง',
      () {
        // TODO [Saksit] : ask team to get Srisawad Phone number ชช 1650
        // and make a phone call when user click this btn.
        // Navigator.pushNamed(context, '/');
        launchCall('1652');
      },
      'โทรแผนกบริการลูกค้า',
    );
  }

  getNormalStateWidget() {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text(
            'ข้อมูลผู้ใช้',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.merge(const TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<PageResultBloc>(context)
                  .add(SetButtonNavigator(true));
              Navigator.of(context).pushNamed('/otherpage');
            },
            icon: Icon(
              Icons.arrow_back,
              color: HexColor('#DB771A'),
            ),
          ),
        ),
        body: BlocConsumer<UserProfileBloc, UserProfileState>(
          listener: (listenerContext, state) {
            if (state is UserProfileUpdatePhotoComplete) {
              showTopFlash(
                  margin: EdgeInsets.symmetric(horizontal: 22),
                  duration: 2,
                  barrierColor: Colors.transparent,
                  contents: Container(
                    width: double.infinity,
                    color: Color.fromRGBO(0, 0, 0, 0.8),
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 22, vertical: 24),
                        child: Container(
                            child: Row(children: [
                          SvgPicture.asset('assets/SuccessSnackIcon.svg'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'อัปเดตรูปภาพสำเร็จ',
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
            }
          },
          builder: (blocContext, state) {
            if (state is UserProfileLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: Color.fromRGBO(219, 119, 26, 1),
              ));
            }
            if (state is UserProfileComplete ||
                state is UserProfilePhotoLoading) {
              return Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(11, 0, 11, 0),
                      child: Container(
                        child: Column(children: [
                          SizedBox(
                            height: 23,
                          ),
                          state is UserProfilePhotoLoading
                              ? SizedBox(
                                  width: 114,
                                  height: 114,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Color.fromRGBO(219, 119, 26, 1),
                                  )))
                              : DisplayImage(
                                  thaiId: setModelEncode(state.userProfileData)[
                                      'thai_id'] as String,
                                  imageFile: state.imageFile,
                                  userProfileContext: context,
                                  uploadCallback: (_photo) =>
                                      uploadFile(_photo, context),
                                ),
                          const SizedBox(
                            height: 30,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(11, 0, 11, 0),
                                child: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                height: 20,
                                                child: Container(
                                                    width: 4,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                                0xFFDB771A)
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    20))))),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Text(
                                                'ข้อมูลพื้นฐาน',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.merge(const TextStyle(
                                                        fontFamily:
                                                            'NotoSansThaiSemiBold')),
                                              ),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                        .read<RegisterBloc>()
                                                        .state
                                                        .isValidated ==
                                                    false
                                                ? Navigator.pushNamed(
                                                    context, '/edit-profile')
                                                : showPopup();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            child: SvgPicture.asset(
                                                'assets/edit-icon.svg'),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ...(configKey.map((key) =>
                                                renderUserProperty(key, state)))
                                          ]),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                            height: 20,
                                            child: Container(
                                                width: 4,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFDB771A)
                                                            .withOpacity(0.5),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                20))))),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'ข้อมูลที่อยู่',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.merge(const TextStyle(
                                                  fontFamily:
                                                      'NotoSansThaiSemiBold')),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 14,
                                    ),
                                    Container(
                                      // width: 400,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onTertiary),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 12, right: 20),
                                                child: SvgPicture.asset(
                                                    'assets/current-address-icon.svg')),
                                            Flexible(
                                              child: Container(
                                                width: double.infinity,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'ที่อยู่ปัจจุบัน',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.merge(TextStyle(
                                                                fontSize: 14)),
                                                      ),
                                                      Text(
                                                        (setModelEncode(state
                                                                            .userProfileData)[
                                                                        'address_details']
                                                                    as String)
                                                                .trim() +
                                                            ' ' +
                                                            'ต.' +
                                                            (setModelEncode(state
                                                                        .userProfileData)[
                                                                    'address_sub_district']
                                                                as String) +
                                                            ' ' +
                                                            'อ.' +
                                                            (setModelEncode(state
                                                                        .userProfileData)[
                                                                    'address_distinct']
                                                                as String),
                                                        style: GoogleFonts
                                                            .notoSansThai(
                                                          color: HexColor(
                                                              "#003063"),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        (setModelEncode(state
                                                                        .userProfileData)[
                                                                    'address_province']
                                                                as String) +
                                                            ' ' +
                                                            (setModelEncode(state
                                                                        .userProfileData)[
                                                                    'address_postal_code']
                                                                as String),
                                                        style: GoogleFonts
                                                            .notoSansThai(
                                                          color: HexColor(
                                                              "#003063"),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                                height: 20,
                                                child: Container(
                                                    width: 4,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                                0xFFDB771A)
                                                            .withOpacity(0.5),
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    20))))),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'ข้อมูลติดต่ออื่นๆ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.merge(const TextStyle(
                                                      fontFamily:
                                                          'NotoSansThaiSemiBold')),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                '/settings/profile/update',
                                                arguments: {
                                                  'userId': userThaiId
                                                });
                                          }, //UpdateProfile(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 20, 0),
                                            child: SvgPicture.asset(
                                                'assets/edit-icon.svg'),
                                          ),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ProfileFields(
                                                keyName: 'อีเมล',
                                                keyValue: setModelEncode(
                                                        state.userProfileData)[
                                                    'email'] as String,
                                                emptyValue: 'ยังไม่ระบุ',
                                              ),
                                              ProfileFields(
                                                  keyName: 'ไลน์ไอดี (LINE ID)',
                                                  keyValue: setModelEncode(state
                                                          .userProfileData)[
                                                      'line_id'] as String,
                                                  emptyValue: 'ยังไม่ระบุ'),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 14,
                          ),
                        ]),
                      )));
            }
            return Center(
              child: Container(),
            );
          },
        ));
  }

  getNoInternetWidget() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(
              'ข้อมูลผู้ใช้',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.merge(const TextStyle(fontFamily: 'NotoSansThaiSemiBold')),
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
          Center(
            child: NoInternetWidget(
              onRetry: () async {
                getUserThaiId();
              },
            ),
          ),
        ],
      ),
    );
  }
}
