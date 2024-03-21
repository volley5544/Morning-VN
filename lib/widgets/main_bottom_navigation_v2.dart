import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/notify_bloc/notify_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/modules/userProfile/index.dart'
    as userProfileRepo;
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../connector/firestore/notify.dart';
import '../models/notify_model.dart';
import '../services//localStorage/notify_storage.dart';
import '../main.dart';
import '../util/logger_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  var user = await FirebaseAuth.instance.currentUser;

  user!.getIdTokenResult();
  var userss = user.uid;

  // String formattedDate =
  //     DateFormat('dd/MM/yyyy').format(message.sentTime as DateTime);
  // NotifyModel value = NotifyModel.fromJson(
  //     {'sentTime': formattedDate.toString(), ...message.data});
  final notiClient = NotifyConnector(userss);
  notiClient.setFlagNotify(true);
  logger.i("Handling a background message: ${message.messageId}");
}

int selectedIndex = 0;

class MainButtonNavigationBar2 extends StatefulWidget {
  final int currentIndex;

  const MainButtonNavigationBar2({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<MainButtonNavigationBar2> createState() =>
      _MainButtonNavigationBarState();
}

class _MainButtonNavigationBarState extends State<MainButtonNavigationBar2>
    with WidgetsBindingObserver {
  final _notifyStream = NotifyConnector(hashThaiId).getNotifySnapshots();

  bool _isInForeground = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
    if (_isInForeground) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.reload();
      context.read<NotifyBloc>().add(GetNotifyList(getNotify));
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    if (MessagingOnOpenedAppListenerList.isEmpty) {
      final notiOpenedAppListener = FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        var user = await FirebaseAuth.instance.currentUser;

        user!.getIdTokenResult();
        final userss = user.uid;

        final notiClient = NotifyConnector(userss);
        notiClient.setFlagNotify(true);
        logger.i('onMessageOpenedApp called');
        BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
        BlocProvider.of<PageResultBloc>(context).add(SetCurrentNavBarIndex(2));
        Navigator.of(context).pushNamed('/notify-page');
      });
      MessagingOnOpenedAppListenerList.add(notiOpenedAppListener);
    }
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    super.initState();
  }

  var localStorageObject = LocalStoragePrefernces();
  userProfileRepo.UserProfile userProfile = userProfileRepo.UserProfile();
  Future<void> onNavBarTaped(int index) async {
    selectedIndex = index;
    if (index == 3) {
      UserProfileState userProfileState =
          BlocProvider.of<UserProfileBloc>(context).state;
      if (!(userProfileState is UserProfileLoading)) {
        BlocProvider.of<UserProfileBloc>(context)
            .add(GetUserProFileData(userProfile, hashThaiId, context));
      }
    }
    BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
    BlocProvider.of<PageResultBloc>(context).add(SetCurrentNavBarIndex(index));
  }

  Widget renderIconNavbar(
      {required int index,
      required int currentIndex,
      required SvgPicture selectedIcon,
      required SvgPicture unSelectedIcon}) {
    if (index == currentIndex) {
      return selectedIcon;
    } else {
      return unSelectedIcon;
    }
  }

  double bottomNavBarHeight() {
    // To prevent notch padding with Grey background.
    return MediaQuery.of(context).viewPadding.bottom == 0
        ? BOTTOM_NAVIGATION_HEIGHT
        : BOTTOM_NAVIGATION_HEIGHT +
            (MediaQuery.of(context).viewPadding.bottom / 2);
  }

  bool hasBottomNotch() {
    return MediaQuery.of(context).viewPadding.bottom != 0;
  }

  Widget addtionalNotchWidget() {
    // To prevent notch padding with Grey background.
    return hasBottomNotch()
        ? Padding(
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context).viewPadding.bottom / 2)))
        : SizedBox();
  }

  Widget build(BuildContext context) {
    bool isShowNavbar =
        BlocProvider.of<PageResultBloc>(context).state.isSuggestionpageShown;
    return SizedBox(
        // height: 0,
        height: isShowNavbar ? bottomNavBarHeight() : 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(14), topLeft: Radius.circular(14)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                  offset: Offset(0, 0),
                  blurRadius: 30)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      addtionalNotchWidget(),
                      renderIconNavbar(
                          index: 0,
                          currentIndex: widget.currentIndex,
                          selectedIcon: SvgPicture.asset(
                              'assets/SelectedHomeIconNav.svg'),
                          unSelectedIcon: SvgPicture.asset(
                              'assets/UnSelectedHomeIconNav.svg')),
                    ],
                  ),
                  label: 'หน้าแรก',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      addtionalNotchWidget(),
                      renderIconNavbar(
                          index: 1,
                          currentIndex: widget.currentIndex,
                          selectedIcon: SvgPicture.asset(
                              'assets/SelectedBranchIconNav.svg'),
                          unSelectedIcon:
                              SvgPicture.asset('assets/BranchLocationNav.svg')),
                    ],
                  ),
                  label: 'ค้นหาสาขา',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      addtionalNotchWidget(),
                      Stack(
                        children: [
                          renderIconNavbar(
                              index: 2,
                              currentIndex: widget.currentIndex,
                              selectedIcon: SvgPicture.asset(
                                  'assets/SelectedNotiIconNav.svg'),
                              unSelectedIcon:
                                  SvgPicture.asset('assets/NotiIconNav.svg')),
                          StreamBuilder<DocumentSnapshot>(
                              stream: _notifyStream,
                              builder: (notifyContext,
                                  AsyncSnapshot<DocumentSnapshot>
                                      notifySnapshot) {
                                if (notifySnapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    notifySnapshot.hasError) {
                                  return SizedBox();
                                }
                                late dynamic dataParsing = null;
                                try {
                                  dataParsing =
                                      (notifySnapshot.data as dynamic).data();
                                  final FirestoreNotifyModel notiFirestoreData =
                                      dataParsing != null &&
                                              dataParsing.containsKey('notify')
                                          ? FirestoreNotifyModel.fromMap(
                                              dataParsing)
                                          : FirestoreNotifyModel(
                                              alreadySeen: false, notify: []);
                                  if (notiFirestoreData.alreadySeen == true) {
                                    return new Positioned(
                                      // draw a red marble
                                      top: 0.0,
                                      right: 0.0,
                                      child: SvgPicture.asset(
                                        'assets/red_dot_noti.svg',
                                        width: 8,
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                } catch (e) {
                                  return SizedBox();
                                }
                              })
                        ],
                      ),
                    ],
                  ),
                  label: 'แจ้งเตือน',
                ),
                BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      addtionalNotchWidget(),
                      renderIconNavbar(
                          index: 3,
                          currentIndex: widget.currentIndex,
                          selectedIcon: SvgPicture.asset(
                              'assets/SelectedMenuIconNav.svg'),
                          unSelectedIcon:
                              SvgPicture.asset('assets/MenuIconNav.svg')),
                    ],
                  ),
                  label: 'เมนูอื่นๆ',
                ),
              ],
              currentIndex: widget.currentIndex,
              selectedItemColor: HexColor('#DB771A'),
              unselectedItemColor: HexColor('#999999'),
              onTap: (index) {
                if (widget.currentIndex != index) {
                  onNavBarTaped(index);
                }
              },
            ),
          ),
        ));
  }
}

void handleAfterPop2(BuildContext context) {
  var currentPage =
      NavigationHistoryObserver().top?.settings.name?.toString() ?? "";
  final navbarIndex =
      BlocProvider.of<PageResultBloc>(context).state.currentIndex;
  if (currentPage == '/home-page') {
    BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
    if (navbarIndex == 0)
      // BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
      BlocProvider.of<PageResultBloc>(context)
          .add(const SetCurrentNavBarIndex(0));
    else if (navbarIndex == 1)
      BlocProvider.of<PageResultBloc>(context)
          .add(const SetCurrentNavBarIndex(1));
    else if (navbarIndex == 2)
      BlocProvider.of<PageResultBloc>(context)
          .add(const SetCurrentNavBarIndex(2));
    else if (navbarIndex == 3)
      BlocProvider.of<PageResultBloc>(context)
          .add(const SetCurrentNavBarIndex(3));
    else
      BlocProvider.of<PageResultBloc>(context)
          .add(const SetCurrentNavBarIndex(0));
  } else if (currentPage == '/map-page') {
    BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetCurrentNavBarIndex(1));
  } else if (currentPage == '/notify-page') {
    BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetCurrentNavBarIndex(2));
  } else if (currentPage == '/otherpage') {
    BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
    BlocProvider.of<PageResultBloc>(context)
        .add(const SetCurrentNavBarIndex(3));
  }
}
