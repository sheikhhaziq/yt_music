import 'package:gyawun_services/gyawun_services.dart';

ProviderItemType getItemType(String? value) {
  switch (value) {
    case 'MUSIC_VIDEO_TYPE_ATV':
      return ProviderItemType.song;
    case 'MUSIC_VIDEO_TYPE_OMV':
    case 'MUSIC_VIDEO_TYPE_UGC':
      return ProviderItemType.video;

    case 'MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE':
      return ProviderItemType.episode;

    case 'MUSIC_PAGE_TYPE_ALBUM':
      return ProviderItemType.album;
    case 'MUSIC_PAGE_TYPE_PLAYLIST':
      return ProviderItemType.playlist;
    case 'MUSIC_PAGE_TYPE_ARTIST':
      return ProviderItemType.artist;
    case 'MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE':
      return ProviderItemType.podcast;
    default:
      return ProviderItemType.unknown;
  }
}
