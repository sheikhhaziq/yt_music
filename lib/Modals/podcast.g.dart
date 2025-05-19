// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicPodcastPage _$YTMusicPodcastPageFromJson(Map<String, dynamic> json) =>
    YTMusicPodcastPage(
      podcastId: json['podcastId'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
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

Map<String, dynamic> _$YTMusicPodcastPageToJson(YTMusicPodcastPage instance) =>
    <String, dynamic>{
      'podcastId': instance.podcastId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'secondSubtitle': instance.secondSubtitle,
      'thumbnails': instance.thumbnails,
      'description': instance.description,
      'sections': instance.sections,
      'continuation': instance.continuation,
    };
