import 'package:gyawun_services/gyawun_services.dart';
import 'package:yt_music/modals/yt_browse_payload.dart';
import 'package:yt_music/modals/yt_playback_payload.dart';
import 'package:yt_music/parsers/utils/filters.dart';
import 'package:yt_music/parsers/utils/traverse.dart';

List<Thumbnail> getthumbnails(dynamic json) {
  final thumbnails = traverseList(json, ['thumbnail', 'thumbnails']);
  return thumbnails
      .map(
        (e) => Thumbnail(url: e['url'], width: e['width'], height: e['height']),
      )
      .toList();
}

List<ProviderArtist>? getArtists(List json) {
  final artistsJson = json.where(isArtist).toList();
  if (artistsJson.isEmpty) {
    return null;
  }
  return artistsJson
      .map(
        (e) => ProviderArtist(
          id: e['navigationEndpoint']['browseEndpoint']['browseId'],
          title: e['text'],
          browsePayload: YtBrowsePayload(
            params: e['navigationEndpoint']['browseEndpoint'],
          ),
        ),
      )
      .toList();
}

ProviderAlbum? getAlbum(List json) {
  final album = json.firstWhere(isAlbum, orElse: () => null);
  if (album == null) {
    return null;
  }
  return ProviderAlbum(
    id: album['navigationEndpoint']['browseEndpoint']['browseId'],
    title: album['text'],
    browsePayload: YtBrowsePayload(
      params: album['navigationEndpoint']['browseEndpoint'],
    ),
  );
}

YtPlaybackPayload? getRadio(List json) {
  final radio = json.firstWhere(isRadio, orElse: () => null);
  if (radio == null) {
    return null;
  }
  return YtPlaybackPayload(
    params:
        radio['menuNavigationItemRenderer']['navigationEndpoint']['watchEndpoint'],
  );
}

YtPlaybackPayload? getShuffle(List json) {
  final shuffle = json.firstWhere(isShuffle, orElse: () => null);
  if (shuffle == null) {
    return null;
  }
  return YtPlaybackPayload(
    params:
        shuffle['menuNavigationItemRenderer']['navigationEndpoint']['watchEndpoint'],
  );
}
