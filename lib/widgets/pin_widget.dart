import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mobile_application_srisawad/bloc/page_result/page_result_bloc.dart';

import '../util/authentication_type.dart';

class PinWidget extends StatefulWidget {
  final Function verifyPinCode;
  final Function closerButton;
  final Function? onLeadButtonClick;
  final String mainTitle;
  final String subTitle;
  late String warningMessage;
  late bool showLeading;
  late bool showCloser;
  late bool show;
  late bool showResetPasscode;
  late bool showAuthenticationButton = false;
  late AuthenticationType authenticationType;
  final Function? onClickAuthenticationButton;

  PinWidget({
    Key? key,
    required this.verifyPinCode,
    required this.mainTitle,
    required this.subTitle,
    required this.closerButton,
    this.warningMessage = '',
    this.showLeading = false,
    this.showCloser = true,
    this.showResetPasscode = false,
    this.onLeadButtonClick,
    this.authenticationType = AuthenticationType.None,
    this.onClickAuthenticationButton,
  }) : super(key: key);

  @override
  State<PinWidget> createState() => _PinWidget();
}

// TODO add back button when "ยืนยันรหัสผ่านอืีกคร้ง" ในหน้า login ครั้งแรก, register และ เปลียน passcode
class _PinWidget extends State<PinWidget> {
  final number = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  String inputText = '';
  var checkInput;
  var actives = [false, false, false, false, false, false];
  var clears = [false, false, false, false, false, false];
  var values = [1, 2, 3, 4, 5, 6];
  var currentIndex = 0;

  bool isTooShort(BuildContext context) {
    if (MediaQuery.of(context).size.height < 667) return true;
    return false;
  }

  Widget mainWidget() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: widget.showLeading
            ? IconButton(
                onPressed: () {
                  if (widget.onLeadButtonClick == null) {
                    Navigator.of(context).pop();
                    BlocProvider.of<PageResultBloc>(context)
                        .add(SetButtonNavigator(true));
                  } else {
                    clearPin();
                    widget.onLeadButtonClick?.call();
                  }
                },
                icon: SvgPicture.asset('assets/back-icon.svg'),
              )
            : PreferredSize(
                preferredSize: Size(0.0, 0.0),
                child: Container(),
              ),
        actions: [
          widget.showCloser
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () => widget.closerButton(),
                    icon: SvgPicture.asset('assets/close-icon.svg'),
                  ),
                )
              : PreferredSize(
                  preferredSize: Size(0.0, 0.0),
                  child: Container(),
                )
        ],
      ),
      body: Wrap(children: [
        Container(
          decoration: const BoxDecoration(color: Colors.white),
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Center(
                  child: Text(widget.mainTitle,
                      style: Theme.of(context).textTheme.titleLarge!.merge(
                          TextStyle(fontFamily: 'NotoSansThaiSemiBold'))),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    widget.subTitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansThai(
                      fontSize: 16,
                      color: HexColor('#003063'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                if (widget.warningMessage.isNotEmpty)
                  Center(
                    child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/error-icon.svg'),
                            Text(
                              ' ${widget.warningMessage}',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .merge(TextStyle(
                                      color: Color.fromRGBO(160, 40, 2, 1),
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        )),
                  ),
                SizedBox(
                  height: isTooShort(context) ? 36 : 55,
                ),
                Center(
                  child: Container(
                    height: isTooShort(context) ? 20 : 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < actives.length; i++)
                          AnimationBoxPasscode(
                            clear: clears[i],
                            active: actives[i],
                            value: values[i],
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: isTooShort(context) ? 0 : 20,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6 / 0.45,
                  ),
                  itemBuilder: ((context, index) {
                    return Container(
                      height: 50,
                      width: 50,
                      child: index == 9
                          ? getIndex9Button()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: Center(
                                child: MaterialButton(
                                  minWidth: isTooShort(context)
                                      ? 100
                                      : double.infinity,
                                  height: isTooShort(context)
                                      ? 50
                                      : double.infinity,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        isTooShort(context) ? 20 : 50),
                                  ),
                                  elevation: 0,
                                  onPressed: () {
                                    if (index == 11) {
                                      inputText = inputText.substring(
                                          0, inputText.length - 1);
                                      clears =
                                          clears.map((e) => false).toList();
                                      currentIndex--;
                                      if (currentIndex >= 0) {
                                        setState(() {
                                          clears[currentIndex] = true;
                                          actives[currentIndex] = false;
                                        });
                                      } else {
                                        currentIndex = 0;
                                      }
                                      return;
                                    } else {
                                      inputText += number[
                                              index == 10 ? index - 1 : index]
                                          .toString();
                                    }

                                    if (inputText.length == 6) {
                                      setState(() {
                                        clears =
                                            clears.map((e) => true).toList();
                                        actives =
                                            actives.map((e) => false).toList();
                                      });
                                      widget.verifyPinCode(inputText);
                                      inputText = '';

                                      FirebaseAnalytics.instance.logEvent(
                                        name: 'login_pin',
                                        parameters: {},
                                      );
                                      inputText == checkInput;
                                      currentIndex = 0;
                                      return;
                                    }

                                    clears = clears.map((e) => false).toList();
                                    setState(() {
                                      actives[currentIndex] = true;
                                      currentIndex++;
                                    });
                                  },
                                  child: index == 11
                                      ? SvgPicture.asset('assets/Delete.svg')
                                      : Text(
                                          '${number[index == 10 ? index - 1 : index]}',
                                          style: GoogleFonts.notoSansThai(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w700,
                                            color: HexColor('#003063'),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                    );
                  }),
                  itemCount: 12,
                ),
                SizedBox(
                  height: isTooShort(context) ? 17 : 25,
                ),
                if (widget.showResetPasscode)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('/forgotpasscode-page');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Text('ลืมรหัสผ่าน?',
                          style: Theme.of(context).textTheme.labelMedium!.merge(
                              TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'NotoSansThaiSemiBold',
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.mainTitle == 'เปลี่ยนรหัสผ่าน'
        ? mainWidget()
        : WillPopScope(
            onWillPop: () async {
              if (widget.onLeadButtonClick != null) {
                clearPin();
              }
              widget.closerButton();
              return false;
            },
            child: mainWidget());
  }

  void clearPin() {
    actives = actives.map((e) => false).toList();
    clears = clears.map((e) => false).toList();
    currentIndex = 0;
    inputText = '';
  }

  getIndex9Button() {
    if (widget.authenticationType != AuthenticationType.None) {
      return Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: MaterialButton(
            minWidth: isTooShort(context)
                ? 100
                : double.infinity,
            height: isTooShort(context)
                ? 50
                : double.infinity,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  isTooShort(context) ? 20 : 50),
            ),
            elevation: 0,
            onPressed: () {
              widget.onClickAuthenticationButton?.call();
            },
            child: getAuthenticationImage()),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget getAuthenticationImage() {
    var logo;
    switch (widget.authenticationType) {
      case AuthenticationType.Touch:
        logo = SvgPicture.asset('assets/fingerprint-icon.svg', width: 32);
        break;
      case AuthenticationType.Face:
        logo = SvgPicture.asset('assets/face-id-icon.svg', width: 32);
        break;
      case AuthenticationType.FaceAndTouch:
        logo = SvgPicture.asset('assets/fingerprint-icon.svg', width: 32);
        break;
      default:
        logo = SizedBox();
    }
    return logo;
  }
}

class AnimationBoxPasscode extends StatefulWidget {
  final clear;
  final active;
  final value;

  const AnimationBoxPasscode({
    super.key,
    this.clear = false,
    this.active = false,
    this.value,
  });

  @override
  State<AnimationBoxPasscode> createState() => _AnimationBoxPasscodeState();
}

class _AnimationBoxPasscodeState extends State<AnimationBoxPasscode>
    with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clear) {
      animationController.forward(from: 0);
    }
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Container(
        margin: const EdgeInsets.only(left: 10, right: 15),
        child: Stack(
          children: [
            Container(),
            AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.active
                    ? HexColor('#DB771A')
                    : HexColor(
                        '#D9D9D9',
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
