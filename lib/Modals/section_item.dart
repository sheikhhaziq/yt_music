
import 'package:json_annotation/json_annotation.dart';

import '../enums/item_type.dart';
import 'modals.dart';

part 'section_item.g.dart';

@JsonSerializable()
class SectionItem {
  final String title;
  final String id;
  final bool isExplicit;
  final ItemType type;
  final String? playlistId;
  final String? duration;
  final Map<String, dynamic> endpoint;
  final List<Thumbnail> thumbnails;
  final List<ArtistBasic> artists;
  final AlbumBasic? album;
  final String? subtitle;
  final bool isHorizontal;
  SectionItem({
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
  factory SectionItem.fromJson(Map<String, dynamic> json) =>
      _$SectionItemFromJson(json);

  /// Connect the generated [_$SectionItemToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SectionItemToJson(this);
}
