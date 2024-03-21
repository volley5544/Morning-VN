import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/pages/home_page_component/home_page_options.dart';
import 'package:mobile_application_srisawad/pages/home_page_component/other_product.dart';
import 'package:mobile_application_srisawad/pages/home_page_component/personal_loan_list.dart';
import 'package:mobile_application_srisawad/pages/home_page_component/total_loan_balance.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart';
import 'package:mobile_application_srisawad/services/localStorage/pin_local_storage.dart';
import 'package:mobile_application_srisawad/widgets/no_internet_widget.dart';
import 'package:mobile_application_srisawad/widgets/progress_loading.dart';

import '../../connector/cloud_storage.dart';
import '../bloc/register_bloc/register_bloc.dart';
import '../main.dart';
import '../models/register.dart';
import '../modules/authRegister/index.dart';
import '../modules/loan/index.dart';
import '../modules/userProfile/index.dart';
import '../util/logger_service.dart';
import 'home_page_component/insurance_product_home_widget.dart';
import 'home_page_component/loan_product_home_widget.dart';

final List<String> imgList = [
  'assets/สินเชื่อ.png',
  'assets/ประกัน.png',
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double PADDING_LEFT = 22;
  static const double PADDING_RIGHT = 22;
  static const double PADDING_HORIZONTAL = 22;
  var isShowTopBar = false;
  StorageConnector storageClient = new StorageConnector();
  int current = 0;
  late bool isImageLoaded = false;
  bool? hasConnection = null;
  UserProfile userProfile = UserProfile();
  LoanRepository loanRepository = LoanRepository();
  final IMAGE_LOCATION = dotenv.env['IMAGE_LOCATION'];

  Future _getUserData(BuildContext context, UserProfile userProfile) async {
    UserProfileState state = BlocProvider.of<UserProfileBloc>(context).state;

    if (await InternetConnectionChecker().hasConnection) {
      if (state.imageFile.isEmpty || state.userProfileData.firstName == '') {
        try {
          context
              .read<UserProfileBloc>()
              .add(GetUserProFileData(userProfile, hashThaiId, context));
          isImageLoaded = false;
          final user = await FirebaseAuth.instance.currentUser;
          String mockPath1 = '${IMAGE_LOCATION}';
          String mockPath2 = '/display_image.jpg';
          StorageConnector storageConnector = StorageConnector();
          dynamic userIdFromLocalStorage =
              await localStorageObject.getLocalStorage('userId', 'string');
          logger
              .i('user id from storage: ${userIdFromLocalStorage.toString()}');

          Uint8List fetchedImage = await storageConnector
              .downloadToMemory(mockPath1 + user!.uid + mockPath2);
          BlocProvider.of<UserProfileBloc>(context).add(SetDisplayImageFromHome(
              userProfile: userProfile,
              imagePath: mockPath1 + user.uid + mockPath2,
              imageFile: fetchedImage));
        } catch (e) {
          logger.e('Error when get user data', e.toString());
        }
      }
      setState(() {
        isImageLoaded = true;
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
    FirebaseAnalytics.instance.logEvent(
      name: 'homepage_view',
      parameters: {},
    );
    // showBottomNavigation();
    _getUserData(
      context,
      userProfile,
    );

    scrollController = ScrollController();
    scrollController?.addListener(() {
      if (scrollController!.position.pixels > 0) {
        if (!isShowTopBar) {
          setState(() {
            isShowTopBar = true;
          });
        }
      } else {
        if (isShowTopBar) {
          setState(() {
            isShowTopBar = false;
          });
        }
      }
    });

    super.initState();
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            // color: Colors.amber,
            margin: const EdgeInsets.fromLTRB(12, 15, 12, 0),
            // padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                  child: Image.asset(
                    item,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ))
      .toList();

  Widget userImage(Uint8List imageFile) {
    // final UserProfileState userProfileBloc =
    //     BlocProvider.of<UserProfileBloc>(context).state;
    if (isImageLoaded) {
      return ClipRRect(
        child: Image.memory(
          gaplessPlayback: true,
          Uint8List.fromList(imageFile),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(100 / 2),
      );
    }
    return ClipRRect(
      child: Image.asset(
        'assets/user-default.png',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(100 / 2),
    );
  }

  Widget srisawadLogo(UserProfileState state) {
    return Row(
      children: [
        Expanded(
          child: const Padding(
            padding: EdgeInsets.only(left: 54),
            child: Center(
              child: Image(
                image: AssetImage('assets/srisawad-logo.png'),
                height: 40,
              ),
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.only(right: 16),
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(232, 144, 62, 1),
                width: 1,
              ),
              image: DecorationImage(
                  image: AssetImage('assets/user-default.png'),
                  fit: BoxFit.fitWidth),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            child: GestureDetector(
              child: userImage(state.imageFile),
              onTap: () {
                BlocProvider.of<PageResultBloc>(context)
                    .add(const SetButtonNavigator(false));
                Navigator.pushNamed(context, '/settings/profile',
                    arguments: {'registerSuccess': false});
              },
            )),
      ],
    );
  }

  Widget NameWidget(String firstName, String lastName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PADDING_HORIZONTAL),
      child: Text('👋🏻สวัสดี คุณ${firstName}',
          style: GoogleFonts.notoSansThai(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: HexColor('#003063'))),
    );
  }

  Widget greetingWidget(UserProfileState state) {
    if (state is UserProfileLoading) {
      return Container();
    }
    return NameWidget(
        state.userProfileData.firstName, state.userProfileData.lastName);
  }

  Widget signOutWidget() {
    return TextButton(
      onPressed: () async {
        FirebaseAnalytics.instance.logEvent(
          name: 'logout',
          parameters: {},
        );
        // logOutPin.removeLocalStorage('pin');
        await removePinLocalStorage();
        if (FirebaseAuth.instance.currentUser != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/intro-page',
            (route) => false,
          );
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.30,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            'SignOut',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  final LocalStoragePrefernces logOutPin = LocalStoragePrefernces();
  ScrollController? scrollController = null;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics.instance.logEvent(
      name: 'home_page_view',
      parameters: {
        'device_id': '',
      },
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: hasConnection != null
            ? hasConnection!
                ? Stack(
                    children: [
                      BlocBuilder<LoanBloc, LoanState>(
                        builder: (loanContext, loanState) {
                          return SingleChildScrollView(
                            controller: scrollController,
                            child: Container(
                              color: HexColor('#F5F5F5'),
                              child: Column(
                                children: [
                                  BlocBuilder<UserProfileBloc,
                                      UserProfileState>(
                                    builder: (context, state) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(30),
                                                bottomRight:
                                                    Radius.circular(30)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    'assets/header-background2.png'),
                                                fit: BoxFit.fill)),
                                        child: SingleChildScrollView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          child: SafeArea(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 22,
                                                ),
                                                srisawadLogo(state),
                                                SizedBox(height: 20),
                                                (state is UserProfileComplete)
                                                    ? Padding(
                                                        padding: const EdgeInsets
                                                                .symmetric(
                                                            horizontal:
                                                                PADDING_HORIZONTAL),
                                                        child: Text(
                                                            '👋🏻สวัสดี คุณ${state.userProfileData.firstName}',
                                                            style: GoogleFonts.notoSansThai(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: HexColor(
                                                                    '#003063'))),
                                                      )
                                                    : (Container()),
                                                if (context
                                                        .read<RegisterBloc>()
                                                        .state
                                                        .isValidated ==
                                                    true)
                                                  SizedBox(height: 10),
                                                Padding(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: context
                                                                    .read<
                                                                        RegisterBloc>()
                                                                    .state
                                                                    .isValidated ==
                                                                true
                                                            ? PADDING_HORIZONTAL
                                                            : 0),
                                                    child: (state
                                                            is UserProfileComplete)
                                                        ? context
                                                                    .read<
                                                                        RegisterBloc>()
                                                                    .state
                                                                    .isValidated ==
                                                                true
                                                            ? TotleLoanBalance(
                                                                latestUpdatedDate:
                                                                    loanState
                                                                        .loanListData
                                                                        .totalDataDate,
                                                                sumedAmount: loanState
                                                                    .loanListData
                                                                    .sumCurrentDueAmount,
                                                                isLoading: loanState
                                                                    is LoanListLoading,
                                                              )
                                                            : OtherProduct(
                                                                imageSliders:
                                                                    imageSliders,
                                                                imgList:
                                                                    imgList,
                                                                isExist: false,
                                                              )
                                                        : Container()),
                                                if (context
                                                        .read<RegisterBloc>()
                                                        .state
                                                        .isValidated ==
                                                    true)
                                                  const SelectableHomePageOptions(),
                                                if (context
                                                        .read<RegisterBloc>()
                                                        .state
                                                        .isValidated ==
                                                    true)
                                                  SizedBox(
                                                    height: 13,
                                                  )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  if (context
                                          .read<RegisterBloc>()
                                          .state
                                          .isValidated ==
                                      true)
                                    SizedBox(
                                      height: 14,
                                    ),
                                  if (context
                                          .read<RegisterBloc>()
                                          .state
                                          .isValidated ==
                                      true)
                                    PersonalLoanList(
                                      loanState: loanState,
                                    ),
                                  SizedBox(
                                    height: 18,
                                  ),
                                  if (context
                                          .read<RegisterBloc>()
                                          .state
                                          .isValidated ==
                                      true)
                                    OtherProduct(
                                      imageSliders: imageSliders,
                                      imgList: imgList,
                                      isExist: true,
                                    ),
                                  LoanProductHomeWidget(
                                      isExist: context
                                          .read<RegisterBloc>()
                                          .state
                                          .isValidated),
                                  InsuranceProductHomeWidget(
                                    isExist: context
                                            .read<RegisterBloc>()
                                            .state
                                            .isValidated ==
                                        true,
                                  ),
                                  // signOutWidget()
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 500),
                        opacity: isShowTopBar ? 1 : 0,
                        child: Container(
                          color: HexColor("#FAE4D1"),
                          child: SafeArea(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    height: 22,
                                  ),
                                  BlocBuilder<UserProfileBloc,
                                          UserProfileState>(
                                      builder: (context, state) {
                                    return srisawadLogo(state);
                                  }),
                                  SizedBox(height: 20),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: BOTTOM_NAVIGATION_HEIGHT),
                        child: NoInternetWidget(
                          onRetry: () async {
                            _getUserData(
                              context,
                              userProfile,
                            );
                          },
                        ),
                      ),
                    ),
                  )
            : Center(child: ProgressLoading()),
      ),
    );
  }

  void showBottomNavigation() {
    BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetCurrentNavBarIndex(0));
  }
}
