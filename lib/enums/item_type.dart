import 'package:json_annotation/json_annotation.dart';

part 'item_type.g.dart';

@JsonEnum(alwaysCreate: true)
enum YTMusicItemType {
  @JsonValue('MUSIC_VIDEO_TYPE_ATV')
  song,

  @JsonValue('MUSIC_VIDEO_TYPE_OMV')
  video,

  @JsonValue('MUSIC_VIDEO_TYPE_UGC') // This will not be used directly
  videoUgc, // Separate internal value for duplicate types

  @JsonValue('MUSIC_PAGE_TYPE_PLAYLIST')
  playlist,

  @JsonValue('MUSIC_PAGE_TYPE_ALBUM')
  album,

  @JsonValue("MUSIC_PAGE_TYPE_ARTIST")
  artist,

  @JsonValue('MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE')
  episode,

  @JsonValue('MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE')
  podcast,

  @JsonValue("MUSIC_PAGE_TYPE_USER_CHANNEL")
  userChannel,

  @JsonValue('unknown')
  unknown;

  // Custom mapping for multiple JSON values
  static final Map<String, YTMusicItemType> _customMapping = {
    'MUSIC_VIDEO_TYPE_UGC': YTMusicItemType.video,
    'MUSIC_VIDEO_TYPE_OMV': YTMusicItemType.video, // Maps OMV to the same enum
    'MUSIC_VIDEO_TYPE_ATV': YTMusicItemType.song,
    'MUSIC_PAGE_TYPE_PLAYLIST': YTMusicItemType.playlist,
    'MUSIC_PAGE_TYPE_ALBUM': YTMusicItemType.album,
    'MUSIC_PAGE_TYPE_ARTIST': YTMusicItemType.artist,
    'MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE': YTMusicItemType.podcast,
    'MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE': YTMusicItemType.episode,
    "MUSIC_PAGE_TYPE_USER_CHANNEL": YTMusicItemType.userChannel,
  };

  // Convert from JSON
  static YTMusicItemType fromString(String? value) =>
      _customMapping[value] ?? YTMusicItemType.unknown;

  // Convert to JSON
  String toJson() {
    return _$YTMusicItemTypeEnumMap[this]!;
  }
}
