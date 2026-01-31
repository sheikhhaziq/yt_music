import 'package:gyawun_services/gyawun_services.dart';
import 'package:yt_music/modals/yt_browse_payload.dart';
import 'package:yt_music/modals/yt_playback_payload.dart';
import 'package:yt_music/parsers/utils/helpers.dart';
import 'package:yt_music/parsers/utils/item_type_entension.dart';
import 'package:yt_music/parsers/utils/traverse.dart';

class ItemParser {
  static ProviderItem? parse(dynamic json, {List<Thumbnail>? thumbs}) {
    if (json['musicResponsiveListItemRenderer'] != null) {
      return _musicResponsiveListItemRenderer(
        json['musicResponsiveListItemRenderer'],
        thumbs: thumbs,
      );
    }
    if (json['musicTwoRowItemRenderer'] != null) {
      return _musicTwoRowItemRenderer(json['musicTwoRowItemRenderer']);
    }
    print(json.keys.toList());
    return null;
  }

  static ProviderItem _musicResponsiveListItemRenderer(
    dynamic json, {
    List<Thumbnail>? thumbs,
  }) {
    final flexColumnsJson = json['flexColumns'];
    final titlejson =
        flexColumnsJson[0]['musicResponsiveListItemFlexColumnRenderer'];
    final titleRun = titlejson['text']['runs'][0];
    final title = titleRun['text'];
    final navigationEndpoint = titleRun['navigationEndpoint'];
    final watchEndpoint = navigationEndpoint['watchEndpoint'];
    final browseEndpoint = navigationEndpoint['browseEndpoint'];

    String? type =
        browseEndpoint?['browseEndpointContextSupportedConfigs']?['browseEndpointContextMusicConfig']?['pageType'];
    type ??=
        watchEndpoint['watchEndpointMusicSupportedConfigs']?['watchEndpointMusicConfig']?['musicVideoType'];

    final runs = traverseList(flexColumnsJson, [
      'musicResponsiveListItemFlexColumnRenderer',
      'text',
      'runs',
    ]);

    final subtitle = traverseString(flexColumnsJson[1], [
      'text',
      'accessibility',
      'accessibilityData',
      'label',
    ]);
    final thumbnails = getthumbnails(json['thumbnail']);
    final artists = getArtists(runs);
    final album = getAlbum(runs);

    final menuJson = traverseList(json, ['menu', 'menuRenderer', 'items']);
    final radio = getRadio(menuJson);
    final shuffle = getShuffle(menuJson);

    return ProviderItem(
      id: watchEndpoint?['videoId'] ?? browseEndpoint?['browseId'],
      title: title,
      subtitle: subtitle,
      type: getItemType(type),
      playbackPayload: YtPlaybackPayload(params: watchEndpoint),
      radioPayload: radio,
      shufflePayload: shuffle,
      thumbnails: thumbnails.isNotEmpty ? thumbnails : (thumbs ?? []),
      artists: artists,
      album: album,
    );
  }

  static ProviderItem _musicTwoRowItemRenderer(dynamic json) {
    final thumbnails = getthumbnails(json['thumbnailRenderer']);
    final titleJson = json['title']['runs'][0];
    final title = titleJson['text'];
    final navigationEndpoint =
        json['navigationEndpoint'] ?? titleJson['navigationEndpoint'];
    final browseEndpoint = navigationEndpoint['browseEndpoint'];

    final watchEndpoint = navigationEndpoint['watchEndpoint'];
    String? type =
        browseEndpoint?['browseEndpointContextSupportedConfigs']?['browseEndpointContextMusicConfig']?['pageType'];
    type ??=
        watchEndpoint['watchEndpointMusicSupportedConfigs']?['watchEndpointMusicConfig']?['musicVideoType'];
    final subtitle = traverseString(json['subtitle'], ['text']);

    final menuJson = traverseList(json['menu'], ['menuRenderer', 'items']);
    final radio = getRadio(menuJson);
    final shuffle = getShuffle(menuJson);

    return ProviderItem(
      id: browseEndpoint?['browseId'] ?? watchEndpoint?['videoId'],
      title: title,
      subtitle: subtitle,
      type: getItemType(type),
      playbackPayload: watchEndpoint == null
          ? null
          : YtPlaybackPayload(params: watchEndpoint),
      browsePayload: browseEndpoint == null
          ? null
          : YtBrowsePayload(params: browseEndpoint),
      radioPayload: radio,
      shufflePayload: shuffle,
      thumbnails: thumbnails,
    );
  }
}
