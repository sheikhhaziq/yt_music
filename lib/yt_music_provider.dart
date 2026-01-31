import 'package:dio/dio.dart';
import 'package:gyawun_services/gyawun_services.dart';
import 'package:yt_music/constants.dart';
import 'package:yt_music/modals/yt_browse_payload.dart';
import 'package:yt_music/modals/yt_config.dart';
import 'package:yt_music/modals/yt_continuation_payload.dart';
import 'package:yt_music/parsers/browse_parser.dart';
import 'package:yt_music/provider_client.dart';

class YtMusicProvider extends MusicProvider {
  @override
  String get id => Constants.providerId;

  @override
  String get name => Constants.providerName;

  bool initialized = false;

  late final Dio _dio;

  ProviderClient? _providerClient;
  YTConfig? _config;

  YtMusicProvider() {
    _dio = Dio();
  }

  @override
  Future<Map<String, dynamic>> initialize([
    Map<String, dynamic>? configMap,
  ]) async {
    if (configMap != null) {
      final config = YTConfig.fromJson(configMap);
      _providerClient = ProviderClient(dio: _dio);
      _config = config;
      initialized = true;
      return config.toJson();
    }
    YTConfig? config = await ProviderClient.getConfig();

    config ??= YTConfig(
      visitorData: "",
      language: Constants.defaultLanguage,
      location: Constants.defaultLocation,
      apiKey: Constants.defaultApiKey,
      clientName: Constants.defaultClientName,
      clientVersion: Constants.defaultClientVersion,
    );
    _providerClient = ProviderClient(dio: _dio);
    _config = config;
    initialized = true;
    return config.toJson();
  }

  @override
  Future<BrowseResult> browse(BrowsePayload? payload) async {
    final limit = 1;
    if (!initialized) {
      throw StateError('Provider not initialized');
    }
    payload ??= YtBrowsePayload(params: {'browseId': 'FEmusic_home'});
    if (payload is! YtBrowsePayload) {
      throw ArgumentError('Invalid payload type');
    }
    final json = await _providerClient!.post(
      config: _config!,
      endpoint: 'browse',
      body: {if (payload.params.isNotEmpty) ...payload.params},
    );
    final result = BrowseParser.parse(json);
    if (result == null) {
      throw StateError('Failed to parse browse result');
    }
    if (result.sections.length < limit) {
      int l = limit - result.sections.length;
      ContinuationPayload? payload = result.continuationPayload;
      final sections = result.sections;
      while (l > 0 && payload != null) {
        final res = await browseContinuation(payload);
        sections.addAll(res.sections);
        payload = res.continuationPayload;
        l -= res.sections.length;
      }
      result.copyWith(sections: sections, continuationPayload: payload);
    }
    return result;
  }

  @override
  Future<BrowseContinuationResult> browseContinuation(
    ContinuationPayload payload,
  ) async {
    if (!initialized) {
      throw StateError('Provider not initialized');
    }
    if (payload is! YtContinuationPayload) {
      throw ArgumentError('Invalid payload type');
    }
    final json = await _providerClient!.post(
      config: _config!,
      endpoint: 'browse',
      body: {"browseId": "FEmusic_home"},
      queryParams: {'continuation': payload.continuation},
    );
    final result = BrowseParser.parseContinuation(json);

    return result;
  }
}
