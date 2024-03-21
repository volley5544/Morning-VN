import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/connector/authentication/login_function.dart';
import 'package:mobile_application_srisawad/connector/cloud_storage.dart';
import 'package:mobile_application_srisawad/connector/firestore/notify.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/modules/authLogin/index.dart';
import 'package:mobile_application_srisawad/modules/authRegister/index.dart';
import 'package:mobile_application_srisawad/modules/userProfile/index.dart';
import 'package:mobile_application_srisawad/services/display_image.dart';
import 'package:mobile_application_srisawad/services/notification.dart';
import 'package:mobile_application_srisawad/util/check_string_format.dart';
import 'package:mobile_application_srisawad/util/custom_exception.dart';
import 'package:mobile_application_srisawad/util/device_id.dart';
import 'package:mobile_application_srisawad/widgets/bottompage.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as localStorage;
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';
import 'package:mobile_application_srisawad/widgets/text_compent.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../bloc/page_result/page_result_bloc.dart';
import '../../bloc/user_profile/user_profile_bloc.dart';
import '../../util/logger_service.dart';
import '../../widgets/dialog/login_error.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';
import '../topup/topup_styling.dart';

class ReCheckRegister extends StatefulWidget {
  const ReCheckRegister({Key? key}) : super(key: key);

  @override
  State<ReCheckRegister> createState() => _ReCheckRegisterState();
}

class _ReCheckRegisterState extends State<ReCheckRegister> {
  bool isRegisterLoading = false;
  StorageConnector storageClient = new StorageConnector();
  Displayimage displayimage = Displayimage();
  Future<void> setDefaultImage(String userId) async {
    try {
      var bytes = await rootBundle.load('assets/user-default.png');
      final imageFile = File('${(await getTemporaryDirectory()).path}/assets');
      await imageFile.writeAsBytes(
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      await displayimage.uploadDisplayImage(imageFile);
    } catch (e) {
      logger.e('Fail to upload image when register: $e');
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
    return BlocBuilder<UserTokenBloc, UserTokenState>(
      builder: (userTokenContext, state) {
        localRegister(onSuccessPath) async {
          var localStorageObject = localStorage.LocalStoragePrefernces();
          StorageConnector storageConnector = StorageConnector();
          try {
            await AuthRegister.registerauther(
                state.registerVerfiy.thaiId.toString(),
                state.registerVerfiy.phoneNumber!,
                state.registerVerfiy.firstName.toString(),
                state.registerVerfiy.lastName.toString(),
                state.registerVerfiy.title.toString(),
                state.registerVerfiy.dob.toString(),
                state.registerVerfiy.email.toString(),
                state.registerVerfiy.addressDetails.toString(),
                state.registerVerfiy.addressSubDistrict.toString(),
                state.registerVerfiy.addressDistrict.toString(),
                state.registerVerfiy.addressProvince.toString(),
                state.registerVerfiy.addressPostalCode.toString(),
                state.registerVerfiy.lineId.toString());
            await dotenv.load(fileName: ".env");
            Uint8List fetchedImage;
            String mockPath1 = '${dotenv.env['IMAGE_LOCATION']}';
            String mockPath2 = '/display_image.jpg';
            String userId = '';

            final firebaseToken = await UserLogin.getUserToken(
                state.registerVerfiy.thaiId.toString(),
                state.registerVerfiy.phoneNumber!);

            if (['401', '404'].contains(firebaseToken)) {
              logger.w('Got Client 40X error code.');
              loginWithErrorDialog(context);
            } else if (['500', '501', '502', '509'].contains(firebaseToken)) {
              logger.w('Got Internal server 50X error code.');
              serverSuspendedDialog(context);
            } else {
              FirebaseAnalytics.instance.logEvent(
                name: 'register_srisawad_user',
                parameters: {
                  'device_id': (await getId()),
                  'device_type': '-',
                },
              );
              final value = await LoginFunction.signIn(firebaseToken);
              final user = await FirebaseAuth.instance.currentUser;
              logger.d('user ID: >>>$value');
              await user!.getIdTokenResult();
              userId = user.uid;
              hashThaiId = userId;
              localStorageObject.setLocalStorage('userToken', value, 'string');
              localStorageObject.setLocalStorage(
                  'userId', state.registerVerfiy.thaiId, 'string');
              localStorageObject.setLocalStorage(
                  'phoneNumber', state.registerVerfiy.phoneNumber, 'string');
              await setDefaultImage(userId);
              // Handle FCM token to firestore
              final notiClient = NotifyConnector(userId);
              createOnTokenRefreshListener(userId);
              final fcmToken = await FirebaseMessaging.instance.getToken();

              notiClient.setFcmToken(fcmToken as String);
              try {
                fetchedImage = await storageConnector
                    .downloadToMemory(mockPath1 + userId + mockPath2);
                UserProfile userProfile = UserProfile();
                BlocProvider.of<UserProfileBloc>(context).add(
                    SetDisplayImageFromHome(
                        userProfile: userProfile,
                        imagePath: mockPath1 + userId + mockPath2,
                        imageFile: fetchedImage));
                BlocProvider.of<UserProfileBloc>(context)
                    .add(GetUserProFileData(userProfile, hashThaiId, context));
              } catch (e) {
                logger.e(
                    'Fail to fetch profile image when register : ${e.toString()}');
              }
            }
            BlocProvider.of<PageResultBloc>(context)
                .add(const SetCurrentNavBarIndex(0));

            await Navigator.pushNamed(context, onSuccessPath);
            createNotificationReciever(hashThaiId);
          } on RESTApiException catch (e) {
            logger.e(
                'Recheck register error(RESTApiException) :${e.cause.toString()} ');
            serverSuspendedDialog(context, additionalText: e.cause.toString());
          } catch (e) {
            logger.e('Recheck register error(default) :${e.toString()} ');
            serverSuspendedDialog(context, additionalText: e.toString());
          } finally {
            setState(() {
              isRegisterLoading = false;
            });
          }
        }

        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: isRegisterLoading
              ? ProgressLoading()
              : Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, bottom: 18, top: 10),
                          child: Text(
                            'ตรวจสอบข้อมูลส่วนตัว',
                            style: GoogleFonts.notoSansThai(
                              color: HexColor('#003063'),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
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
                                Text(
                                  'กรุณาตรวจสอบความถูกต้องของข้อมูลเพื่อรับข้อมูลสิทธิประโยชน์จากทางศรีสวัสดิ์',
                                  style: GoogleFonts.notoSansThai(
                                      color: HexColor('#003063'),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SectionTextTitle("ข้อมูลพื้นฐาน",
                                    Color(0xFFDB771A).withOpacity(0.5), 18),
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'ชื่อ',
                                          style: GoogleFonts.notoSansThai(
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          state.registerVerfiy.firstName
                                              .toString(),
                                          style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'นามสกุล',
                                          style: GoogleFonts.notoSansThai(
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          state.registerVerfiy.lastName
                                              .toString(),
                                          style: GoogleFonts.notoSansThai(
                                            color: HexColor('#003063'),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'เบอร์โทรศัพท์',
                                          style: GoogleFonts.notoSansThai(
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                            state.registerVerfiy.phoneNumber!
                                                .replaceAllMapped(
                                                    RegExp(
                                                        r'(\d{3})(\d{3})(\d+)'),
                                                    (Match m) =>
                                                        "${m[1]}-${m[2]}-${m[3]}"),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .merge(TextStyle(
                                                    color: HexColor('#003063'),
                                                    fontFamily:
                                                        'NotoSansThaiSemiBold',
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'วัน เดือน ปีเกิด (พ.ศ.)',
                                          style: GoogleFonts.notoSansThai(
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                            formateBudDate(state
                                                .registerVerfiy.dob
                                                .toString()),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .merge(TextStyle(
                                                    color: HexColor('#003063'),
                                                    fontFamily:
                                                        'NotoSansThaiSemiBold',
                                                    fontWeight:
                                                        FontWeight.w600))),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'หมายเลขบัตรประชาชน',
                                          style: GoogleFonts.notoSansThai(
                                              color: HexColor('#646464'),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                            state.registerVerfiy.thaiId
                                                .toString()
                                                .replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1})(\d{4})(\d{5})(\d{2})(\d+)'),
                                                  (Match m) =>
                                                      "${m[1]}-${m[2]}-${m[3]}-${m[4]}-${m[5]}",
                                                ),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .merge(TextStyle(
                                                    color: HexColor('#003063'),
                                                    fontFamily:
                                                        'NotoSansThaiSemiBold',
                                                    fontWeight:
                                                        FontWeight.w600))),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SectionTextTitle("ข้อมูลที่อยู่",
                                    Color(0xFFDB771A).withOpacity(0.5), 18),
                                SizedBox(
                                  height: 20,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.only(
                                                left: 12, right: 20, top: 12),
                                            child: SvgPicture.asset(
                                                'assets/current-address-icon.svg')),
                                        Flexible(
                                            child: Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text('ที่อยู่ปัจจุบัน',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .merge(TextStyle(
                                                          fontSize: 14,
                                                          color: HexColor(
                                                              '#003063'),
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              'NotoSansThaiSemiBold',
                                                        ))),
                                                Text(
                                                  state.registerVerfiy
                                                          .addressDetails
                                                          .toString()
                                                          .trim() +
                                                      ' ' +
                                                      'ต.' +
                                                      state.registerVerfiy
                                                          .addressSubDistrict
                                                          .toString() +
                                                      ' ' +
                                                      'อ.' +
                                                      state.registerVerfiy
                                                          .addressDistrict
                                                          .toString() +
                                                      ' ' +
                                                      'จ.' +
                                                      state.registerVerfiy
                                                          .addressProvince
                                                          .toString() +
                                                      ' ' +
                                                      state.registerVerfiy
                                                          .addressPostalCode
                                                          .toString(),
                                                  style: size18Wnormal.merge(
                                                      TextStyle(
                                                          color: HexColor(
                                                              "003063"),
                                                          fontSize: 14,
                                                          height: 1.5)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 22, right: 22, bottom: 32, top: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                  height: BASE_BUTTON_HEIGHT,
                                  decoration: BoxDecoration(
                                      color: HexColor('#FCEFE4'),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: TextButton(
                                    onPressed: () {
                                      ShowTwoBottomPngVersion(
                                          context,
                                          'กรุณาติดต่อสาขา',
                                          'assets/branch-image.png',
                                          'กรุณาติดต่อที่สาขาหรือแผนกบริการลูกค้า\nเพื่อทำการแก้ไขข้อมูลพื้นฐาน',
                                          () async {
                                            setState(() {
                                              isRegisterLoading = true;
                                            });
                                            BlocProvider.of<PageResultBloc>(
                                                    context)
                                                .add(SetButtonNavigator(true));
                                            BlocProvider.of<PageResultBloc>(
                                                    context)
                                                .add(SetCurrentNavBarIndex(1));
                                            await localRegister('/map-page');
                                          },
                                          'ค้นหาสาขาใกล้เคียง',
                                          () {
                                            launchCall('1652');
                                          },
                                          'โทรหาแผนกบริการลูกค้า');
                                    },
                                    child: Text(
                                      'ไม่ถูกต้อง',
                                      style: GoogleFonts.notoSansThai(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: HexColor('#DB771A')),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Expanded(
                              child: Container(
                                  height: BASE_BUTTON_HEIGHT,
                                  decoration: BoxDecoration(
                                      color: HexColor('#DB771A'),
                                      borderRadius: BorderRadius.circular(14)),
                                  child: TextButton(
                                    onPressed: () async {
                                      setState(() {
                                        isRegisterLoading = true;
                                      });
                                      await localRegister('/home-page');
                                    },
                                    child: Text(
                                      'ถูกต้อง',
                                      style: GoogleFonts.notoSansThai(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: HexColor('#FFFFFF')),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
