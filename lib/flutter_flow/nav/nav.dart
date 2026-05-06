import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

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
          name: HomePageWidget.routeName,
          path: HomePageWidget.routePath,
          builder: (context, params) => HomePageWidget(),
        ),
        FFRoute(
          name: LoginPageWidget.routeName,
          path: LoginPageWidget.routePath,
          builder: (context, params) => LoginPageWidget(),
        ),
        FFRoute(
          name: PinPageWidget.routeName,
          path: PinPageWidget.routePath,
          builder: (context, params) => PinPageWidget(),
        ),
        FFRoute(
          name: SetPinPageWidget.routeName,
          path: SetPinPageWidget.routePath,
          builder: (context, params) => SetPinPageWidget(),
        ),
        FFRoute(
          name: TestloginWidget.routeName,
          path: TestloginWidget.routePath,
          builder: (context, params) => TestloginWidget(),
        ),
        FFRoute(
          name: DashboardCheckinWidget.routeName,
          path: DashboardCheckinWidget.routePath,
          builder: (context, params) => DashboardCheckinWidget(),
        ),
        FFRoute(
          name: DashboardLeavePageWidget.routeName,
          path: DashboardLeavePageWidget.routePath,
          builder: (context, params) => DashboardLeavePageWidget(),
        ),
        FFRoute(
          name: CheckInStatusPageWidget.routeName,
          path: CheckInStatusPageWidget.routePath,
          builder: (context, params) => CheckInStatusPageWidget(),
        ),
        FFRoute(
          name: LeavePageWidget.routeName,
          path: LeavePageWidget.routePath,
          builder: (context, params) => LeavePageWidget(),
        ),
        FFRoute(
          name: SuperAppPageWidget.routeName,
          path: SuperAppPageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'superAppPage')
              : SuperAppPageWidget(),
        ),
        FFRoute(
          name: EmpolyeeCheckinWidget.routeName,
          path: EmpolyeeCheckinWidget.routePath,
          builder: (context, params) => EmpolyeeCheckinWidget(),
        ),
        FFRoute(
          name: AddLeavePageWidget.routeName,
          path: AddLeavePageWidget.routePath,
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
          name: LeaveShowPageWidget.routeName,
          path: LeaveShowPageWidget.routePath,
          builder: (context, params) => LeaveShowPageWidget(),
        ),
        FFRoute(
          name: EditLeavePageWidget.routeName,
          path: EditLeavePageWidget.routePath,
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
          name: ChangeLatLngPageWidget.routeName,
          path: ChangeLatLngPageWidget.routePath,
          builder: (context, params) => ChangeLatLngPageWidget(),
        ),
        FFRoute(
          name: MyProfilePageWidget.routeName,
          path: MyProfilePageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'MyProfilePage')
              : MyProfilePageWidget(),
        ),
        FFRoute(
          name: GuideBookPageWidget.routeName,
          path: GuideBookPageWidget.routePath,
          builder: (context, params) => GuideBookPageWidget(),
        ),
        FFRoute(
          name: NotificationPageWidget.routeName,
          path: NotificationPageWidget.routePath,
          builder: (context, params) => NotificationPageWidget(
            leaveType: params.getParam(
              'leaveType',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SuccessCheckinPageWidget.routeName,
          path: SuccessCheckinPageWidget.routePath,
          builder: (context, params) => SuccessCheckinPageWidget(),
        ),
        FFRoute(
          name: EmployeeCheckinPageVolWidget.routeName,
          path: EmployeeCheckinPageVolWidget.routePath,
          builder: (context, params) => EmployeeCheckinPageVolWidget(),
        ),
        FFRoute(
          name: CheckinStatusPageVolWidget.routeName,
          path: CheckinStatusPageVolWidget.routePath,
          builder: (context, params) => CheckinStatusPageVolWidget(),
        ),
        FFRoute(
          name: TestPageWidget.routeName,
          path: TestPageWidget.routePath,
          builder: (context, params) => TestPageWidget(),
        ),
        FFRoute(
          name: Test2PageWidget.routeName,
          path: Test2PageWidget.routePath,
          builder: (context, params) => Test2PageWidget(),
        ),
        FFRoute(
          name: SearchBranchPageWidget.routeName,
          path: SearchBranchPageWidget.routePath,
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
          name: TestCalendarWidget.routeName,
          path: TestCalendarWidget.routePath,
          builder: (context, params) => TestCalendarWidget(),
        ),
        FFRoute(
          name: CancelPageWidget.routeName,
          path: CancelPageWidget.routePath,
          builder: (context, params) => CancelPageWidget(),
        ),
        FFRoute(
          name: ConfirmEmailPageWidget.routeName,
          path: ConfirmEmailPageWidget.routePath,
          builder: (context, params) => ConfirmEmailPageWidget(),
        ),
        FFRoute(
          name: ApprovedLeavePageWidget.routeName,
          path: ApprovedLeavePageWidget.routePath,
          builder: (context, params) => ApprovedLeavePageWidget(),
        ),
        FFRoute(
          name: ApproveShowPageWidget.routeName,
          path: ApproveShowPageWidget.routePath,
          builder: (context, params) => ApproveShowPageWidget(),
        ),
        FFRoute(
          name: AddResignPageWidget.routeName,
          path: AddResignPageWidget.routePath,
          builder: (context, params) => AddResignPageWidget(),
        ),
        FFRoute(
          name: FormServicePageWidget.routeName,
          path: FormServicePageWidget.routePath,
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
          name: CalendarPageWidget.routeName,
          path: CalendarPageWidget.routePath,
          builder: (context, params) => CalendarPageWidget(
            leaveType: params.getParam(
              'leaveType',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ApproveShowPage5544Widget.routeName,
          path: ApproveShowPage5544Widget.routePath,
          builder: (context, params) => ApproveShowPage5544Widget(),
        ),
        FFRoute(
          name: LeaveShowPage5544Widget.routeName,
          path: LeaveShowPage5544Widget.routePath,
          builder: (context, params) => LeaveShowPage5544Widget(),
        ),
        FFRoute(
          name: SearchEmployeeTrackingPageWidget.routeName,
          path: SearchEmployeeTrackingPageWidget.routePath,
          builder: (context, params) => SearchEmployeeTrackingPageWidget(),
        ),
        FFRoute(
          name: SearchEmployeePageWidget.routeName,
          path: SearchEmployeePageWidget.routePath,
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
          name: TrackingPageWidget.routeName,
          path: TrackingPageWidget.routePath,
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
        ),
        FFRoute(
          name: MobileHomePageWidget.routeName,
          path: MobileHomePageWidget.routePath,
          builder: (context, params) => MobileHomePageWidget(),
        ),
        FFRoute(
          name: SuccessCollectionWidget.routeName,
          path: SuccessCollectionWidget.routePath,
          builder: (context, params) => SuccessCollectionWidget(),
        ),
        FFRoute(
          name: LeadDashboardPageWidget.routeName,
          path: LeadDashboardPageWidget.routePath,
          builder: (context, params) => LeadDashboardPageWidget(),
        ),
        FFRoute(
          name: LeadListPageWidget.routeName,
          path: LeadListPageWidget.routePath,
          builder: (context, params) => LeadListPageWidget(),
        ),
        FFRoute(
          name: TabCollectionPageWidget.routeName,
          path: TabCollectionPageWidget.routePath,
          builder: (context, params) => TabCollectionPageWidget(),
        ),
        FFRoute(
          name: ListCollectionPageWidget.routeName,
          path: ListCollectionPageWidget.routePath,
          builder: (context, params) => ListCollectionPageWidget(
            dataFilter: params.getParam(
              'dataFilter',
              ParamType.DataStruct,
              isList: false,
              structBuilder: CountCollectionDataModelStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: DetailCollectionPageWidget.routeName,
          path: DetailCollectionPageWidget.routePath,
          builder: (context, params) => DetailCollectionPageWidget(
            idCard: params.getParam(
              'idCard',
              ParamType.String,
            ),
            dataFilter: params.getParam(
              'dataFilter',
              ParamType.DataStruct,
              isList: false,
              structBuilder: CountCollectionDataModelStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: RemarkRP8PageWidget.routeName,
          path: RemarkRP8PageWidget.routePath,
          builder: (context, params) => RemarkRP8PageWidget(
            contNoSelected: params.getParam(
              'contNoSelected',
              ParamType.DataStruct,
              isList: false,
              structBuilder: CollectionDataModelStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: SaveCallCollectionPageWidget.routeName,
          path: SaveCallCollectionPageWidget.routePath,
          builder: (context, params) => SaveCallCollectionPageWidget(
            contNoSelected: params.getParam<CollectionDataModelStruct>(
              'contNoSelected',
              ParamType.DataStruct,
              isList: true,
              structBuilder: CollectionDataModelStruct.fromSerializableMap,
            ),
          ),
        ),
        FFRoute(
          name: HistoryCollectionPageWidget.routeName,
          path: HistoryCollectionPageWidget.routePath,
          builder: (context, params) => HistoryCollectionPageWidget(
            contNo: params.getParam(
              'contNo',
              ParamType.String,
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
                  name: state.name,
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
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
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
