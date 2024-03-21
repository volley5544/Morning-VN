import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_application_srisawad/models/notify_model.dart';
import 'package:mobile_application_srisawad/widgets/no_internet_widget.dart';
import '../../connector/firestore/notify.dart';
import '../../main.dart';
import '../../services/localStorage/notify_storage.dart';

class NofityPage extends StatefulWidget {
  final String targetHashThaiId;

  const NofityPage({Key? key, required String this.targetHashThaiId})
      : super(key: key);

  @override
  State<NofityPage> createState() => _NofityPageState();
}

class _NofityPageState extends State<NofityPage> {
  late Stream<DocumentSnapshot> _notifyStream =
      NotifyConnector(widget.targetHashThaiId).getNotifySnapshots();

  bool? hasConnection = null;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    if (await InternetConnectionChecker().hasConnection) {
      setState(() {
        hasConnection = true;
      });
      final notiClient = NotifyConnector(widget.targetHashThaiId);
      await notiClient.setFlagNotify(false);
    } else {
      setState(() {
        hasConnection = false;
      });
    }
  }

  clearNoti() async {
    await clearNotifyLocalStorage();
  }

  renderNotiNotfound() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.60,
      color: HexColor('#FFFFFF'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/notification.svg'),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Text('ไม่มีการแจ้งเตือน',
                style: GoogleFonts.notoSansThai(
                  color: HexColor('#8B99A7'),
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                )),
          ),
        ],
      ),
    );
  }

  renderNotiCard(NotifyModel? details) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(14),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      padding: EdgeInsets.fromLTRB(11, 17, 21, 33),
                      child: SvgPicture.asset('assets/light-notify.svg',
                          width: 17,
                          height: 20,
                          alignment: Alignment.topCenter)),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(details!.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.merge(TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500))),
                                // TODO date time format
                                Text(
                                  details.sentTime,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.merge(TextStyle(fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              // constraints: BoxConstraints(minHeight: 102, maxHeight: 500),
                              width: MediaQuery.of(context).size.width,
                              child: Text(details.body,
                                  style: TextStyle(
                                      fontFamily: 'NotoSansThai',
                                      height: 1.51125,
                                      letterSpacing: 0.3,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: HexColor('#646464'))),
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ),
        Divider(
          color: HexColor('#F5F5F5'),
          thickness: 3,
          height: 1,
        ),
      ],
    );
  }

  renderNotiList() {
    return StreamBuilder<DocumentSnapshot>(
        stream: _notifyStream,
        builder:
            (notifyContext, AsyncSnapshot<DocumentSnapshot> notifySnapshot) {
          if (notifySnapshot.hasError) {
            return renderNotiNotfound();
          }

          if (notifySnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(
              color: Color.fromRGBO(219, 119, 26, 1),
            );
          } else {
            late dynamic dataParsing = null;
            try {
              dataParsing = (notifySnapshot.data as dynamic).data();
            } catch (e) {
              dataParsing = null;
            }
            final FirestoreNotifyModel notiFirestoreData =
                dataParsing != null && dataParsing.containsKey('notify')
                    ? FirestoreNotifyModel.fromMap(dataParsing)
                    : FirestoreNotifyModel(alreadySeen: false, notify: []);
            notiFirestoreData.notify
                .sort((a, b) => b.sendTimestamp.compareTo(a.sendTimestamp));
            return notiFirestoreData.notify.isEmpty
                ? renderNotiNotfound()
                : Column(
                    children: [
                      ...(notiFirestoreData.notify
                          .map((key) => renderNotiCard(key))),
                    ],
                  );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return (hasConnection != null)
        ? (hasConnection! ? getNormalStateWidget() : getNoInternetWidget())
        : Container();
  }

  getNormalStateWidget() {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('การแจ้งเตือน',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
            elevation: 0,
            backgroundColor: HexColor('#FFFFFF')),
        body: Container(
          color: HexColor('#FFFFFF'),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, bottom: 6),
                width: getActualWidth(
                    context), // MediaQuery.of(context).size.width,
                color: HexColor('#FFFFFF'),
                child: Text('รายการข้อความแจ้งเตือน',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .merge(TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
              ),
              Divider(
                color: HexColor('#F5F5F5'),
                thickness: 3,
                height: 1,
              ),
              Expanded(
                child: SingleChildScrollView(child: renderNotiList()),
              ),
            ],
          ),
        ));
  }

  getNoInternetWidget() {
    return Container(
      color: HexColor('#FFFFFF'),
      child: Stack(
        children: [
          AppBar(
              centerTitle: true,
              title: Text('การแจ้งเตือน',
                  style: Theme.of(context).textTheme.titleMedium),
              elevation: 0,
              backgroundColor: HexColor('#FFFFFF')),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: BOTTOM_NAVIGATION_HEIGHT),
              child: NoInternetWidget(onRetry: () async {
                initData();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
