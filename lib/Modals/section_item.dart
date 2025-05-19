
import 'package:json_annotation/json_annotation.dart';

import '../enums/item_type.dart';
import 'modals.dart';

part 'section_item.g.dart';

@JsonSerializable()
class YTMusicSectionItem {
  final String title;
  final String id;
  final bool isExplicit;
  final YTMusicItemType type;
  final String? playlistId;
  final String? duration;
  final Map<String, dynamic> endpoint;
  final List<YTMusicThumbnail> thumbnails;
  final List<YTMusicArtistBasic> artists;
  final YTMusicAlbumBasic? album;
  final String? subtitle;
  final bool isHorizontal;
  YTMusicSectionItem({
    required this.title,
    required this.id,
    this.isExplicit = false,
    required this.type,
    this.playlistId,
    this.duration,
    required this.endpoint,
    required this.thumbnails,
    required this.artists,
    this.subtitle,
    this.isHorizontal = false,
    this.album,
  });
  factory YTMusicSectionItem.fromJson(Map<String, dynamic> json) =>
      _$YTMusicSectionItemFromJson(json);

  /// Connect the generated [_$YTMusicSectionItemToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicSectionItemToJson(this);
}
