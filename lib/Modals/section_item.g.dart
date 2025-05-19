// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicSectionItem _$YTMusicSectionItemFromJson(Map<String, dynamic> json) =>
    YTMusicSectionItem(
      title: json['title'] as String,
      id: json['id'] as String,
      isExplicit: json['isExplicit'] as bool? ?? false,
      type: $enumDecode(_$YTMusicItemTypeEnumMap, json['type']),
      playlistId: json['playlistId'] as String?,
      duration: json['duration'] as String?,
      endpoint: json['endpoint'] as Map<String, dynamic>,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => YTMusicThumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      artists: (json['artists'] as List<dynamic>)
          .map((e) => YTMusicArtistBasic.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtitle: json['subtitle'] as String?,
      isHorizontal: json['isHorizontal'] as bool? ?? false,
      album: json['album'] == null
          ? null
          : YTMusicAlbumBasic.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$YTMusicSectionItemToJson(YTMusicSectionItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'isExplicit': instance.isExplicit,
      'type': instance.type,
      'playlistId': instance.playlistId,
      'duration': instance.duration,
      'endpoint': instance.endpoint,
      'thumbnails': instance.thumbnails,
      'artists': instance.artists,
      'album': instance.album,
      'subtitle': instance.subtitle,
      'isHorizontal': instance.isHorizontal,
    };

const _$YTMusicItemTypeEnumMap = {
  YTMusicItemType.song: 'MUSIC_VIDEO_TYPE_ATV',
  YTMusicItemType.video: 'MUSIC_VIDEO_TYPE_OMV',
  YTMusicItemType.videoUgc: 'MUSIC_VIDEO_TYPE_UGC',
  YTMusicItemType.playlist: 'MUSIC_PAGE_TYPE_PLAYLIST',
  YTMusicItemType.album: 'MUSIC_PAGE_TYPE_ALBUM',
  YTMusicItemType.artist: 'MUSIC_PAGE_TYPE_ARTIST',
  YTMusicItemType.episode: 'MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE',
  YTMusicItemType.podcast: 'MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE',
  YTMusicItemType.userChannel: 'MUSIC_PAGE_TYPE_USER_CHANNEL',
  YTMusicItemType.unknown: 'unknown',
};
