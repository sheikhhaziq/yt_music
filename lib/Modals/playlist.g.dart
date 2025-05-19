// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicPlaylistPage _$YTMusicPlaylistPageFromJson(Map<String, dynamic> json) =>
    YTMusicPlaylistPage(
      playlistId: json['playlistId'] as String,
      title: json['title'] as String,
      artist:
          YTMusicArtistBasic.fromJson(json['artist'] as Map<String, dynamic>),
      subtitle: json['subtitle'] as String,
      playEndpoint: json['playEndpoint'] as Map<String, dynamic>?,
      shuffleEndpoint: json['shuffleEndpoint'] as Map<String, dynamic>?,
      radioEndpoint: json['radioEndpoint'] as Map<String, dynamic>?,
      secondSubtitle: json['secondSubtitle'] as String,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => YTMusicThumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => YTMusicSection.fromJson(e as Map<String, dynamic>))
          .toList(),
      continuation: json['continuation'] as String?,
    );

Map<String, dynamic> _$YTMusicPlaylistPageToJson(
        YTMusicPlaylistPage instance) =>
    <String, dynamic>{
      'playlistId': instance.playlistId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'playEndpoint': instance.playEndpoint,
      'shuffleEndpoint': instance.shuffleEndpoint,
      'radioEndpoint': instance.radioEndpoint,
      'artist': instance.artist,
      'secondSubtitle': instance.secondSubtitle,
      'thumbnails': instance.thumbnails,
      'description': instance.description,
      'sections': instance.sections,
      'continuation': instance.continuation,
    };
