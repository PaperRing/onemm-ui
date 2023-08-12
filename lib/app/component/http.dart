import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class Http {
  Http._();

  static final Http I = Http._();

  var dio = new Dio();

  Future<dynamic> post(
    String url, {
    dynamic body,
    Map<String, String>? header,
    required bool decode,
  }) async {
    final response = await http.post(Uri.parse(url), body: body, headers: header ?? {});

    try {
      if (response.statusCode != 200) {
        print('ERROR------- $url');
        print('status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }

    return decode ? json.decode(response.body) : response.body;
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? query,
    required bool decode,
  }) async {
    final response = await http.get(Uri.parse(url).replace(queryParameters: query ?? {}));

    if (response.statusCode != 200) {
      print('ERROR------- $url');
      print('status: ${response.statusCode}');
    } else if (response.statusCode == 404) {
      String body = '';
      return body;
    }
    if (response.body.isNotEmpty) {
      jsonDecode(utf8.decode(response.bodyBytes));
    }
    return decode ? jsonDecode(utf8.decode(response.bodyBytes)) : response.body;
  }

  Future<dynamic> delete(
    String url, {
    Map<String, String>? header,
    required bool decode,
  }) async {
    final response = await http.delete(Uri.parse(url));

    try {
      if (response.statusCode != 200) {
        print('ERROR------- $url');
        print('status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    return decode ? json.decode(response.body) : response.body;
  }

  Future<dynamic> update(
    String url, {
    dynamic body,
    Map<String, String>? header,
    required bool decode,
  }) async {
    final response = await http.put(Uri.parse(url), body: body, headers: header);

    try {
      if (response.statusCode != 200) {
        print('ERROR------- $url');
        print('status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    return decode ? json.decode(response.body) : response.body;
  }

  Future<dynamic> putS3(
    String url, {
    Map<String, String>? header,
    dynamic input,
  }) async {
    var dio = new Dio();
    try {
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          input,
          contentType: new MediaType("image", "jpeg"),
        ),
      });

      // filename: input.split("/")[6],

      //
      // dio.options.contentType = 'multipart/form-data';
      // dio.options.maxRedirects.isFinite;

      var response = await dio.put(
        url,
        data: formData,
      );
      print('성공적으로 업로드했습니다');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  sendFile(String url, File image) async {
    var len = await image.length();
    var response = await dio.put(url,
        data: image.openRead(),
        options: Options(headers: {
          Headers.contentLengthHeader: len,
          "Content-Type": "image/jpg",
        } // set content-length
            ));
    return response;
  }
}
