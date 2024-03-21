import 'dart:convert' as convert;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart' as httpIntercepter;
import 'package:mobile_application_srisawad/modules/http_interceptor.dart';
import '../util/logger_service.dart';

final DEPLOYED_BASE_URL = dotenv.env['SRISAWAD_APP_DEPLOYED'];

class Service {
  // get, post
  final String method;
  Service({required this.method});
// final loggerService = LoggerService();

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      method: json['method'],
    );
  }

  static Future<dynamic> rest(
      {required String method,
      required String url,
      Object? body,
      Map<String, String>? headers,
      Map<String, String>? query}) async {
    try {
      final http.BaseClient httpClient;

      await dotenv.load(fileName: ".env");
      final fullUrl = (DEPLOYED_BASE_URL! + url);
      http.Response response;
      httpIntercepter.InterceptedClient client =
          httpIntercepter.InterceptedClient.build(
        interceptors: [
          HttpInterceptor(),
        ],
      );

      logger.d(
          "caliling back-end with method: '$method' $fullUrl body: '$body' query: '$query'");
      switch (method) {
        case 'get':
          response = await client.get(
              Uri.parse(fullUrl).replace(queryParameters: query),
              headers: headers);
              print('response.body');
              print(response.body);
          break;
        case 'post':
          response = await client.post(
            Uri.parse(fullUrl),
            headers: headers,
            body: body,
          );
          print('response.request');
          print(response.request);
          break;
        default:
          response = await client.get(Uri.parse(fullUrl));
          break;
      }
      logger.d('back-end called ${response.statusCode} from ${url}');
      return {'res': response.body, 'status': response.statusCode};
    } catch (e) {
      logger.e('Error during connecting to back-end $e from ${url}');
      return {'res': {}, 'status': ''};
    }
  }

  static Future<http.StreamedResponse> restMultipart(
      {required String url,
      required List<String> filepaths,
      Object? body,
      Map<String, String>? headers,
      Map<String, String>? query}) async {
    await dotenv.load(fileName: ".env");
    final fullUrl = (DEPLOYED_BASE_URL! + url);
    logger.d("caliling back-end with method:  $fullUrl $body'");
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
    request.files.add(await http.MultipartFile.fromPath('file', filepaths[0],
        contentType: new MediaType('image', 'jpeg')));
    request.headers.addAll(headers!);
    var response = (await request.send());
    return response;
  }
}
