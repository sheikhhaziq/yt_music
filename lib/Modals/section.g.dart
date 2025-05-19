// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicSection _$YTMusicSectionFromJson(Map<String, dynamic> json) =>
    YTMusicSection(
      title: json['title'] as String?,
      type: $enumDecodeNullable(_$YTMusicSectionTypeEnumMap, json['type']) ??
          YTMusicSectionType.row,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => YTMusicSectionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      trailingOption: json['trailingOption'] == null
          ? null
          : YTMusicTrailingOption.fromJson(
              json['trailingOption'] as Map<String, dynamic>),
      continuation: json['continuation'] as String?,
    );

Map<String, dynamic> _$YTMusicSectionToJson(YTMusicSection instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': _$YTMusicSectionTypeEnumMap[instance.type]!,
      'contents': instance.contents,
      'trailingOption': instance.trailingOption,
      'continuation': instance.continuation,
    };

const _$YTMusicSectionTypeEnumMap = {
  YTMusicSectionType.row: 'row',
  YTMusicSectionType.singleColumn: 'singleColumn',
  YTMusicSectionType.multiColumn: 'multiColumn',
};
