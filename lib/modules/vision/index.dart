import 'dart:io';
import 'dart:convert' as convert;
import 'package:mobile_application_srisawad/models/ocr_vision.dart';
import 'package:mobile_application_srisawad/modules/service.dart';
import 'package:mobile_application_srisawad/services/localStorage/local_storage.dart'
    as localStorage;

class Vision {
  final String rootEndpoint = 'vision';

  Future<OcrThaiId> getThaiId(String filename) async {
    final response = await Service.restMultipart(
        url: '$rootEndpoint/thai-id',
        filepaths: [filename],
        headers: {"x-srisawad": "x1"});
    if (response.statusCode.toString() == '200') {
      OcrThaiId thaiId = OcrThaiId.fromJson(
        convert.jsonDecode(await response.stream.bytesToString() as dynamic),
      );
      return thaiId;
    }

    return OcrThaiId(thaiId: '');
  }
}
