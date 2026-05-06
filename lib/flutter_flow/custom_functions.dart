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

int? checkYearHolidayCopy(
  DateTime? dateNow,
  String? appLanguage,
) {
  int year = dateNow!.year;

  if (appLanguage! == 'th') {
    return year + 543;
  } else {
    return year;
  }
}

String? currentTimeToMonthNumber(DateTime? currentTime) {
  String? month = DateFormat.MMMM().format(currentTime!);
  Map<String, String> monthLists = {
    'January': '01',
    'February': '02',
    'March': '03',
    'April': '04',
    'May': '05',
    'June': '06',
    'July': '07',
    'August': '08',
    'September': '09',
    'October': '10',
    'November': '11',
    'December': '12',
  };

  String? monthNumber = monthLists[month];
  return monthNumber;
}

String? returnAllValueI(List<DateTime>? inputList) {
  String output = '';

  for (int i = 0; i < inputList!.length; i++) {
    //output = output + '${DateFormat('yyyy-MM-dd').format(inputList![i])}, ';
    output = '${DateFormat('yyyy-MM-dd').format(inputList![0])}';
  }
  return '${output}';
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

String? currentDayLengthOfWork(String? profileStartDate) {
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

    return "$days"; // ผลลัพธ์ที่ได้คืออายุงาน
  } else {
    return "Ngày bắt đầu công việc không hợp lệ";
  }
}

String? currentMonthLengthOfWork(String? profileStartDate) {
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

    return "$months"; // ผลลัพธ์ที่ได้คืออายุงาน
  } else {
    return "Ngày bắt đầu công việc không hợp lệ";
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

String? currentTimeToMonthThai(DateTime? currentTime) {
  String? month = DateFormat.MMMM().format(currentTime!);
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

String? currentYearLengthOfWork(String? profileStartDate) {
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

    //return "$years Năm $months Tháng $days Ngày"; // ผลลัพธ์ที่ได้คืออายุงาน
    return "$years";
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

  return '$firstName';
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

bool? checkYearLeave(List<DateTime> leaveDateList) {
  //int year = startDate!.year;

  // if (year == 2024 || year == 2025) {
  //   return true;
  // } else {
  //   return false;
  //}

  // ใช้ลูป for เพื่อตรวจสอบปีของแต่ละ DateTime
  for (var date in leaveDateList) {
    int year = date.year;
    if (year == 2024 || year == 2025) {
      return true;
    }
  }
  return false;
}

bool? checkSickLeaveIsBeforeCurrentDate(
  DateTime? currentDate,
  List<DateTime> leaveDateList,
) {
  // ตรวจสอบว่า leaveDate ทุกค่าอยู่ก่อน currentDate หรือไม่
  for (var leaveDate in leaveDateList) {
    if (!leaveDate.isBefore(currentDate!)) {
      return false; // หาก leaveDate ใดๆ ไม่อยู่ก่อน currentDate ให้คืน false
    }
  }

  return true;
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

bool? checkPhoneNumber10(String? phoneNumber) {
  if (phoneNumber!.length <= 10) {
    return true;
  } else {
    return false;
  }
}

String leaveTypeToLeaveId(String? leaveType) {
  // Add your function code here!
  String result = '';
  if (leaveType == 'ลาป่วย') {
    result = '1';
  }
  if (leaveType == 'ลากิจ') {
    result = '2';
  }
  if (leaveType == 'ลาพักร้อน') {
    result = '3';
  }
  if (leaveType == 'ลาอุปสมบท') {
    result = '4';
  }
  if (leaveType == 'ลาเพื่อรับราชการทหาร') {
    result = '5';
  }
  if (leaveType == 'ลาคลอด') {
    result = '6';
  }
  if (leaveType == 'ลาทำหมัน') {
    result = '7';
  }
  if (leaveType == 'ลาโดยไม่รับค่าตอบแทน') {
    result = '8';
  }
  if (leaveType == 'ลาออก') {
    result = '9';
  }
  return result;
}

String? startLeaveDayString(List<DateTime>? startLeaveDayInput) {
  if (startLeaveDayInput != null && startLeaveDayInput.isNotEmpty) {
    String result = DateFormat('yyyy-MM-dd').format(startLeaveDayInput[0]);
    return result;
  }
  return null; // หรือค่าที่เหมาะสมในกรณีที่เป็น null หรือ empty
}

String? endLeaveDayCalString(
  List<DateTime>? startLeaveDayList,
  int? dayLeaveNumber,
  String? leaveTime,
) {
  DateTime startLeaveDay = startLeaveDayList!.last;
  String result = '';

  if (leaveTime == 'ลาเต็มวัน') {
    //DateTime endLeaveDay =
    //    startLeaveDay!.add(Duration(days: dayLeaveNumber! - 1));
    // Add your function code here!
    //result = DateFormat('yyyy-MM-dd').format(endLeaveDay);

    result = DateFormat('yyyy-MM-dd').format(startLeaveDay!);
  } else {
    // Add your function code here!
    result = DateFormat('yyyy-MM-dd').format(startLeaveDay!);
  }
  return result;
}

List<String> convertListDatetimeToListString(
    List<DateTime>? selectedDatesList) {
  //return selectedDatesList
  //        ?.map((date) => DateFormat('yyyy-MM-dd').format(date))
  //        .toList() ??
  //    [];

  List<String> output = [];

  for (int i = 0; i < selectedDatesList!.length; i++) {
    output.add('${DateFormat('yyyy-MM-dd').format(selectedDatesList![i])}');
  }
  return output;
}

String? imgPathListToString(List<String>? imgPathList) {
  if (imgPathList == null) {
    return "";
  }
  String namesString = '';

  for (String name in imgPathList!) {
    namesString += name + ',';
  }

// Remove the last comma
  namesString = namesString.substring(0, namesString.length - 1);

  return namesString;
}

Color? getResignCardColor(
  String? leaveName,
  Color? resignCardColor,
) {
  Color cardColor = Colors.white;

  if (leaveName! == 'ลาออก') {
    cardColor = resignCardColor!;
  }

  return cardColor;
}

String? showMatNameInList(
  List<String>? materialNameList,
  int? index,
) {
  // Add your function code here!
  return '${materialNameList![index!]}';
}

List<String> reverseList(List<String>? somethingList) {
  // Add your function code here!
  //List<String> reverseList = somethingList!.reversed;
  return somethingList!.reversed.toList();
}

double? contrainerChange(double? contrainerHeight) {
  WidgetsFlutterBinding.ensureInitialized();
  double deviceTextScaleFactor =
      WidgetsBinding.instance!.window.textScaleFactor;
  return (contrainerHeight! * deviceTextScaleFactor);
}

String? getLeavePeriod(String? leaveTime) {
  if (leaveTime == "full") {
    return "full";
  } else {
    return "half";
  }
}

String? getMonthFromJson(
  List<dynamic> jsonList,
  int inputIndex,
) {
  // ตรวจสอบว่า inputIndex มีค่าไม่เป็น null และอยู่ในช่วงที่ถูกต้อง
  if (inputIndex != null && inputIndex >= 1 && inputIndex <= jsonList.length) {
    // ดึงข้อมูลตาม index ที่กำหนด (จำเป็นต้องลบ 1 เพราะ index ใน List เริ่มจาก 0)
    var item = jsonList[inputIndex - 1];
    // คืนค่าชื่อของ item ที่ดึงมา
    return 'ข้อมูลที่คุณเลือก: ${item['name']}';
  } else {
    return 'กรุณาใส่ค่า input ที่อยู่ในช่วง 1 ถึง ${jsonList.length}';
  }
}

List<bool>? createFalseList(
  bool? value,
  int? listLength,
) {
  List<bool> output = List.filled(listLength!, value!);

  return output;
}

List<String> returnMapListFromBoolList(
  List<String>? somethingList1,
  List<bool>? somethingList2,
  bool? searchValue,
) {
  List<String> mappedList = [];

  for (int i = 0; i < somethingList1!.length; i++) {
    if (searchValue! == somethingList2![i]) {
      mappedList.add(somethingList1![i]);
    }
  }

  return mappedList;
}

String headApproveToStringFunction(List<String>? headApproveList) {
  if (headApproveList == null) {
    return "";
  }
  String namesString = '';

  for (String name in headApproveList!) {
    namesString += name + ',';
  }

// Remove the last comma
  namesString = namesString.substring(0, namesString.length - 1);

  return namesString;
}

bool? containWordinStringUrl(
  String? word,
  String? url,
) {
  if (url!.contains(word!)) {
    return true;
  } else {
    return false;
  }
}

int? countTrueInBoolList(List<String>? booleanList) {
  int trueCount = booleanList!.where((element) => element == true).length;

  return trueCount;
}

List<String>? leaveStringImgToImgPathList(String? leaveStringImg) {
  List<String> listStr = leaveStringImg!.split(',').toList();
  return listStr;
}

String? countLeaveDateSelectedByYear(
  List<DateTime>? selectedDateList,
  String? currentYear,
  String? otherYear,
  bool? returnCurrentYearCount,
) {
  int currentYearSelectedCount = 0;
  int otherYearSelectedCount = 0;

  for (int i = 0; i < selectedDateList!.length; i++) {
    if ('${selectedDateList![i].year}' == currentYear!) {
      currentYearSelectedCount++;
    } else {
      otherYearSelectedCount++;
    }
  }
  if (returnCurrentYearCount!) {
    return '$currentYearSelectedCount';
  } else {
    return '$otherYearSelectedCount';
  }
}

List<String> convertStringListToImgPathList(List<String>? inputList) {
  return inputList!;
}

String? currentTimeToYearNumber(DateTime? currentTime) {
  String? year = DateFormat.MMMM().format(currentTime!);
  Map<String, String> yearLists = {
    'Currentyear': '01',
    'Previousyear': '02',
    'Nextyear': '03',
  };

  String? yearNumber = yearLists[year];
  return yearNumber;
}

List<String> converApproveOneSaveFunction(String? idLeave) {
  List<String> output = [];
  if (idLeave != null) {
    output.add(idLeave); // เพิ่มค่า idLeave เข้าไปใน List
  }
  return output;
}

String? floorNumberFunction(String? value) {
  double? number = double.tryParse(value!) ?? 0; // แปลง String เป็น double
  int result = number.floor(); // ใช้ floor() เพื่อปัดลง
  return result.toString(); // แปลง int กลับเป็น String
}

String? encodingJson(dynamic jsonInput) {
  String output = jsonEncode(jsonInput!);
  return output;
}

dynamic decodingJson(String? stringJson) {
  dynamic output = jsonDecode(stringJson!);

  return output;
}

String? showDateBE(String? inputDateStr) {
  DateTime inputDate = DateTime.parse(inputDateStr!);
  DateTime newDate =
      DateTime(inputDate!.year + 543, inputDate!.month, inputDate!.day);

  // Create a DateFormat instance with the Thai locale and B.E. era
//   final thaiDateFormat = DateFormat.yMd('th').add_y();
  final thaiDateFormat = DateFormat('dd/MM/y');

  // Format the date in Thai style with B.E. era
  String formattedDate = thaiDateFormat.format(newDate);

  print(formattedDate); // Output: "13 กุมภาพันธ์ 2539"
  return formattedDate;
}

List<LatLng>? makeLatLngList(
  List<String>? lat,
  List<String>? lng,
) {
  if (lat == null || lng == null || lat.length != lng.length) {
    return null; // Return null if lists are null or lengths don't match
  }

  List<LatLng> result = [];
  for (int i = 0; i < lat.length; i++) {
    double? latitude = double.tryParse(lat[i]);
    double? longitude = double.tryParse(lng[i]);

    if (latitude != null && longitude != null) {
      result.add(LatLng(latitude, longitude));
    }
  }

  return result;
}

List<DateTime>? generateListLast30dateTime(String? selectedDate) {
  final currentDate = DateTime.parse(selectedDate!);

  // Generate a list of the last 30 days
  final last30Days = List.generate(
    30,
    (index) => currentDate.subtract(Duration(days: index)),
  );
  //print(last30Days);
  return last30Days;
}

DateTime? parseStringToDateTime(String? datetimeStr) {
  return DateTime.parse(datetimeStr!);
}

String? showDateChrist(String? inputDateStr) {
  DateTime inputDate = DateTime.parse(inputDateStr!);
  // DateTime newDate =
  // DateTime(inputDate!.year + 543, inputDate!.month, inputDate!.day);

  // Create a DateFormat instance with the Thai locale and B.E. era
//   final thaiDateFormat = DateFormat.yMd('th').add_y();
  final christDateFormat = DateFormat('dd/MM/y');

  // Format the date in Thai style with B.E. era
  String formattedDate = christDateFormat.format(inputDate);

  print(formattedDate); // Output: "13 กุมภาพันธ์ 2539"
  return formattedDate;
}

String? getDateFormat(DateTime? inputDate) {
  return DateFormat('yyyy-MM-dd').format(inputDate!);
  ;
}

bool? containStringInListString(
  List<String>? inputListString,
  String? valueString,
) {
  return inputListString!.contains(valueString!);
}

int? getIndexOfSomethingList(
  List<String>? somethingList,
  String? somethingValue,
) {
  return somethingList!.indexOf(somethingValue!);
}

bool? checkChangLocationFunction(
  List<String>? empList,
  String? empID,
) {
  if (empList! == null || empID! == null) {
    return null;
  }

  if (empList!.contains(empID!)) {
    return true;
  } else {
    return false;
  }
}

bool? getSpecificIndexFromJson(
  dynamic jsonData,
  String? menuName,
  String? level,
) {
  if (jsonData == null) {
    print('Invalid input: jsonData ');
    return false;
  }

  try {
    // Check if jsonData is already a Map
    Map<String, dynamic> jsonMap;
    if (jsonData is String) {
      // If jsonData is a string, decode it to a Map
      jsonMap = jsonDecode(jsonData);
    } else if (jsonData is Map<String, dynamic>) {
      // If jsonData is already a Map, use it directly
      jsonMap = jsonData;
    } else {
      print('Invalid jsonData type.');
      return false;
    }
    String? listMenuVisible = '';
    String? listMenuName = 'menuName';
    switch (level) {
      case 'HO':
        listMenuVisible = 'menuHO';
        break;
      case 'branch':
        listMenuVisible = 'menuBranch';
        break;
      case 'ASM':
        listMenuVisible = 'menuASM';
        break;
      case 'GBM':
        listMenuVisible = 'menuGBM';
        break;
      case 'Assistant':
        listMenuVisible = 'menuAssistant';
        break;
      case 'Region':
        listMenuVisible = 'menuRegion';
        break;
      case 'Area':
        listMenuVisible = 'menuArea';
        break;
      case 'Branch':
        listMenuVisible = 'menuBranch';
        break;
      default:
        listMenuVisible = ''; // Optional: Handle unexpected values
    }

    // Check if the listMenuVisible exists in the map and is a List
    if (jsonMap.containsKey(listMenuVisible) &&
        jsonMap[listMenuVisible] is List) {
      List<dynamic> rawData = jsonMap[listMenuVisible] as List<dynamic>;

      // Check if the listMenuName exists in the map and is a List
      if (listMenuName != null &&
          jsonMap.containsKey(listMenuName) &&
          jsonMap[listMenuName] is List) {
        List<dynamic> rawData2 = jsonMap[listMenuName] as List<dynamic>;

        // Convert List<dynamic> to List<bool>
        List<bool> data = rawData.map((item) => item == true).toList();
        //print('dataFromJson: $data');

        // Check for valid index and that menuName is present in rawData2
        if (rawData2.contains(menuName)) {
          int menuIndex = rawData2.indexOf(menuName);

          // Return the boolean value at the calculated index
          if (menuIndex >= 0 && menuIndex < data.length) {
            return data[menuIndex];
          } else {
            print('menuName index is out of range.');
            return false;
          }
        } else {
          print('Index or menuName is invalid.');
          return false;
        }
      } else {
        print('listMenuName not found or not a list.');
        return false;
      }
    } else {
      print('listMenuVisible not found or not a list.');
      return false;
    }
  } catch (e) {
    // Print error if JSON decoding fails
    print('Error decoding JSON: $e');
    return false;
  }
}

dynamic getListDataFromJsonList(
  dynamic jsonData,
  String? listName,
) {
  Map<String, dynamic> mapDataInput = jsonDecode(jsonData!);
  dynamic jsonOutput = jsonEncode(mapDataInput[listName!]);
  return jsonOutput;
}

bool? containsValueInJsonList(
  dynamic listFromJson,
  String? value,
  String? listName,
) {
  dynamic inputList = jsonDecode(listFromJson!);

  return inputList[listName!].contains(value!);
}

DateTime? parseStringToDatetime(String? datetimeStr) {
  return DateTime.parse(datetimeStr!);
}

String? showNumberWithComma(String? number) {
  if ('${number}' == 'null' ||
      '${number}' == '' ||
      number == null ||
      int.tryParse('${number}') == null) {
    return '0';
  }
  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  String result = '$number'.replaceAllMapped(reg, mathFunc);

  return result;
}

bool? checkPhoneNumberChar(String? text) {
  bool isPhoneNumber = false;

  if ((text!.length == 9 || text.length == 10) && (text![0] == "0")) {
    isPhoneNumber = true;
  }
  return isPhoneNumber;
}

String? showCensorPhoneNumber(String? phoneNumber) {
  if (phoneNumber!.length == 10) {
    return '${phoneNumber![0]}${phoneNumber![1]}${phoneNumber![2]}-${phoneNumber![3]}${phoneNumber![4]}${phoneNumber![5]}-XXXX';
  } else {
    return '-';
  }
}

String? returnNumberWithComma2Decimal(String? number) {
  if ('${number}' == 'null' ||
      '${number}' == '' ||
      number == null ||
      int.tryParse(number.replaceAll('-', '')) == null) {
    return '0.00';
  }

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  String result = '${double.parse(number!).toStringAsFixed(2)}'
      .replaceAllMapped(reg, mathFunc);

  return result!;
}

List<CollectionDataModelStruct>? selectedListSave(
  List<CollectionDataModelStruct>? allList,
  List<bool>? selectedList,
) {
  if (allList == null || selectedList == null) return null;

  List<CollectionDataModelStruct> result = [];

  for (int i = 0; i < allList.length && i < selectedList.length; i++) {
    if (selectedList[i] == true) {
      result.add(allList[i]);
    }
  }

  return result;
}

int? countTrueInList(List<bool>? selectedList) {
  if (selectedList == null) return null;

  return selectedList.where((item) => item == true).length;
}

String? checkNullValueAndReturn(String? value) {
  String text = '';
  if (value! == 'null') {
    text = '-';
  } else {
    text = value!;
  }

  return text;
}

String? removeCommaFromNumText(String? numberText) {
  String result = numberText!.replaceAll(RegExp('[^A-Za-z0-9.]'), '');

  return result;
}
