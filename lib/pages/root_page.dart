import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/pages/home_page.dart';
import 'package:mobile_application_srisawad/pages/map/map_page.dart';
import 'package:mobile_application_srisawad/pages/other_menu/other_page_frontpage.dart';
import 'package:mobile_application_srisawad/pages/user_process/notify_page.dart';
import 'package:mobile_application_srisawad/widgets/main_bottom_navigation_v2.dart';

// ignore: must_be_immutable
class RootPage extends StatefulWidget {
  late int initialIndex;
  late bool fromNavigate;
  RootPage({Key? key, this.fromNavigate = true, required this.initialIndex})
      : super(key: key);

  @override
  State<RootPage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RootPage> {
  final _page = {
    '0': HomePage(),
    '1': NewMapPage(),
    '2': NofityPage(
      targetHashThaiId: hashThaiId,
    ),
    '3': OtherPageFrontPage(),
  };

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageResultBloc, PageResultState>(
      builder: (builderContext, state) {
        return Scaffold(
            body: _page['${state.currentIndex}'] as Widget,
            bottomNavigationBar: new MainButtonNavigationBar2(
              currentIndex: state.currentIndex,
            ));
      },
    );
  }
}
