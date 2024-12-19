import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

bool? checkPin(String? input) {
  if (input!.length != 6) {
    return false;
  } else {
    if (int.tryParse(input!) != null) {
      return true;
    } else {
      return false;
    }
  }
}

double? currentLatLngDoubleCopy(
  LatLng? currentLocation,
  bool? isLatitude,
) {
  if (isLatitude! == true) {
    return currentLocation!.latitude;
  } else {
    return currentLocation!.longitude;
  }
}

String? getBuildNumber(String? buildVersion) {
  // Find the index of the opening parenthesis
  int startIndex = buildVersion!.indexOf('(');

  // Find the index of the closing parenthesis
  int endIndex = buildVersion!.indexOf(')');

  // Extract the substring between the parentheses
  String numberString = buildVersion!.substring(startIndex + 1, endIndex);

  // Convert the extracted substring to an integer

  print(numberString); // Output: 21

  return numberString;
}

String? currentTimeToMonthThai(String? currentTime) {
  String? month = ''; //'${DateFormat.MMMM().format(currentTime!)}';
  Map<String, String> monthNames = {
    'January': 'มกราคม',
    'February': 'กุมภาพันธ์',
    'March': 'มีนาคม',
    'April': 'เมษายน',
    'May': 'พฤษภาคม',
    'June': 'มิถุนายน',
    'July': 'กรกฎาคม',
    'August': 'สิงหาคม',
    'September': 'กันยายน',
    'October': 'ตุลาคม',
    'November': 'พฤศจิกายน',
    'December': 'ธันวาคม',
  };

  String? monthNameInThai = monthNames[month];
  return monthNameInThai;
}

List<String>? sortingListByOrder(
  List<String>? somethingList,
  List<int>? orderList,
) {
  List<String> outputList = [];

  for (int i = 0; i < orderList!.length; i++) {
    outputList.add(somethingList![orderList!.indexOf(i + 1)]);
  }

  return outputList;
}

String? convertStringToImgPath(String? input) {
  return input!;
}

List<bool>? sortingBoolListByOrder(
  List<bool>? boolList,
  List<int>? orderList,
) {
  List<bool> outputList = [];

  for (int i = 0; i < orderList!.length; i++) {
    outputList.add(boolList![orderList!.indexOf(i + 1)]);
  }

  return outputList;
}

String? stringToImgPath(String? stringImageLink) {
  return stringImageLink;
}

List<String>? imgPathListToStringList(List<String>? somethingList) {
  return somethingList!;
}

DateTime? showClockIn(String? clockIn) {
  // Add your function code here!
  DateTime time = DateTime.parse('$clockIn');

  return time;
}

String? currentLengthOfWork(String? profileStartDate) {
  if (profileStartDate != null) {
    DateTime startDate = DateTime.parse(
        profileStartDate); // แปลงเป็น DateTime จากรูปแบบที่เก็บใน profileStartDate
    DateTime currentDate = DateTime.now(); // วันที่ปัจจุบัน
    Duration difference =
        currentDate.difference(startDate); // คำนวณความต่างระหว่างวันที่

    // คำนวณระยะเวลาเป็นปี เดือน หรือวัน
    int years = difference.inDays ~/ 365; // คำนวณเป็นปี
    int months = (difference.inDays % 365) ~/ 30; // คำนวณเป็นเดือน
    int days = (difference.inDays % 365) % 30; // คำนวณเป็นวัน

    return "$years Năm $months Tháng $days Ngày"; // ผลลัพธ์ที่ได้คืออายุงาน
  } else {
    return "Ngày bắt đầu công việc không hợp lệ";
  }
}

String? imgPathtoString(String? imgPath) {
  return "$imgPath";
}

String? convertImgPathToString(String? imgPathInput) {
  return '${imgPathInput!}';
}

bool? checkEnebleLocationDevice(LatLng? currentLocation) {
  LatLng defaultLocation = LatLng(0, 0);
  if (currentLocation! == defaultLocation) {
    return false;
  } else {
    return true;
  }
}

String? getLatLngFunction(
  LatLng? location,
  String? locationType,
) {
  if (locationType! == 'lat') {
    return '${location!.latitude}';
  } else {
    return '${location!.longitude}';
  }
}

LatLng? combineLatLngFunction(
  String? latitude,
  String? longitude,
) {
  return LatLng(double.parse(latitude!), double.parse(longitude!));
}

String? greetingTextSuperApp(String? name) {
  ///  return 'สวัสดี คุณ${name}';
  if (name == null) return 'Hello';

  // ตัดคำตามช่องว่างและดึงคำแรก
  String firstName = name.split(' ').first;

  return 'Xin chào bạn$firstName';
}

bool? checkYearHoliday(DateTime? dateNow) {
  int year = dateNow!.year;

  if (year == 2024) {
    return true;
  } else if (year == 2025) {
    return false;
  } else {
    return false;
  }
}

bool? checkSundayDate(DateTime? startDate) {
  if (startDate!.weekday == 7) {
    return true;
  } else {
    return false;
  }
}

bool? checkHolidayDate(
  DateTime? startDate,
  List<String>? holidayDatelist,
) {
  int numHoliday = 0;
  DateFormat dateFormat = new DateFormat('yyyy-MM-dd');
  String startDateStr = dateFormat.format(startDate!);

  for (int i = 0; i < holidayDatelist!.length; i++) {
    if (startDateStr == holidayDatelist[i]) {
      numHoliday++;
    }
  }
  if (numHoliday > 0) {
    return true;
  } else {
    return false;
  }
}

bool? checkYearLeave(DateTime? startDate) {
  int year = startDate!.year;

  if (year == 2025 || year == 2026) {
    return true;
  } else {
    return false;
  }
}

bool? checkSickLeaveIsBeforeCurrentDate(
  DateTime? currentDate,
  DateTime? leaveDate,
) {
  if (leaveDate!.isBefore(currentDate!)) {
    return true;
  } else {
    return false;
  }
}

bool? checkLeaveDayNumber(String? leaveDayNumber) {
  return leaveDayNumber!.contains('.');
}

bool? allowFileInput(
  String? leaveTypeInput,
  String? leaveDayInput,
) {
  bool result = true;
  if (leaveTypeInput == 'ลาป่วย' && int.parse(leaveDayInput!) >= 3) {
    result = true;
  } else if (leaveTypeInput == 'ลาป่วย' && int.parse(leaveDayInput!) < 3) {
    result = false;
  } else if (leaveTypeInput == 'ลาทำหมัน') {
    result = true;
  } else if (leaveTypeInput == 'ลาเพื่อรับราชการทหาร') {
    result = true;
  } else {
    result = false;
  }
  return result;
}

bool? containString(
  String? input,
  String? containText,
) {
  return containText!.contains(input!);
}

double? changeToDouble(String? input) {
  if (double.tryParse(input!) != null) {
    return double.tryParse(input!);
  } else {
    return 0.0;
  }
}

LatLng? stringToLatLng(
  String? latitude,
  String? longitude,
) {
  // var latdouble = double.parse(latitude!);
  // var lngdouble = double.parse(longitude!);

  return LatLng(double.parse(latitude!), double.parse(longitude!));
}

bool checkFormServiceUrl(String? formServiceUrl) {
  // Add your function code here!
  return formServiceUrl!.contains('spreadsheets');
}

String? stringToImgPathBanners(
  List<int>? orderList,
  int currentIndex,
  List<String>? bannerImageList,
) {
  int index = orderList!.indexOf(currentIndex + 1);
  return bannerImageList![index];

  //return bannerImageList[orderList.indexOf(currentIndex + 1)];
  //return stringToImgPathBanners(orderList, currentIndex, bannerImageList);
}

String? returnAllValueInList(List<DateTime>? inputList) {
  String output = '';

  for (int i = 0; i < inputList!.length; i++) {
    output = output + '${DateFormat('yyyy-MM-dd').format(inputList![i])}, ';
  }
  return '${output}';
}
