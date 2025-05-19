// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicArtistBasic _$YTMusicArtistBasicFromJson(Map<String, dynamic> json) =>
    YTMusicArtistBasic(
      artistId: json['artistId'] as String?,
      name: json['name'] as String,
      endpoint: json['endpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$YTMusicArtistBasicToJson(YTMusicArtistBasic instance) =>
    <String, dynamic>{
      'artistId': instance.artistId,
      'endpoint': instance.endpoint,
      'name': instance.name,
    };
