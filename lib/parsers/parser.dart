import '../Modals/modals.dart';
import '../enums/item_type.dart';
import '../enums/section_type.dart';
import '../utils/filters.dart';
import '../utils/traverse.dart';

class Parser {
  static List<dynamic> getComputedList(args) {
    return traverseList(args[0], args[1]);
  }

  static String? getComputedString(args) {
    return traverseString(args[0], args[1]);
  }

  static dynamic getComputed(args) {
    return traverse(args[0], args[1]);
  }

  static int? parseDuration(String? time) {
    final regex = RegExp(r'\((\d{1,2}:\d{2})\)');
    final match = regex.firstMatch(time ?? '00:00');
    if (time == null || match == null) return null;

    final extractedTime = match.group(1)!;

    final parts = extractedTime.split(":").reversed.map(int.parse).toList();
    final seconds = parts[0];
    final minutes = parts[1];
    late final int hours;

    if (parts.length > 2) {
      hours = parts[2];
    } else {
      hours = 0;
    }

    return seconds + minutes * 60 + hours * 60 * 60;
  }

  static double parseNumber(String string) {
    if (string.endsWith("K") ||
        string.endsWith("M") ||
        string.endsWith("B") ||
        string.endsWith("T")) {
      final number = double.parse(string.substring(0, string.length - 1));
      final multiplier = string.substring(string.length - 1);

      return {
            "K": number * 1000,
            "M": number * 1000 * 1000,
            "B": number * 1000 * 1000 * 1000,
            "T": number * 1000 * 1000 * 1000 * 1000,
          }[multiplier] ??
          double.nan;
    } else {
      return double.parse(string);
    }
  }

  static YTMusicSection? parseSection(dynamic data) {
    if (data['musicCardShelfRenderer'] != null) {
      return musicCardShelfRenderer(data['musicCardShelfRenderer']);
    } else if (data['musicShelfRenderer'] != null) {
      return musicShelfRenderer(data['musicShelfRenderer']);
    } else if (data['musicCarouselShelfRenderer'] != null) {
      return musicCarouselShelfRenderer(data['musicCarouselShelfRenderer']);
    } else if (data['musicPlaylistShelfRenderer'] != null) {
      return musicPlaylistShelfRenderer(data['musicPlaylistShelfRenderer']);
    } else if (data['musicShelfContinuation'] != null) {
      return musicShelfRenderer(data['musicShelfContinuation']);
    }

    return null;
  }

  static YTMusicSection musicCardShelfRenderer(data) {
    // [trackingParams, thumbnail, title, subtitle, contents, buttons, menu, onTap, header, endIcon]
    final List? contents = data['contents'];
    final navend = traverse(data['title'], ["runs", "navigationEndpoint"]);
    final type =
        traverseString(navend, [
          "browseEndpoint",
          "browseEndpointContextSupportedConfigs",
          "browseEndpointContextMusicConfig",
          "pageType",
        ]) ??
        traverseString(navend, [
          "watchEndpoint",
          "watchEndpointMusicSupportedConfigs",
          "musicVideoType",
        ]);
    dynamic endpoint = traverse(navend, ["browseEndpoint"]);
    if (endpoint is! Map) {
      endpoint = traverse(navend, ["watchEndpoint"]);
    }
    final id =
        traverseString(navend, ["browseEndpoint", "browseId"]) ??
        traverseString(navend, ["watchEndpoint", "videoId"]);
    return YTMusicSection(
      title: traverseString(data['header'], ["title", "runs", "text"]),
      contents: [
        YTMusicSectionItem(
          title: traverseString(data['title'], ["runs", "text"]) ?? '',
          subtitle: traverseList(data['subtitle'], ['runs', "text"]).join(),
          id: id ?? '',
          type: YTMusicItemType.fromString(type),
          endpoint: endpoint,
          thumbnails:
              traverseList(data['thumbnail'], [
                "thumbnails",
              ]).map((item) => YTMusicThumbnail.fromMap(item)).toList(),
          artists: [],
        ),
        if (contents != null)
          ...contents
              .map(parseSectionItem)
              .where((e) => e != null)
              .cast<YTMusicSectionItem>(),
      ],
    );
  }

  static YTMusicSection musicShelfRenderer(data) {
    // [title?, contents, trackingParams,bottomText?,bottomEndpoint?, shelfDivider, contentsMultiSelectable]
    var more = traverse(data, ['bottomEndpoint', 'searchEndpoint']);
    if (more is! Map) {
      more = traverse(data, ['bottomEndpoint', 'browseEndpoint']);
    }

    YTMusicTrailingOption? endpoint;
    if (more != null && more is Map) {
      endpoint = YTMusicTrailingOption(
        text: traverse(data, ['bottomText', 'runs', 'text']),
        endpoint: more.cast(),
      );
    }
    final List contents = data['contents'];
    return YTMusicSection(
      continuation: traverseString(data['continuations'], ['continuation']),
      title: traverseString(data['title'], ['runs', 'text']),
      type: YTMusicSectionType.singleColumn,
      trailingOption: endpoint,
      contents:
          contents
              .map(parseSectionItem)
              .where((e) => e != null)
              .cast<YTMusicSectionItem>()
              .toList(),
    );
  }

  static YTMusicSection musicCarouselShelfRenderer(data) {
    // [header, contents, trackingParams, itemSize, numItemsPerColumn?]

    final List contents = data['contents'];
    final more =
        data['header']['musicCarouselShelfBasicHeaderRenderer']['moreContentButton'];
    YTMusicTrailingOption? trailingOption;
    if (more != null) {
      dynamic endpoint = traverse(more, [
        "navigationEndpoint",
        "watchPlaylistEndpoint",
      ]);
      if (endpoint is! Map) {
        endpoint = traverse(more, ["navigationEndpoint", "watchEndpoint"]);
      }
      final isPlayable = endpoint is Map;
      if (!isPlayable) {
        endpoint = traverse(more, ["navigationEndpoint", "browseEndpoint"]);
      }

      trailingOption = YTMusicTrailingOption(
        text:
            traverseString(more, ["buttonRenderer", "text", "runs", "text"]) ??
            '',
        endpoint: endpoint,
        isPlayable: isPlayable,
      );
    }

    return YTMusicSection(
      title: traverseString(data['header'], ['title', 'text']),
      type:
          data['numItemsPerColumn'] != null
              ? YTMusicSectionType.multiColumn
              : YTMusicSectionType.row,
      trailingOption: trailingOption,
      contents:
          contents
              .map(parseSectionItem)
              .where((e) => e != null)
              .cast<YTMusicSectionItem>()
              .toList(),
    );
  }

  static YTMusicSection musicPlaylistShelfRenderer(data) {
    // [playlistId, header?, contents, collapsedItemCount, trackingParams, contentsMultiSelectable, targetId]

    final continuation = traverseString(data['contents'].last, [
      'continuationEndpoint',
      'token',
    ]);
    return YTMusicSection(
      trailingOption:
          continuation != null
              ? YTMusicTrailingOption(
                text: 'More',
                endpoint: {'continuation': continuation},
              )
              : null,
      type: YTMusicSectionType.singleColumn,
      contents:
          data['contents']
              .map(parseSectionItem)
              .where((e) => e != null)
              .cast<YTMusicSectionItem>()
              .toList(),
    );
  }

  static YTMusicSectionItem? parseSectionItem(data) {
    if (data['musicResponsiveListItemRenderer'] != null) {
      return musicResponsiveListItemRenderer(
        data['musicResponsiveListItemRenderer'],
      );
    }
    if (data['musicTwoRowItemRenderer'] != null) {
      return musicTwoRowItemRenderer(data["musicTwoRowItemRenderer"]);
    }
    if (data['musicMultiRowListItemRenderer'] != null) {
      return musicMultiRowListItemRenderer(
        data['musicMultiRowListItemRenderer'],
      );
    }
    return null;
  }

  static YTMusicSectionItem? musicResponsiveListItemRenderer(data) {
    // [trackingParams, thumbnail, overlay, flexColumns,fixedColumns?,navigationEndpoint?, menu, playlistItemData, flexColumnDisplayStyle, itemHeight]

    final flexColumns = data['flexColumns'];
    final columns = traverseList(flexColumns, ['text', 'runs']);
    final thumbnails =
        traverseList(data['thumbnail'], [
          "thumbnails",
        ]).map((item) => YTMusicThumbnail.fromMap(item)).toList();
    final title =
        traverseString(
          flexColumns[0]['musicResponsiveListItemFlexColumnRenderer'],
          ["runs", "text"],
        ) ??
        '';
    final id =
        traverseString(
          flexColumns[0]['musicResponsiveListItemFlexColumnRenderer'],
          ["runs", "navigationEndpoint", "watchEndpoint", "videoId"],
        ) ??
        '';
    final playlistId =
        traverseString(
          flexColumns[0]['musicResponsiveListItemFlexColumnRenderer'],
          ["runs", "navigationEndpoint", "watchEndpoint", "playlistId"],
        ) ??
        '';

    final List<YTMusicArtistBasic> artists =
        columns
            .where(isArtist)
            .map(
              (a) => YTMusicArtistBasic(
                name: traverseString(a, ["text"]) ?? '',
                endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
              ),
            )
            .toList();
    Map<String, dynamic>? a = columns.firstWhere(isAlbum, orElse: () => null);
    YTMusicAlbumBasic? album;
    if (a != null) {
      album = YTMusicAlbumBasic(
        albumId:
            traverseString(a, [
              "navigationEndpoint",
              "browseEndpoint",
              "browseId",
            ]) ??
            '',
        name: a['text'],
        endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
      );
    }

    final ep =
        data['navigationEndpoint'] ??
        traverse(flexColumns[0], ["text", "runs", "navigationEndpoint"]);
    if (ep is List) {
      return null;
    }
    final endpoint = ep['browseEndpoint'] ?? ep['watchEndpoint'];
    final type =
        (ep['watchEndpoint'] != null
            ? traverseString(ep, [
              "watchEndpoint",
              "watchEndpointMusicSupportedConfigs",
              "musicVideoType",
            ])
            : traverseString(ep, [
              "browseEndpoint",
              "browseEndpointContextSupportedConfigs",
              "pageType",
            ])) ??
        '';

    bool explicit = isexplicit(data['badges']);
    return YTMusicSectionItem(
      title: title,
      id: id,
      isExplicit: explicit,
      type: YTMusicItemType.fromString(type),
      duration: traverseString(data['fixedColumns'], [
        'musicResponsiveListItemFixedColumnRenderer',
        'text',
        'runs',
        'text',
      ]),
      subtitle:
          traverseList(
            flexColumns.last['musicResponsiveListItemFlexColumnRenderer'],
            ["text", "runs", "text"],
          ).join(),
      playlistId: playlistId,
      endpoint: endpoint,
      thumbnails: thumbnails,
      artists: artists,
      album: album,
    );
  }

  static YTMusicSectionItem? musicTwoRowItemRenderer(data) {
    // [thumbnailRenderer, aspectRatio, title, subtitle, navigationEndpoint, trackingParams, menu, thumbnailOverlay]

    final title = traverseString(data["title"], ["text"]) ?? '';

    dynamic endpoint = data["navigationEndpoint"]?["browseEndpoint"];
    endpoint ??= data["navigationEndpoint"]?["watchEndpoint"];
    final id = endpoint['browseId'] ?? endpoint['videoId'];
    final type =
        traverseString(endpoint, [
          "browseEndpointContextSupportedConfigs",
          "pageType",
        ]) ??
        traverseString(data, [
          'watchEndpointMusicSupportedConfigs',
          'musicVideoType',
        ]) ??
        '';
    final thumbnails =
        traverseList(data['thumbnailRenderer'], [
          "thumbnails",
        ]).map((item) => YTMusicThumbnail.fromMap(item)).toList();
    final isHorizontal = data['aspectRatio'].contains('RECTANGLE');
    Map<String, dynamic>? a = traverseList(data['subtitle'], [
      "runs",
    ]).firstWhere(isAlbum, orElse: () => null);
    YTMusicAlbumBasic? album;
    if (a != null) {
      album = YTMusicAlbumBasic(
        albumId:
            traverseString(a, [
              "navigationEndpoint",
              "browseEndpoint",
              "browseId",
            ]) ??
            '',
        name: a['text'],
        endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
      );
    }
    final List<YTMusicArtistBasic> artists =
        traverseList(data['subtitle'], ["runs"])
            .where(isArtist)
            .map(
              (a) => YTMusicArtistBasic(
                name: traverseString(a, ["text"]) ?? '',
                endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
              ),
            )
            .cast<YTMusicArtistBasic>()
            .toList();
    final subtitle = traverseList(data['subtitle'], ["runs", "text"]).join("");
    return YTMusicSectionItem(
      title: title,
      id: id,
      type: YTMusicItemType.fromString(type),
      endpoint: endpoint,
      thumbnails: thumbnails,
      album: album,
      artists: artists,
      isHorizontal: isHorizontal,
      subtitle: subtitle,
    );
  }

  static musicMultiRowListItemRenderer(data) {
    // [trackingParams, thumbnail, overlay, onTap, menu, subtitle, playbackProgress, title, description, displayStyle]
    final subtitle =
        (traverseString(data['subtitle'], ['runs', 'text']) ?? '') +
        (traverseList(data['playbackProgress'], [
          'playbackProgressText',
          'text',
        ]).join());
    return YTMusicSectionItem(
      title: traverseString(data['title'], ['runs', 'text']) ?? '',
      subtitle: subtitle,
      id:
          traverseString(data['title'], [
            'runs',
            'navigationEndpoint',
            'browseEndpoint',
            'browseId',
          ]) ??
          traverseString(data['title'], [
            'runs',
            'navigationEndpoint',
            'watchEndpoint',
            'videoId',
          ]) ??
          "",
      type: YTMusicItemType.fromString(
        traverseString(data['title'], ['navigationEndpoint', 'pageType']),
      ),
      endpoint: traverse(data['title'], ['runs', 'browseEndpoint']),
      thumbnails:
          traverseList(data, [
            'thumbnail',
            'thumbnail',
            'thumbnails',
          ]).map((item) => YTMusicThumbnail.fromMap(item)).toList(),
      artists: [],
    );
  }
}
