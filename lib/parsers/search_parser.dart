import '../Modals/section.dart';
import 'parser.dart';
import '../utils/traverse.dart';

class SearchParser {
  static YTMusicSection parseMore(dynamic data) {
    // [title, selected, content, tabIdentifier, trackingParams]
    final contents = traverse(data, [
      'contents',
      'tabbedSearchResultsRenderer',
      'tabs',
      'tabRenderer',
      'sectionListRenderer',
      'contents'
    ]);

    return Parser.parseSection(contents[0]) as YTMusicSection;
  }

  static YTMusicSection parseMoreContinuation(data) {
    return Parser.parseSection(data['continuationContents']) as YTMusicSection;
  }
}
