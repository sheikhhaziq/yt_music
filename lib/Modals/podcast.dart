
import 'package:json_annotation/json_annotation.dart';

import 'modals.dart';

part 'podcast.g.dart';

@JsonSerializable()
class YTMusicPodcastPage {
  final String podcastId;
  final String title;
  final String subtitle;
  // final Map<String, dynamic>? playEndpoint;
  // final Map<String, dynamic>? shuffleEndpoint;
  // final Map<String, dynamic>? radioEndpoint;
  // final ArtistBasic artist;
  final String secondSubtitle;
  final List<YTMusicThumbnail> thumbnails;
  final String? description;
  final List<YTMusicSection> sections;
  final String? continuation;

  YTMusicPodcastPage({
    required this.podcastId,
    required this.title,
    // required this.artist,
    required this.subtitle,
    // this.playEndpoint,
    // this.shuffleEndpoint,
    // this.radioEndpoint,
    required this.secondSubtitle,
    required this.thumbnails,
    this.description,
    required this.sections,
    this.continuation,
  });

  copyWith({
    String? podcastId,
    String? title,
    String? subtitle,
    Map<String, dynamic>? playEndpoint,
    Map<String, dynamic>? shuffleEndpoint,
    Map<String, dynamic>? radioEndpoint,
    YTMusicArtistBasic? artist,
    String? secondSubtitle,
    List<YTMusicThumbnail>? thumbnails,
    String? description,
    List<YTMusicSection>? sections,
    String? continuation,
  }) =>
      YTMusicPodcastPage(
        podcastId: podcastId ?? this.podcastId,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        // playEndpoint: playEndpoint ?? this.playEndpoint,
        // shuffleEndpoint: shuffleEndpoint ?? this.shuffleEndpoint,
        // radioEndpoint: radioEndpoint ?? this.radioEndpoint,
        // artist: artist ?? this.artist,
        secondSubtitle: secondSubtitle ?? this.secondSubtitle,
        thumbnails: thumbnails ?? this.thumbnails,
        description: description ?? this.description,
        sections: sections ?? this.sections,
        continuation: continuation ?? this.continuation,
      );

  factory YTMusicPodcastPage.fromJson(Map<String, dynamic> json) =>
      _$YTMusicPodcastPageFromJson(json);

  /// Connect the generated [_$YTMusicPodcastPageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$YTMusicPodcastPageToJson(this);
}
