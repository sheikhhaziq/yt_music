// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicHomePage _$YTMusicHomePageFromJson(Map<String, dynamic> json) =>
    YTMusicHomePage(
      continuation: json['continuation'] as String?,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => YTMusicSection.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$YTMusicHomePageToJson(YTMusicHomePage instance) =>
    <String, dynamic>{
      'continuation': instance.continuation,
      'sections': instance.sections,
    };
