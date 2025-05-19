import 'section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_page.g.dart';

@JsonSerializable()
class YTMusicHomePage {
  final String? continuation;
  final List<YTMusicSection> sections;
  YTMusicHomePage({
    this.continuation,
    required this.sections,
  });

  factory YTMusicHomePage.fromJson(Map<String, dynamic> json) =>
      _$YTMusicHomePageFromJson(json);

  /// Connect the generated [_$YTMusicHomePageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicHomePageToJson(this);
}
