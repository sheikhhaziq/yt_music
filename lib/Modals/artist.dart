
import 'package:json_annotation/json_annotation.dart';

import 'modals.dart';

part 'artist.g.dart';

@JsonSerializable()
class YTMusicArtistBasic {
  final String? artistId;
  final Map<String, dynamic>? endpoint;
  final String name;

  YTMusicArtistBasic({
    this.artistId,
    required this.name,
    this.endpoint,
  });

  // Construtor nomeado para criar uma YTMusicArtistBasic a partir de um mapa
  YTMusicArtistBasic.fromMap(Map<String, dynamic> map)
      : artistId = map['artistId'] as String?,
        name = map['name'] as String,
        endpoint = map['endpoint'];
  factory YTMusicArtistBasic.fromJson(Map<String, dynamic> json) =>
      _$YTMusicArtistBasicFromJson(json);

  /// Connect the generated [_$YTMusicArtistBasicToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicArtistBasicToJson(this);
}

class YTMusicArtistPage {
  final String name;
  final List<YTMusicSection> sections;
  final String description;
  final List<YTMusicThumbnail>? thumbnails;
  final Map<String, dynamic>? playEndpoint;
  final Map<String, dynamic>? shuffleEndpoint;
  final Map<String, dynamic>? radioEndpoint;
  final String? subscribers;
  final String? channelId;

  // final List<Thumbnail> thumbnails;
  // final List<SongDetailed> topSongs;
  // final List<AlbumDetailed> topAlbums;
  // final List<AlbumDetailed> topSingles;
  // final List<VideoDetailed> topVideos;
  // final List<PlaylistDetailed> featuredOn;
  // final List<ArtistDetailed> similarArtists;

  YTMusicArtistPage({
    required this.name,
    required this.sections,
    required this.description,
    this.thumbnails,
    this.playEndpoint,
    this.radioEndpoint,
    this.shuffleEndpoint,
    this.channelId,
    this.subscribers,
  });
}
