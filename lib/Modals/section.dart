
import 'package:json_annotation/json_annotation.dart';
import 'package:yt_music/enums/section_type.dart';

import 'modals.dart';

part 'section.g.dart';

@JsonSerializable()
class YTMusicSection {
  final String? title;
  final YTMusicSectionType type;
  final List<YTMusicSectionItem> contents;
  final YTMusicTrailingOption? trailingOption;
  final String? continuation;

  YTMusicSection({
    this.title,
    this.type = YTMusicSectionType.row,
    required this.contents,
    this.trailingOption,
    this.continuation,
  });

  YTMusicSection copyWith({
    String? title,
    YTMusicSectionType? type,
    List<YTMusicSectionItem>? contents,
    YTMusicTrailingOption? trailingOption,
    String? continuation,
  }) =>
      YTMusicSection(
        title: title ?? this.title,
        type: type ?? this.type,
        contents: contents ?? this.contents,
        trailingOption: trailingOption ?? this.trailingOption,
        continuation: continuation ?? this.continuation,
      );

  // YTMusicSection.fromMap(Map<String, dynamic> map)
  //     : title = map['title'] as String,
  //       contents = map['contents'] as List<YTMusicSectionItem>,;
  factory YTMusicSection.fromJson(Map<String, dynamic> json) =>
      _$YTMusicSectionFromJson(json);

  /// Connect the generated [_$YTMusicSectionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicSectionToJson(this);
}
