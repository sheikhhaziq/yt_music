
import '../Modals/modals.dart';
import '../utils/traverse.dart';
import 'parser.dart';

class PodcastParser {
  static parse(dynamic data) {
    final contents = data['contents']['twoColumnBrowseResultsRenderer'];
    final secondaryContents = contents['secondaryContents'];
    final sections = secondaryContents['sectionListRenderer']['contents'];

    final header = contents['tabs'][0]['tabRenderer']['content']
        ['sectionListRenderer']['contents'][0]['musicResponsiveHeaderRenderer'];
    // [thumbnail, buttons, title, subtitle, trackingParams, straplineTextOne, straplineThumbnail, description]
    return YTMusicPodcastPage(
      podcastId: 'playlistId',
      // continuation: continuation,
      title: traverseString(header['title'], ["text"]) ?? '',
      subtitle: traverseList(header['subtitle'], ['runs', 'text']).join(),
      secondSubtitle:
          traverseList(header['secondSubtitle'], ['runs', 'text']).join(),
      description:
          traverseString(header['description'], ['description', 'text']),

      thumbnails: traverseList(header, ['thumbnail', 'thumbnail', 'thumbnails'])
          .map((item) => YTMusicThumbnail.fromMap(item))
          .toList(),
      sections: sections
          .map(Parser.parseSection)
          .where((e) => e != null)
          .cast<YTMusicSection>()
          .toList(),
    );
  }
}
