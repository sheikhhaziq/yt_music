
import '../Modals/modals.dart';
import '../utils/traverse.dart';
import 'parser.dart';

class BrowseParser {
  static Section parseContinuation(data) {
    return Parser.parseSection(data['continuationContents']) as Section;
  }

  static List<SectionItem> parseMore(data) {
    final sectionListRenderer = traverse(data['contents'], [
      'singleColumnBrowseResultsRenderer',
      'tabs',
      'sectionListRenderer',
    ]);
    List contents = [];
    if (sectionListRenderer is! List) {
      contents = traverse(sectionListRenderer, ['gridRenderer', 'items']);
      if (contents.isEmpty) {
        contents = traverse(
            sectionListRenderer, ['musicPlaylistShelfRenderer', 'contents']);
      }
      if (contents.isEmpty) {
        contents = traverse(
            sectionListRenderer, ['musicCarouselShelfRenderer', 'contents']);
      }
    }

    if (contents.isEmpty) {
      contents = traverse(data['contents'], [
        'twoColumnBrowseResultsRenderer',
        'secondaryContents',
        'contents',
        'musicPlaylistShelfRenderer',
        'contents'
      ]);
    }

    return contents
        .map(Parser.parseSectionItem)
        .where((el) => el != null)
        .toList()
        .cast();
  }
}
