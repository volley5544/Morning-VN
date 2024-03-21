import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:location/location.dart';
import 'package:mobile_application_srisawad/bloc/loan_bloc/loan_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_history_bloc/loan_history_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_installment_bloc/loan_installment_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_payment_bloc/loan_payment_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_product_bloc/loan_product_bloc.dart';
import 'package:mobile_application_srisawad/bloc/loan_retention_bloc/loan_retention_bloc.dart';
import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart';
import 'package:mobile_application_srisawad/bloc/map_bloc/map_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/personal_credit/personalcredit_bloc.dart';
import 'package:mobile_application_srisawad/bloc/topup_bloc/topup_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/bloc/notify_bloc/notify_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_token/user_token_bloc.dart';
import 'package:mobile_application_srisawad/firebase_options.dart';
import 'package:mobile_application_srisawad/pages/map/google_map_value_handler.dart';
import 'package:mobile_application_srisawad/pages/user_process/introduction_page.dart';
import 'package:mobile_application_srisawad/router/routegenerator.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/widgets/dismiss_keyboard.dart';
import 'package:mobile_application_srisawad/widgets/main_bottom_navigation_v2.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';

import 'bloc/insurance_lead_bloc/insurance_lead_bloc.dart';
import 'bloc/insurance_product_bloc/insurance_product_bloc.dart';
import 'bloc/insurance_product_detail_bloc/insurance_product_detail_bloc.dart';
import 'bloc/loan_lead_bloc/loan_lead_bloc.dart';
import 'bloc/loan_product_detail_bloc/loan_product_detail_bloc.dart';
import 'bloc/register_bloc/register_bloc.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
    WidgetsFlutterBinding.ensureInitialized();
    final FirebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    logger.i(
        ' Currently Connect to: ${FirebaseApp.options.projectId} firebase project');

    FirebaseMessaging _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    logger.i('User granted permission: ${settings.authorizationStatus}');
    runApp(const ProviderScope(child: MyApp()));
    // throw 0;
  } catch (_, stack) {
    logger.e('Exception: ' + _.toString());
    logger.e('Stacktrace: ' + stack.toString());
    return logger.i(stack);
  }
}

Future initalzation(BuildContext? context) async {
  await Future.delayed(Duration(seconds: 5));
}

class IntroRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => IntroductionPage());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyApp();
}

Map<int, Color> color = {
  50: Color.fromRGBO(219, 119, 26, .1),
  100: Color.fromRGBO(219, 119, 26, .2),
  200: Color.fromRGBO(219, 119, 26, .3),
  300: Color.fromRGBO(219, 119, 26, .4),
  400: Color.fromRGBO(219, 119, 26, .5),
  500: Color.fromRGBO(219, 119, 26, .6),
  600: Color.fromRGBO(219, 119, 26, .7),
  700: Color.fromRGBO(219, 119, 26, .8),
  800: Color.fromRGBO(219, 119, 26, .9),
  900: Color.fromRGBO(219, 119, 26, 1),
};
Location location = Location();

List<StreamSubscription<RemoteMessage>> MessagingListenerList = [];
List<StreamSubscription<String>> MessagingOnRefreshTokenListenerList = [];
List<StreamSubscription<RemoteMessage>> MessagingOnOpenedAppListenerList = [];

GoogleMapValueHandler googleMapValueHandler = GoogleMapValueHandler();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final navKey = GlobalKey<NavigatorState>();
late String hashThaiId = '';
bool isWidthTooLong(BuildContext context) {
  return MediaQuery.of(context).size.width > 500;
}

const double BOTTOM_NAVIGATION_HEIGHT = 93;
const double BASE_BUTTON_HEIGHT = 60;

double getActualWidth(BuildContext context) {
  if (isWidthTooLong(context)) {
    return 500;
  } else {
    return MediaQuery.of(context).size.width;
  }
}

class _MyApp extends State<MyApp> {
  late String initRoute = '/loading-page';

  @override
  Widget build(BuildContext myAppContext) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    final personalcreditBloc = BlocProvider<PersonalcreditBloc>(
        create: (context) => PersonalcreditBloc());
    final userTokenBloc =
        BlocProvider<UserTokenBloc>(create: (myAppContext) => UserTokenBloc());
    final UserProfileDataBloc = BlocProvider<UserProfileBloc>(
        create: (myAppContext) => UserProfileBloc());
    final pageResultBloc = BlocProvider<PageResultBloc>(
        create: (contmyAppContextext) => PageResultBloc());
    final mapSearchBloc =
        BlocProvider<MapSearchBloc>(create: (myAppContext) => MapSearchBloc());
    final loanBloc =
        BlocProvider<LoanBloc>(create: (myAppContext) => LoanBloc());
    final topupBloc =
        BlocProvider<TopupBloc>(create: (myAppContext) => TopupBloc());
    final notifyBloc =
        BlocProvider<NotifyBloc>(create: (myAppContext) => NotifyBloc());
    final loanProductBloc = BlocProvider<LoanProductBloc>(
        create: (myAppContext) => LoanProductBloc());
    final loanProductDetailBloc = BlocProvider<LoanProductDetailBloc>(
        create: (myAppContext) => LoanProductDetailBloc());
    final loanLeadBloc =
        BlocProvider<LoanLeadBloc>(create: (myAppContext) => LoanLeadBloc());
    final insuranceProductBloc = BlocProvider<InsuranceProductBloc>(
        create: (myAppContext) => InsuranceProductBloc());
    final insuranceProductDetailBloc = BlocProvider<InsuranceProductDetailBloc>(
        create: (myAppContext) => InsuranceProductDetailBloc());
    final insuranceLeadBloc = BlocProvider<InsuranceLeadBloc>(
        create: (myAppContext) => InsuranceLeadBloc());
    final newMapBloc =
        BlocProvider<MapBloc>(create: (myAppContext) => MapBloc());
    final registerBloc =
        BlocProvider<RegisterBloc>(create: (myAppContext) => RegisterBloc());
    final loanPaymentBloc = BlocProvider<LoanPaymentBloc>(
        create: (myAppContext) => LoanPaymentBloc());
    final loanInstallmentBloc = BlocProvider<LoanInstallmentBloc>(
        create: (myAppContext) => LoanInstallmentBloc());
    final loanHistoryBloc = BlocProvider<LoanHistoryBloc>(
        create: (myAppContext) => LoanHistoryBloc());
    final loanRetentionBloc = BlocProvider<LoanRetentionBloc>(
        create: (myAppContext) => LoanRetentionBloc());

    MaterialColor colorCustom = MaterialColor(0xDB771A, color);
    const _primaryColor = Color.fromRGBO(219, 119, 26, 1);
    const _lightColor = Color.fromRGBO(232, 144, 62, 1);
    const _primaryTextColor = Color.fromRGBO(0, 48, 99, 1);
    const _secondaryColor = Color.fromRGBO(252, 239, 228, 1);
    const _descTextColor = Color.fromRGBO(139, 153, 167, 1);
    const _borderColor = Color.fromRGBO(229, 229, 229, 1);

    return MultiBlocProvider(
        providers: [
          personalcreditBloc,
          userTokenBloc,
          UserProfileDataBloc,
          pageResultBloc,
          mapSearchBloc,
          loanBloc,
          topupBloc,
          notifyBloc,
          loanProductBloc,
          loanProductDetailBloc,
          loanLeadBloc,
          insuranceProductBloc,
          insuranceProductDetailBloc,
          insuranceLeadBloc,
          newMapBloc,
          registerBloc,
          loanPaymentBloc,
          loanInstallmentBloc,
          loanHistoryBloc,
          loanRetentionBloc,
        ],
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 500),
            child: DismissKeyboard(
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  navigatorKey: navigatorKey,
                  // localizationsDelegates: [
                  //   DefaultCupertinoLocalizations.delegate,
                  // ],
                  // locale: Locale('th', 'TH'), // Current locale
                  // supportedLocales: [
                  //   const Locale('en', 'US'), // English
                  //   const Locale('th', 'TH'), // Thai
                  // ],
                  theme: ThemeData(
                    accentColor: const Color.fromRGBO(29, 113, 184, 1),
                    fontFamily: 'NotoSansThai',
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      onSecondary: _lightColor,
                      secondary: const Color.fromRGBO(29, 113, 184, 1),
                      // Your accent color
                      secondaryContainer: _secondaryColor,
                      tertiary: _primaryTextColor,
                      tertiaryContainer: _descTextColor,
                      onTertiary: _borderColor,
                    ),
                    primaryColor: _primaryColor,
                    // primarySwatch: colorCustom,
                    primaryTextTheme: const TextTheme(),
                    textTheme: ThemeData.light().textTheme.copyWith(
                        titleLarge: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            height: 1.51083333,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: _primaryTextColor),
                        titleMedium: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            height: 1.51125,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _primaryTextColor),
                        titleSmall: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        bodyMedium: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            height: 1.51071429,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _descTextColor),
                        labelMedium: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            height: 1.51071429,
                            letterSpacing: 0.3,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: _primaryColor),
                        labelSmall: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            height: 1.51071429,
                            letterSpacing: 0.3,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        bodyLarge: const TextStyle(
                            fontFamily: 'NotoSansThai',
                            height: 1.51071429,
                            letterSpacing: 0.3,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: _primaryTextColor)),
                    appBarTheme: const AppBarTheme(
                        titleTextStyle: TextStyle(
                            fontFamily: 'NotoSansThai',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    bottomAppBarTheme: const BottomAppBarTheme(
                      color: Colors.white,
                    ),
                  ),
                  navigatorObservers: [
                    FirebaseAnalyticsObserver(analytics: analytics),
                  ],
                  home: WillPopScope(
                    onWillPop: () async {
                      var navigatorKeyCanPop =
                          navigatorKey.currentState?.canPop() ?? false;
                      if (navigatorKeyCanPop) {
                        navigatorKey.currentState?.maybePop("back");
                        return false;
                      } else {
                        var navKeyCanPop =
                            navKey.currentState?.canPop() ?? false;
                        if (navKeyCanPop) {
                          navKey.currentState?.maybePop("back").then((value) {
                            handleAfterPop2(navKey.currentState!.context);
                          });
                          return false;
                        } else {
                          var currentPage = NavigationHistoryObserver()
                                  .top
                                  ?.settings
                                  .name
                                  ?.toString() ??
                              "";
                          if (currentPage == '/home-page' ||
                              currentPage == '/intro-page') {
                            return true;
                          }
                          if (currentPage == '/otherpage') {
                            BlocProvider.of<PageResultBloc>(context)
                                .add(SetButtonNavigator(true));
                            BlocProvider.of<PageResultBloc>(context)
                                .add(SetCurrentNavBarIndex(0));
                            navKey.currentState?.pushNamedAndRemoveUntil(
                                '/home-page', (route) => false);
                            return false;
                          }
                          return false;
                        }
                      }
                    },
                    child: BlocBuilder<PageResultBloc, PageResultState>(
                        builder: (builderContext, state) {
                      return Scaffold(
                        body: Scaffold(
                          extendBody: true,
                          body: Navigator(
                              observers: [NavigationHistoryObserver()],
                              key: navKey,
                              initialRoute: initRoute,
                              onGenerateRoute: RouteGenerator.generateRoute),
                        ),
                      );
                    }),
                  )),
            ),
          ),
        ));
  }
}
