import 'package:gyawun_services/gyawun_services.dart';
import 'package:yt_music/modals/yt_browse_payload.dart';
import 'package:yt_music/modals/yt_playback_payload.dart';
import 'package:yt_music/parsers/section_parser.dart';
import 'package:yt_music/parsers/utils/helpers.dart';
import 'package:yt_music/parsers/utils/parse_continuation.dart';
import 'package:yt_music/parsers/utils/traverse.dart';
import 'package:yt_music/pprint.dart';

class BrowseParser {
  static BrowseResult? parse(dynamic json) {
    final contents = json['contents'];
    if (contents['singleColumnBrowseResultsRenderer'] != null) {
      return _parseSingleColumnBrowseResultsRenderer(
        contents['singleColumnBrowseResultsRenderer'],
      );
    }
    if (contents['twoColumnBrowseResultsRenderer'] != null) {
      return _twoColumnBrowseResultsRenderer(
        contents['twoColumnBrowseResultsRenderer'],
      );
    }

    pprint(json.keys.toList());
    return null;
  }

  static BrowseContinuationResult parseContinuation(dynamic json) {
    final sectionListContinuation =
        json['continuationContents']['sectionListContinuation'];
    final continuation = parseContinuationString(
      sectionListContinuation['continuations'],
    );
    final sectionsJson = sectionListContinuation['contents'] as List;
    return BrowseContinuationResult(
      sections: sectionsJson
          .map(SectionParser.parse)
          .whereType<ProviderSection>()
          .toList(),
      continuationPayload: continuation,
    );
  }

  static BrowseResult _parseSingleColumnBrowseResultsRenderer(dynamic json) {
    final sectionListRenderer =
        json['tabs'][0]['tabRenderer']['content']['sectionListRenderer'];
    final contentsjson = sectionListRenderer['contents'] as List<dynamic>;
    final headerJson = sectionListRenderer['header'];
    final continuationsJson = sectionListRenderer['continuations'];
    final continuation = parseContinuationString(continuationsJson);
    final chipsJson =
        headerJson?['chipCloudRenderer']?['chips'] as List<dynamic>?;
    final chips = _parseChips(chipsJson);
    final sections = contentsjson
        .map(SectionParser.parse)
        .whereType<ProviderSection>()
        .toList();
    return BrowseResult(
      chips: chips,
      continuationPayload: continuation,
      sections: sections,
    );
  }

  static BrowseResult _twoColumnBrowseResultsRenderer(dynamic json) {
    final sectionListRenderer =
        json['secondaryContents']['sectionListRenderer'];
    final continuation = parseContinuationString(
      sectionListRenderer['continuations'],
    );
    final contents = sectionListRenderer['contents'];
    final headerJson =
        json['tabs'][0]['tabRenderer']['content']['sectionListRenderer']['contents'][0]['musicResponsiveHeaderRenderer'];

    final header = _parseHeader(headerJson);
    final sections = contents
        .map((e) => SectionParser.parse(e, thumbnails: header.thumbnails))
        .whereType<ProviderSection>()
        .toList();

    return BrowseResult(
      header: header,
      sections: sections,
      continuationPayload: continuation,
    );
  }

  static BrowseHeader _parseHeader(dynamic json) {
    final thumbnails = getthumbnails(json['thumbnail']);
    final title = json['title']['runs'][0]['text'];
    final subtitle = traverseList(json['subtitle'], ['runs', 'text']).join();
    final playEndpoint = traverse(json['buttons'], [
      'musicPlayButtonRenderer',
      'playNavigationEndpoint',
      'watchEndpoint',
    ]);
    final playPayload = playEndpoint is! Map
        ? null
        : YtPlaybackPayload(params: playEndpoint as Map<String, dynamic>);
    final buttons = traverseList(json['buttons'], ['menuRenderer', 'items']);
    final radio = getRadio(buttons);
    final shuffle = getShuffle(buttons);
    return BrowseHeader(
      title: title,
      thumbnails: thumbnails,
      subtitle: subtitle,
      playbackPayload: playPayload,
      radioPayload: radio,
      shufflePayload: shuffle,
    );
  }

  static List<ChipItem>? _parseChips(List<dynamic>? json) {
    if (json == null) return null;
    return json.map(_parseChip).whereType<ChipItem>().toList();
  }

  static ChipItem? _parseChip(dynamic json) {
    if (json == null) return null;
    final chipRenderer = json['chipCloudChipRenderer'];
    final text = chipRenderer['text']['runs'][0]['text'];
    final browseEndpoint = chipRenderer['navigationEndpoint']['browseEndpoint'];
    return ChipItem(
      id: browseEndpoint['browseId'],
      title: text,
      payload: YtBrowsePayload(params: browseEndpoint),
    );
  }
}
