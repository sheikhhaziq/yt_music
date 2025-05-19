// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicThumbnail _$YTMusicThumbnailFromJson(Map<String, dynamic> json) =>
    YTMusicThumbnail(
      url: json['url'] as String,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
    );

Map<String, dynamic> _$YTMusicThumbnailToJson(YTMusicThumbnail instance) =>
    <String, dynamic>{
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
