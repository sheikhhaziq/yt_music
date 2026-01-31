import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:yt_music/constants.dart';
import 'package:yt_music/modals/yt_config.dart';

class ProviderClient {
  final Dio _dio;
  ProviderClient({required Dio dio}) : _dio = dio;

  static Future<YTConfig?> getConfig() async {
    final response = await get(
      Uri.parse(Constants.baseUrl),
      headers: {HttpHeaders.userAgentHeader: Constants.userAgent},
    );
    final reg = RegExp(r'ytcfg\.set\s*\(\s*({.+?})\s*\)\s*;');
    RegExpMatch? matches = reg.firstMatch(response.body);
    if (matches != null) {
      final ytcfg = json.decode(matches.group(1).toString());
      return YTConfig(
        visitorData: ytcfg['VISITOR_DATA'],
        language: ytcfg['HL'],
        location: ytcfg['GL'],
        apiKey: ytcfg['INNERTUBE_API_KEY'],
        clientName: ytcfg['INNERTUBE_CLIENT_NAME'],
        clientVersion: ytcfg['INNERTUBE_CLIENT_VERSION'],
      );
    }
    return null;
  }

  Future<Map<String, dynamic>> post({
    required YTConfig config,
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? queryParams,
  }) async {
    final url = '${Constants.baseUrl}/youtubei/v1/$endpoint';

    final headers = {
      'Content-Type': 'application/json',
      HttpHeaders.userAgentHeader: Constants.userAgent,
      'accept-encoding': 'gzip, deflate',
      'content-type': 'application/json',
      'content-encoding': 'gzip',
      "Origin": "https://music.youtube.com",
      if (config.visitorData.isNotEmpty)
        'X-Goog-Visitor-Id': config.visitorData,
    };

    final payload = {
      'context': {
        'client': {
          'clientName': config.clientName,
          'clientVersion': config.clientVersion,
          'hl': config.language,
          'gl': config.location,
        },
      },
      ...body,
    };
    final res = await _dio.post(
      url,
      queryParameters: {'key': config.apiKey, ...?queryParams},
      data: jsonEncode(payload),
      options: Options(headers: headers),
    );

    if (res.data is! Map<String, dynamic>) {
      throw StateError('Unexpected response type');
    }

    return res.data as Map<String, dynamic>;
  }
}
