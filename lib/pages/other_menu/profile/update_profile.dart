import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_application_srisawad/bloc/user_profile/user_profile_bloc.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/modules/userProfile/index.dart';
import 'package:mobile_application_srisawad/widgets/fields/profile_fields.dart';

import '../../../widgets/loan_widgets/bootom_button.dart';

class UpdateProfile extends StatefulWidget {
  final String userThaiId;

  const UpdateProfile({Key? key, required this.userThaiId}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  // final Map<String, dynamic> value;
  // const UpdateProfile({super.key, required this.value});

  UserProfile userProfile = UserProfile();
  String lineId = '';
  String email = '';
  bool shouldShowEmailWarning = false;

  @override
  void initState() {
    var userProfileBloc = context.read<UserProfileBloc>();
    email = userProfileBloc.state.userProfileData.email!;
    lineId = userProfileBloc.state.userProfileData.lineId!;
    super.initState();
  }

  void setEmail(String value) {
    setState(() {
      email = value;
      setShouldShowEmailWarning(false);
    });
  }

  Future<void> updateData() async {
    context.read<UserProfileBloc>().add(UpdateUserProfile(
        email: email,
        id: widget.userThaiId,
        lineId: lineId,
        userProfile: userProfile,
        context: context));
  }

  bool isEmailValid() {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid || email.isEmpty;
  }

  void setShouldShowEmailWarning(bool shouldShowEmailWarning) {
    if (this.shouldShowEmailWarning != shouldShowEmailWarning) {
      setState(() {
        this.shouldShowEmailWarning = shouldShowEmailWarning;
      });
    }
  }

  void setLineId(String value) {
    setState(() {
      lineId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              color: Colors.white,
              width: getActualWidth(context),
              height: MediaQuery.of(context).size.height,
              child: Container(
                  child: BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (profileContext, state) {
                  return Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(22, 25, 11, 0),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Container(
                                      child: Positioned(
                                        top: -10,
                                        left: 22 - 38,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/back-icon.svg',
                                            height: 38,
                                            width: 38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                        child: Text('แก้ไขข้อมูลติดต่ออื่นๆ',
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium
                                                ?.merge(const TextStyle(
                                                    fontFamily:
                                                        'NotoSansThaiSemiBold')))),
                                  ]),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 20,
                                          child: Container(
                                              width: 4,
                                              decoration: BoxDecoration(
                                                  color: const Color(0xFFDB771A)
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              20))))),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'ข้อมูลติดต่ออื่นๆ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.merge(const TextStyle(
                                                fontFamily:
                                                    'NotoSansThaiSemiBold')),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          EditProfileFields(
                                            initialValue: email,
                                            keyName: 'อีเมล',
                                            onChangeText: (e) => setEmail(e),
                                            isWarning: shouldShowEmailWarning,
                                            max: 255,
                                            hint: 'ระบุอีเมล (ไม่บังคับ)',
                                          ),
                                          EditProfileFields(
                                            initialValue: lineId,
                                            keyName: 'ไลน์ไอดี (LINE ID)',
                                            onChangeText: (e) => setLineId(e),
                                            isWarning: false,
                                            isLineID: true,
                                            max: 20,
                                            hint: 'ระบุไลน์ไอดี (ไม่บังคับ)',
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]);
                },
              ))),
          Positioned.fill(
            top: MediaQuery.of(context).size.height - 90,
            child: Container(
              width: getActualWidth(context),
              child: BootomButton(
                decoration: false,
                width: double.infinity,
                onButtonTap: () async {
                  if (isEmailValid()) {
                    await updateData();
                    Navigator.pushNamed(context, '/settings/profile');
                  } else {
                    setShouldShowEmailWarning(true);
                  }
                },
                title: 'บันทึก',
              ),
            ),
          )
        ],
      ),
    );
  }
}
