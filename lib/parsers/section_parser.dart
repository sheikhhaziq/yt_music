import 'package:gyawun_services/gyawun_services.dart';
import 'package:yt_music/modals/yt_browse_payload.dart';
import 'package:yt_music/modals/yt_playback_payload.dart';
import 'package:yt_music/parsers/item_parser.dart';

class SectionParser {
  static ProviderSection? parse(dynamic json, {List<Thumbnail>? thumbnails}) {
    if (json['musicCarouselShelfRenderer'] != null) {
      return _musicCarouselShelfRenderer(json['musicCarouselShelfRenderer']);
    }

    if (json['musicPlaylistShelfRenderer'] != null) {
      return _musicPlaylistShelfRenderer(json['musicPlaylistShelfRenderer']);
    }

    if (json['musicShelfRenderer'] != null) {
      return _musicShelfRenderer(
        json['musicShelfRenderer'],
        thumbs: thumbnails,
      );
    }
    print(json.keys.toList());

    return null;
  }

  static ProviderSection _musicCarouselShelfRenderer(dynamic json) {
    // [header, contents, trackingParams, itemSize, numItemsPerColumn?, shelfId]
    final headerJson = json['header']['musicCarouselShelfBasicHeaderRenderer'];
    final contentsJson = json['contents'] as List;

    final String? title = headerJson['title']?['runs']?[0]?['text'];
    final navigationEndpoint =
        headerJson['moreContentButton']?['buttonRenderer']?['navigationEndpoint'];
    final trailingPayload = navigationEndpoint == null
        ? null
        : navigationEndpoint['browseEndpoint'] != null
        ? YtBrowsePayload(params: navigationEndpoint['browseEndpoint'])
        : YtPlaybackPayload(params: navigationEndpoint['watchEndpoint']);

    return ProviderSection(
      title: title,
      trailingPayload: trailingPayload,
      type: json['numItemsPerColumn'] == null
          ? ProviderSectionType.row
          : ProviderSectionType.carousel,
      items: contentsJson
          .map(ItemParser.parse)
          .whereType<ProviderItem>()
          .toList(),
    );
  }

  static ProviderSection _musicPlaylistShelfRenderer(dynamic json) {
    return ProviderSection(
      title: null,
      type: ProviderSectionType.column,
      items: (json['contents'] as List)
          .map(ItemParser.parse)
          .whereType<ProviderItem>()
          .toList(),
    );
  }

  static ProviderSection _musicShelfRenderer(
    dynamic json, {
    List<Thumbnail>? thumbs,
  }) {
    return ProviderSection(
      title: null,
      items: (json['contents'] as List)
          .map((e) => ItemParser.parse(e, thumbs: thumbs))
          .whereType<ProviderItem>()
          .toList(),
      type: ProviderSectionType.column,
    );
  }
}
