
import 'package:json_annotation/json_annotation.dart';

import 'modals.dart';

part 'album.g.dart';

@JsonSerializable()
class YTMusicAlbumBasic {
  final String albumId;
  final String name;

  final Map<String, dynamic>? endpoint;

  YTMusicAlbumBasic({required this.albumId, required this.name, this.endpoint});

  // Construtor nomeado para criar uma YTMusicAlbumBasic a partir de um mapa
  YTMusicAlbumBasic.fromMap(Map<String, dynamic> map)
      : albumId = map['albumId'] as String,
        name = map['name'] as String,
        endpoint = map['endpoint'];
  factory YTMusicAlbumBasic.fromJson(Map<String, dynamic> json) =>
      _$YTMusicAlbumBasicFromJson(json);

  /// Connect the generated [_$YTMusicAlbumBasicToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicAlbumBasicToJson(this);
}
@JsonSerializable()
class YTMusicAlbumPage {
  final String playlistId;
  final String title;
  final String subtitle;
  final Map<String, dynamic>? playEndpoint;
  final Map<String, dynamic>? playPlaylistEndpoint;
  final Map<String, dynamic>? shuffleEndpoint;
  final Map<String, dynamic>? radioEndpoint;
  final List<YTMusicArtistBasic> artists;
  final String secondSubtitle;
  final List<YTMusicThumbnail> thumbnails;
  final String? description;
  final List<YTMusicSection> sections;

  YTMusicAlbumPage({
    required this.playlistId,
    required this.title,
    required this.artists,
    required this.subtitle,
    this.playEndpoint,
    this.playPlaylistEndpoint,
    this.shuffleEndpoint,
    this.radioEndpoint,
    required this.secondSubtitle,
    required this.thumbnails,
    this.description,
    required this.sections,
  });

  factory YTMusicAlbumPage.fromJson(Map<String, dynamic> json) =>
      _$YTMusicAlbumPageFromJson(json);

  /// Connect the generated [_$YTMusicAlbumPageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicAlbumPageToJson(this);
}
