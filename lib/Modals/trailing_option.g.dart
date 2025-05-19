// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trailing_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YTMusicTrailingOption _$YTMusicTrailingOptionFromJson(
        Map<String, dynamic> json) =>
    YTMusicTrailingOption(
      text: json['text'] as String,
      endpoint: json['endpoint'] as Map<String, dynamic>,
      isPlayable: json['isPlayable'] as bool? ?? false,
    );

Map<String, dynamic> _$YTMusicTrailingOptionToJson(
        YTMusicTrailingOption instance) =>
    <String, dynamic>{
      'text': instance.text,
      'endpoint': instance.endpoint,
      'isPlayable': instance.isPlayable,
    };
