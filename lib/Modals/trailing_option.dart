import 'package:json_annotation/json_annotation.dart';

part 'trailing_option.g.dart';

@JsonSerializable()
class YTMusicTrailingOption {
  final String text;
  final Map<String, dynamic> endpoint;
  final bool isPlayable;
  YTMusicTrailingOption({
    required this.text,
    required this.endpoint,
    this.isPlayable = false,
  });
  factory YTMusicTrailingOption.fromJson(Map<String, dynamic> json) =>
      _$YTMusicTrailingOptionFromJson(json);

  /// Connect the generated [_$YTMusicTrailingOptionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicTrailingOptionToJson(this);
}
