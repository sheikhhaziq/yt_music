
import 'package:json_annotation/json_annotation.dart';

import 'modals.dart';

part 'profile.g.dart';

@JsonSerializable()
class YTMusicProfilePage {
  final String name;
  final List<YTMusicSection> sections;
  final String? description;
  final List<YTMusicThumbnail>? thumbnails;
  final String? subscribers;
  final String? channelId;

  YTMusicProfilePage({
    required this.name,
    required this.sections,
    this.description,
    this.thumbnails,
    this.channelId,
    this.subscribers,
  });

  factory YTMusicProfilePage.fromJson(Map<String, dynamic> json) =>
      _$YTMusicProfilePageFromJson(json);

  /// Connect the generated [_$YTMusicProfilePageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicProfilePageToJson(this);
}
