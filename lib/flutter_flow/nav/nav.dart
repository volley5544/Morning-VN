import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/index.dart';
import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : LoginPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : LoginPageWidget(),
        ),
        FFRoute(
          name: 'HomePage',
          path: '/homePage',
          builder: (context, params) => HomePageWidget(),
        ),
        FFRoute(
          name: 'loginPage',
          path: '/loginPage',
          builder: (context, params) => LoginPageWidget(),
        ),
        FFRoute(
          name: 'pinPage',
          path: '/pinPage',
          builder: (context, params) => PinPageWidget(),
        ),
        FFRoute(
          name: 'setPinPage',
          path: '/setPinPage',
          builder: (context, params) => SetPinPageWidget(),
        ),
        FFRoute(
          name: 'testlogin',
          path: '/testlogin',
          builder: (context, params) => TestloginWidget(),
        ),
        FFRoute(
          name: 'DashboardCheckin',
          path: '/dashboardCheckin',
          builder: (context, params) => DashboardCheckinWidget(),
        ),
        FFRoute(
          name: 'DashboardLeavePage',
          path: '/dashboardLeavePage',
          builder: (context, params) => DashboardLeavePageWidget(),
        ),
        FFRoute(
          name: 'CheckInStatusPage',
          path: '/checkInStatusPage',
          builder: (context, params) => CheckInStatusPageWidget(),
        ),
        FFRoute(
          name: 'LeavePage',
          path: '/leavePage',
          builder: (context, params) => LeavePageWidget(),
        ),
        FFRoute(
          name: 'superAppPage',
          path: '/superAppPage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'superAppPage')
              : SuperAppPageWidget(),
        ),
        FFRoute(
          name: 'EmpolyeeCheckin',
          path: '/empolyeeCheckin',
          builder: (context, params) => EmpolyeeCheckinWidget(),
        ),
        FFRoute(
          name: 'AddLeavePage',
          path: '/addLeavePage',
          builder: (context, params) => AddLeavePageWidget(
            leaveName: params.getParam(
              'leaveName',
              ParamType.String,
            ),
            leaveType: params.getParam(
              'leaveType',
              ParamType.String,
            ),
            startDateLeave: params.getParam(
              'startDateLeave',
              ParamType.String,
            ),
            endDateLeave: params.getParam(
              'endDateLeave',
              ParamType.String,
            ),
            currentYear: params.getParam(
              'currentYear',
              ParamType.String,
            ),
            nextYear: params.getParam(
              'nextYear',
              ParamType.String,
            ),
            currentYearSelectableDates: params.getParam(
              'currentYearSelectableDates',
              ParamType.String,
            ),
            nextYearSelectableDates: params.getParam(
              'nextYearSelectableDates',
              ParamType.String,
            ),
            leavePeriods: params.getParam<dynamic>(
              'leavePeriods',
              ParamType.JSON,
              isList: true,
            ),
            previousYear: params.getParam(
              'previousYear',
              ParamType.String,
            ),
            previousYearSelectableDates: params.getParam(
              'previousYearSelectableDates',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'leaveShowPage',
          path: '/leaveShowPage',
          builder: (context, params) => LeaveShowPageWidget(),
        ),
        FFRoute(
          name: 'EditLeavePage',
          path: '/editLeavePage',
          builder: (context, params) => EditLeavePageWidget(
            leaveID: params.getParam(
              'leaveID',
              ParamType.String,
            ),
            leaveName: params.getParam(
              'leaveName',
              ParamType.String,
            ),
            leavePerios: params.getParam(
              'leavePerios',
              ParamType.String,
            ),
            leaveCountDay: params.getParam(
              'leaveCountDay',
              ParamType.String,
            ),
            leaveReason: params.getParam(
              'leaveReason',
              ParamType.String,
            ),
            userPhoneNumber: params.getParam(
              'userPhoneNumber',
              ParamType.String,
            ),
            leaveDocument: params.getParam<String>(
              'leaveDocument',
              ParamType.String,
              isList: true,
            ),
          ),
        ),
        FFRoute(
          name: 'ChangeLatLngPage',
          path: '/changeLatLngPage',
          builder: (context, params) => ChangeLatLngPageWidget(),
        ),
        FFRoute(
          name: 'MyProfilePage',
          path: '/myProfilePage',
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'MyProfilePage')
              : MyProfilePageWidget(),
        ),
        FFRoute(
          name: 'GuideBookPage',
          path: '/guideBookPage',
          builder: (context, params) => GuideBookPageWidget(),
        ),
        FFRoute(
          name: 'NotificationPage',
          path: '/notificationPage',
          builder: (context, params) => NotificationPageWidget(
            leaveType: params.getParam(
              'leaveType',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'SuccessCheckinPage',
          path: '/successCheckinPage',
          builder: (context, params) => SuccessCheckinPageWidget(),
        ),
        FFRoute(
          name: 'EmployeeCheckinPageVol',
          path: '/employeeCheckinPageVol',
          builder: (context, params) => EmployeeCheckinPageVolWidget(),
        ),
        FFRoute(
          name: 'CheckinStatusPageVol',
          path: '/checkinStatusPageVol',
          builder: (context, params) => CheckinStatusPageVolWidget(),
        ),
        FFRoute(
          name: 'TestPage',
          path: '/testPage',
          builder: (context, params) => TestPageWidget(),
        ),
        FFRoute(
          name: 'Test2Page',
          path: '/test2Page',
          builder: (context, params) => Test2PageWidget(),
        ),
        FFRoute(
          name: 'searchBranchPage',
          path: '/searchBranchPage',
          builder: (context, params) => SearchBranchPageWidget(
            dataList: params.getParam<ListLocationCheckInStruct>(
              'dataList',
              ParamType.DataStruct,
              isList: true,
              structBuilder: ListLocationCheckInStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: 'testCalendar',
          path: '/testCalendar',
          builder: (context, params) => TestCalendarWidget(),
        ),
        FFRoute(
          name: 'CancelPage',
          path: '/cancelPage',
          builder: (context, params) => CancelPageWidget(),
        ),
        FFRoute(
          name: 'ConfirmEmailPage',
          path: '/confirmEmailPage',
          builder: (context, params) => ConfirmEmailPageWidget(),
        ),
        FFRoute(
          name: 'ApprovedLeavePage',
          path: '/approvedLeavePage',
          builder: (context, params) => ApprovedLeavePageWidget(),
        ),
        FFRoute(
          name: 'ApproveShowPage',
          path: '/approveShowPage',
          builder: (context, params) => ApproveShowPageWidget(),
        ),
        FFRoute(
          name: 'AddResignPage',
          path: '/addResignPage',
          builder: (context, params) => AddResignPageWidget(),
        ),
        FFRoute(
          name: 'formServicePage',
          path: '/formServicePage',
          builder: (context, params) => FormServicePageWidget(
            formServiceName: params.getParam(
              'formServiceName',
              ParamType.String,
            ),
            formServiceUrl: params.getParam(
              'formServiceUrl',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'CalendarPage',
          path: '/calendarPage',
          builder: (context, params) => CalendarPageWidget(
            leaveType: params.getParam(
              'leaveType',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: 'ApproveShowPage5544',
          path: '/approveShowPage5544',
          builder: (context, params) => ApproveShowPage5544Widget(),
        ),
        FFRoute(
          name: 'leaveShowPage5544',
          path: '/leaveShowPage5544',
          builder: (context, params) => LeaveShowPage5544Widget(),
        ),
        FFRoute(
          name: 'SearchEmployeeTrackingPage',
          path: '/searchEmployeeTrackingPage',
          builder: (context, params) => SearchEmployeeTrackingPageWidget(),
        ),
        FFRoute(
          name: 'searchEmployeePage',
          path: '/searchEmployeePage',
          builder: (context, params) => SearchEmployeePageWidget(
            dataList: params.getParam<TrackingEmployeeDataModelStruct>(
              'dataList',
              ParamType.DataStruct,
              isList: true,
              structBuilder:
                  TrackingEmployeeDataModelStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: 'TrackingPage',
          path: '/trackingPage',
          builder: (context, params) => TrackingPageWidget(
            selectDate: params.getParam(
              'selectDate',
              ParamType.String,
            ),
            data: params.getParam<TrackingEmployeeDataLocationModelStruct>(
              'data',
              ParamType.DataStruct,
              isList: true,
              structBuilder:
                  TrackingEmployeeDataLocationModelStruct.fromSerializableMap,
            ),
            index: params.getParam(
              'index',
              ParamType.int,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/loginPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/SplashLoadingApp.png',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
