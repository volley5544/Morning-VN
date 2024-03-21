// import 'dart:convert';
// import 'package:collection/collection.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:mobile_application_srisawad/bloc/map_search_bloc/map_search_bloc.dart'
//     as mapSearch;
// import 'package:mobile_application_srisawad/bloc/notify_bloc/notify_bloc.dart';
// import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
// import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
// import 'package:mobile_application_srisawad/modules/mapSearch/index.dart'
//     as mapRepo;
// import 'package:mobile_application_srisawad/modules/userProfile/index.dart'
//     as userProfileRepo;
// import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart';
// import 'package:navigation_history_observer/navigation_history_observer.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../connector/firestore/notify.dart';
// import '../models/notify_model.dart';
// import '../services//localStorage/notify_storage.dart';
// import '../main.dart';

// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   var user = await FirebaseAuth.instance.currentUser;

//   user!.getIdTokenResult();
//   var userss = user.uid;

//   String formattedDate =
//       DateFormat('dd/MM/yyyy').format(message.sentTime as DateTime);
//   NotifyModel value = NotifyModel.fromJson(
//       {'sentTime': formattedDate.toString(), ...message.data});
//   final notiClient = NotifyConnector(userss);
//   notiClient.setFlagNotify(true);
//   print("Handling a background message: ${message.messageId}");
// }

// class MainButtonNavigationBar extends StatefulWidget {
//   final BuildContext navigateContext;
//   final PageResultState pageResultState;

//   final GlobalKey<NavigatorState> nKey;
//   const MainButtonNavigationBar(
//       {Key? key,
//       required this.pageResultState,
//       required this.navigateContext,
//       required this.nKey})
//       : super(key: key);

//   @override
//   State<MainButtonNavigationBar> createState() =>
//       _MainButtonNavigationBarState();
// }

// int selectedIndex = 0;

// class _MainButtonNavigationBarState extends State<MainButtonNavigationBar>
//     with WidgetsBindingObserver {
//   final _notifyStream = NotifyConnector(hashThaiId).getNotifySnapshots();

//   bool _isInForeground = true;

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     super.didChangeAppLifecycleState(state);
//     _isInForeground = state == AppLifecycleState.resumed;
//     if (_isInForeground) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.reload();
//       context.read<NotifyBloc>().add(GetNotifyList(getNotify));
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addObserver(this);
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
//       var user = await FirebaseAuth.instance.currentUser;

//       user!.getIdTokenResult();
//       final userss = user.uid;

//       final notiClient = NotifyConnector(userss);
//       notiClient.setFlagNotify(true);
//       print('onMessageOpenedApp called');
//       BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//       Navigator.of(context).pushNamed('/notify-page');
//     });
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//     super.initState();
//   }

//   var localStorageObject = LocalStoragePrefernces();
//   userProfileRepo.UserProfile userProfile = userProfileRepo.UserProfile();
//   Future<void> onNavBarTaped(int index, BuildContext context) async {
//     selectedIndex = index;

//     BlocProvider.of<PageResultBloc>(context).add(SetCurrentNavBarIndex(index));
//     if (index == 0) {
//       await widget.nKey.currentState?.pushReplacementNamed('/home-page');
//       BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//     } else if (index == 1) {
//       await widget.nKey.currentState?.pushReplacementNamed('/map-page');

//       // BlocProvider.of<mapSearch.MapSearchBloc>(context).add(mapSearch.MapSetSearchHistory(branchOptions: ));
//       BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//     } else if (index == 2) {
//       BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//       await widget.nKey.currentState?.pushReplacementNamed('/notify-page');
//     } else {
//       await widget.nKey.currentState?.pushReplacementNamed('/otherpage');
//       dynamic notitifyList =
//           await localStorageObject.getLocalStorage('userId', 'string');
//       UserProfileState userProfileState =
//           BlocProvider.of<UserProfileBloc>(context).state;
//       if (!(userProfileState is UserProfileLoading)) {
//         BlocProvider.of<UserProfileBloc>(context).add(
//             GetUserProFileData(userProfile, notitifyList.toString(), context));
//       }
//       BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//     }
//   }

//   bool checkIfCall() {
//     return widget.pageResultState.isButtonNavigatorShow;
//   }

//   Widget renderIconNavbar(
//       {required int index,
//       required int currentIndex,
//       required SvgPicture selectedIcon,
//       required SvgPicture unSelectedIcon}) {
//     if (index == currentIndex) {
//       return selectedIcon;
//     } else {
//       return unSelectedIcon;
//     }
//   }

//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//           height: widget.pageResultState.isButtonNavigatorShow ? 93 : 0,
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(14), topLeft: Radius.circular(14)),
//               boxShadow: [
//                 BoxShadow(
//                     color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
//                     offset: Offset(0, 0),
//                     blurRadius: 30)
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(14),
//                 topRight: Radius.circular(14),
//               ),
//               child: BottomNavigationBar(
//                 type: BottomNavigationBarType.fixed,
//                 backgroundColor: Colors.white,
//                 items: <BottomNavigationBarItem>[
//                   BottomNavigationBarItem(
//                     icon: renderIconNavbar(
//                         index: 0,
//                         currentIndex: widget.pageResultState.currentIndex,
//                         selectedIcon:
//                             SvgPicture.asset('assets/SelectedHomeIconNav.svg'),
//                         unSelectedIcon: SvgPicture.asset(
//                             'assets/UnSelectedHomeIconNav.svg')),
//                     label: 'หน้าแรก',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: renderIconNavbar(
//                         index: 1,
//                         currentIndex: widget.pageResultState.currentIndex,
//                         selectedIcon: SvgPicture.asset(
//                             'assets/SelectedBranchIconNav.svg'),
//                         unSelectedIcon:
//                             SvgPicture.asset('assets/BranchLocationNav.svg')),
//                     label: 'ค้นหาสาขา',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Stack(children: [
//                       renderIconNavbar(
//                           index: 2,
//                           currentIndex: widget.pageResultState.currentIndex,
//                           selectedIcon: SvgPicture.asset(
//                               'assets/SelectedNotiIconNav.svg'),
//                           unSelectedIcon:
//                               SvgPicture.asset('assets/NotiIconNav.svg')),
//                       StreamBuilder<QuerySnapshot>(
//                           stream: _notifyStream,
//                           builder: (notifyContext, notifySnapshot) {
//                             if (notifySnapshot.connectionState ==
//                                     ConnectionState.waiting ||
//                                 notifySnapshot.hasError) {
//                               return SizedBox();
//                             }
//                             final notiList = notifySnapshot.data!.docs
//                                 .firstWhereOrNull(
//                                     (element) => element.id == hashThaiId);
//                             try {
//                               final FirestoreNotifyModel notiFirestoreData =
//                                   notiList != null
//                                       ? notiList.data() as FirestoreNotifyModel
//                                       : FirestoreNotifyModel(
//                                           alreadySeen: false, notify: []);

//                               if (notiFirestoreData.alreadySeen == true) {
//                                 return new Positioned(
//                                   // draw a red marble
//                                   top: 0.0,
//                                   right: 0.0,
//                                   child: new Icon(Icons.brightness_1,
//                                       size: 8.0, color: Colors.redAccent),
//                                 );
//                               } else {
//                                 return SizedBox();
//                               }
//                             } catch (e) {
//                               return SizedBox();
//                             }
//                           })
//                     ]),
//                     label: 'แจ้งเตือน',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: renderIconNavbar(
//                         index: 3,
//                         currentIndex: widget.pageResultState.currentIndex,
//                         selectedIcon:
//                             SvgPicture.asset('assets/SelectedMenuIconNav.svg'),
//                         unSelectedIcon:
//                             SvgPicture.asset('assets/MenuIconNav.svg')),
//                     label: 'เมนูอื่นๆ',
//                   ),
//                 ],
//                 currentIndex: widget.pageResultState.currentIndex,
//                 selectedItemColor: HexColor('#DB771A'),
//                 unselectedItemColor: HexColor('#999999'),
//                 onTap: (index) {
//                   if (widget.pageResultState.currentIndex != index) {
//                     onNavBarTaped(index, context);
//                   }
//                 },
//               ),
//             ),
//           )),
//     );
//   }
// }

// void handleAfterPop(BuildContext context) {
//   var currentPage =
//       NavigationHistoryObserver().top?.settings.name?.toString() ?? "";
//   if (currentPage == '/home-page') {
//     BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//     BlocProvider.of<PageResultBloc>(context)
//         .add(const SetCurrentNavBarIndex(0));
//   } else if (currentPage == '/map-page') {
//     BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//     BlocProvider.of<PageResultBloc>(context)
//         .add(const SetCurrentNavBarIndex(1));
//   } else if (currentPage == '/notify-page') {
//     BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//     BlocProvider.of<PageResultBloc>(context)
//         .add(const SetCurrentNavBarIndex(2));
//   } else if (currentPage == '/otherpage') {
//     BlocProvider.of<PageResultBloc>(context).add(SetButtonNavigator(true));
//     BlocProvider.of<PageResultBloc>(context)
//         .add(const SetCurrentNavBarIndex(3));
//   }
// }
