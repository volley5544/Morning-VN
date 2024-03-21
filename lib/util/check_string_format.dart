import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';
import 'package:mobile_application_srisawad/util/logger_service.dart';

bool isDateEmpty(String date) {
  if (date == '') {
    return false;
  }
  return false;
}

String formateDate(String latestPaidDate) {
  try {
    if (latestPaidDate == '') {
      return '';
    }
    var date = DateTime.parse(latestPaidDate);
    date = DateTime(date.year, date.month, date.day);
    String thaiDate = DateFormat('dd/MM/yyyy').format(date);
    return thaiDate;
  } catch (error) {
    logger.w('error occur when foating date $error');
    return '';
  }
}

String formateBudDate(String latestPaidDate) {
  try {
    if (latestPaidDate == '') {
      return '';
    }
    var date = DateTime.parse(latestPaidDate);
    date = DateTime(date.year + 543, date.month, date.day);
    String thaiDate = DateFormat('dd/MM/yyyy').format(date);
    return thaiDate;
  } catch (error) {
    logger.w('error occur when foating date $error');
    return '';
  }
}

DateTime formateBuddhistDate(String latestPaidDate) {
  var date = DateTime.parse(latestPaidDate);
  // DateFormat.yMd().format(DateTime.parse(latestPaidDate));
  date = DateTime(date.year + 543, date.month, date.day);

  return date;
}

String formateChristDate(String latestPaidDate) {
  var date = DateTime.parse(latestPaidDate);
  // DateFormat.yMd().format(DateTime.parse(latestPaidDate));
  date = DateTime(date.year - 543, date.month, date.day);
  String newDate = date.toIso8601String().replaceFirst('0', 'Z', 22);

  return newDate;
}

int parsingInt(String value) {
  try {
    return int.parse(value);
  } catch (e) {
    return 0;
  }
}

String formateTime(String latestPaidDate) {
  try {
    String time = DateFormat.Hm().format(DateTime.parse(latestPaidDate));
    List<String> split =
        DateFormat.Hm().format(DateTime.parse(latestPaidDate)).split(':');
    return split[0] + '.' + split[1];
  } catch (error) {
    return '';
  }
}

String formatThaiID(String id) {
  if (id.isNotEmpty) {
    return id.replaceAllMapped(RegExp(r'(\d{1})(\d{4})(\d{5})(\d{2})(\d+)'),
        (Match m) => "${m[1]}-${m[2]}-${m[3]}-${m[4]}-${m[4]}");
  }
  return "";
}

bool isStringDuplicate(String input) {
  final tmp = input.split('');
  final setTmp = tmp.toSet().toList().length;
  return tmp.length != setTmp && setTmp == 1;
}

String filterAddress(String value) {
  late String replaced = value;
  if (replaced.contains('- หมู่')) {
    replaced = replaced.replaceAll('- หมู่', 'หมู่').trim();
  }
  if (replaced.contains('หมู่ -')) {
    replaced = replaced.replaceAll('หมู่ - ', '').trim();
  }
  replaced.replaceAll('  ', '');
  if (replaced.contains('ซอย -')) {
    replaced = replaced.replaceAll('ซอย -', '').trim();
  }
  if (replaced.contains('ถนน -')) {
    replaced = replaced.replaceAll('ถนน -', '').trim();
  }
  return replaced.replaceAll('  ', ' ');
  ;
}

Uint8List getdDtaUrlImage(String data) {
  try {
    return base64Decode(data.replaceAll('data:image/png;base64,', ''));
  } catch (e) {
    logger.e('Caught error in getdDtaUrlImage :${e.toString()} ');
    return Uint8List(0);
  }
}

Widget renderLoanTypeIcon(data) {
  try {
    return SvgPicture.string(
      data.replaceAll('data:image/svg+xml;charset=utf-8,', ''),
      width: 52,
      height: 52,
    );
  } catch (e) {
    logger.e('Fail to render image in topup status detail ${e.toString()}');
    return Container();
  }
}

extension FormatExtenstion on String? {
  String formatPhoneNumber() {
    if (this != null && this!.isNotEmpty) {
      return this!.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'),
          (Match m) => "${m[1]}-${m[2]}-${m[3]}");
    }
    return "";
  }
}

extension BankFormatExtenstion on String? {
  String bankName() {
    switch (this) {
      case 'BBL':
        return 'ธนาคารกรุงเทพ';
      case 'TTB':
        return 'ธนาคารทีเอ็มบีธนชาต';
      case 'LHB':
        return 'ธนาคารแลนด์ แอนด์ เฮ้าส์';
      case 'SCBT':
        return 'ธนาคารสแตนดาร์ดชาร์เตอร์ด (ไทย)';
      case 'IBANK':
        return 'ธนาคารอิสลามแห่งประเทศไทย';
      case 'GHB':
        return 'ธนาคารอาคารสงเคราะห์';
      case 'GSB':
        return 'ธนาคารออมสิน';
      case 'EXIM':
        return 'ธนาคารเพื่อการส่งออกและนำเข้าแห่งประเทศไทย';
      case 'BAAC':
        return 'ธนาคารเพื่อการเกษตรและสหกรณ์การเกษตร';
      case 'KTB':
        return 'ธนาคารกรุงไทย';
      case 'UOB':
        return 'ธนาคารยูโอบี';
      case 'TBANK':
        return 'ธนาคารธนชาต';
      case 'SCB':
        return 'ธนาคารไทยพาณิชย์';
      case 'TISCO':
        return 'ธนาคารทิสโก้';
      case 'CIMB':
        return 'ธนาคารซีไอเอ็มบีไทย';
      case 'KK':
        return 'ธนาคารเกียรตินาคิน';
      case 'KBANK':
        return 'ธนาคารกสิกรไทย';
      case 'BAY':
        return 'ธนาคารกรุงศรีอยุธยา';
      case 'TMB':
        return 'ธนาคารทหารไทย';
      case 'TNC':
        return 'ธนาคารธนชาต';
      default:
        return this!;
    }
    // return '';
  }
}
