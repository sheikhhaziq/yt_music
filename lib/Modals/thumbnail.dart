import 'package:json_annotation/json_annotation.dart';
part 'thumbnail.g.dart';

@JsonSerializable()
class YTMusicThumbnail {
  final String url;
  final int width;
  final int height;

  YTMusicThumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  // Construtor nomeado para criar uma YTMusicThumbnail a partir de um mapa
  YTMusicThumbnail.fromMap(Map<String, dynamic> map)
      : url = map['url'] as String,
        width = map['width'] as int,
        height = map['height'] as int;
  factory YTMusicThumbnail.fromJson(Map<String, dynamic> json) =>
      _$YTMusicThumbnailFromJson(json);

  /// Connect the generated [_$YTMusicThumbnailToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicThumbnailToJson(this);
}
