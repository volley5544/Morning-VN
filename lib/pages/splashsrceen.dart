import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const StatefulWrapper({required this.onInit, required this.child});

  @override
  _StatefulWrapperState createState() => _StatefulWrapperState();
}

class _StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
        onInit: () {
          pageRedirection(context);
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/bg-gredient-splash-screen.jpg')),
          ),
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset('assets/ic_blue_splash_screen.svg')),
              Positioned(
                  left: 0,
                  bottom: 0,
                  child:
                      SvgPicture.asset('assets/ic_orange_splash_screen.svg')),
              Center(
                child: Image.asset(
                  'assets/srisawad-logo-splash.png',
                  width: 120,
                  height: 140,
                ),
              )
            ],
          ),
        ));
  }

  Future pageRedirection(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/middle-screen',
      (route) => false,
    );
  }
}
