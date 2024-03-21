import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:io' as io;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_application_srisawad/main.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as localStorage;
import '../../connector/authentication/login_function.dart';
import '../../connector/cloud_storage.dart';
import '../../connector/firestore/notify.dart';
import '../../modules/authLogin/index.dart';
import '../../modules/authRegister/index.dart';
import '../../modules/userProfile/index.dart';
import '../../services/display_image.dart';
import '../../services/notification.dart';
import '../../util/custom_exception.dart';
import '../../util/device_id.dart';
import '../../widgets/dialog/login_error.dart';
import '../../widgets/dialog/server_suspended_dialog.dart';
import '../user_profile/user_profile_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc()
      : super(RegisterInitial(
            '', '', '', '', '', '', '', '', '', '', '', '', false)) {
    on<GetDataFromField>((event, emit) async {
      //try {
      emit(RegisterLoading(
          state.thaiId,
          state.phoneNumber.toString(),
          state.firstname,
          state.lastname,
          state.dob,
          state.address,
          state.province,
          state.district,
          state.subdistrict,
          state.poscode,
          state.email,
          state.lineid,
          false));
      emit(RegisterComplete(
          event.thaiId,
          event.phoneNumber.toString(),
          event.firstname,
          event.lastname,
          event.dob,
          event.address,
          event.province,
          event.district,
          event.subdistrict,
          event.poscode,
          event.email,
          event.lineid,
          false));
    });
  }
}
