import '../Modals/modals.dart';
import 'parser.dart';
import '../utils/traverse.dart';

class ProfileParser {
  static YTMusicProfilePage parse(dynamic data) {
    final List contents = traverse(data, [
      'contents',
      'singleColumnBrowseResultsRenderer',
      'tabs',
      'tabRenderer',
      'sectionListRenderer',
      'contents'
    ]);

    final header = data['header'];
    final thumbs = traverseList(header, ["thumbnail", "thumbnails"])
        .map((item) => YTMusicThumbnail.fromMap(item))
        .toList();
    return YTMusicProfilePage(
      name: traverseString(header, ["title", "text"]) ?? '',
      description: traverseString(header, ["description", "text"]),
      subscribers: traverseString(
          header, ["subscriptionButton", "subscriberCountText", "text"]),
      channelId: traverseString(header, ["subscriptionButton", "channelId"]),
      thumbnails: thumbs.isNotEmpty ? thumbs : null,
      sections: contents
          .map(Parser.parseSection)
          .where((e) => e != null)
          .toList()
          .cast<YTMusicSection>(),
    );
  }
}
