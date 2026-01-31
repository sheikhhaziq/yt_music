import 'package:flutter_test/flutter_test.dart';
import 'package:yt_music/modals/yt_browse_payload.dart';
import 'package:yt_music/modals/yt_continuation_payload.dart';
import 'package:yt_music/yt_music_provider.dart';

void main() async {
  final provider = YtMusicProvider();
  await provider.initialize({
    'visitorData': 'CgtGRnVYcEZpMzVRQSicwffLBjIKCgJJThIEGgAgTw%3D%3D',
    'language': 'en-GB',
    'location': 'IN',
    'apiKey': 'AIzaSyC9XL3ZjWddXya6X74dJoCTL-WEYFDNX30',
    'clientName': 'WEB_REMIX',
    'clientVersion': '1.20260128.03.00',
  });
  test("Get YT config", () async {
    final result = await provider.browse(null);
    print((result.continuationPayload as YtContinuationPayload).continuation);
  });
  test('Get Home Continuation', () async {
    final continuation =
        '4qmFsgKrAhIMRkVtdXNpY19ob21lGpoCQ0FONnpBRkhTa2hXZEhKMlVYUmFTVVJYYjFWQ1EyOUpRa05wVWpWa1JqbDNXVmRrYkZnelRuVlpXRUo2WVVjNU1GZ3lNVEZqTW14cVdETkNhRm95Vm1aamJWWnVZVmM1ZFZsWGQxTklla0Y1WlVVeGJsUXlVbE5PUldSeVdXc3hTbFl3Vmt4VGEzZDZZMU14UW1FemJGcFRWR1F6VlcxellVOVZNVEZqTW14cVVrZHNlbGt5T1RKYVdFbzFWVWRHYmxwV1RteGpibHB3V1RKVmRGSXlWakJUUnpsMFdsWkNhRm95VlVGQlVVSnNZbWt4U0ZGblFVSlRWVFJCUVZWc1QwRkJSVUpCWDNGamVEY3dTa0ZuWjBVJTNE';
    final res = await provider.browseContinuation(
      YtContinuationPayload(continuation: continuation),
    );
    print(res.sections.length);
  });

  test('Get Playlist', () async {
    final result = await provider.browse(
      YtBrowsePayload(
        params: {
          "browseId": "VLRDCLAK5uy_lBNUteBRencHzKelu5iDHwLF6mYqjL-JU",
          "browseEndpointContextSupportedConfigs": {
            "browseEndpointContextMusicConfig": {
              "pageType": "MUSIC_PAGE_TYPE_PLAYLIST",
            },
          },
        },
      ),
    );
    print((result.continuationPayload as YtContinuationPayload).continuation);
  });
  test("Get Playlist continuation", () async {
    final result = provider.browseContinuation(
      YtContinuationPayload(
        continuation:
            '4qmFsgI9Ei1WTFJEQ0xBSzV1eV9sQk5VdGVCUmVuY0h6S2VsdTVpREh3TEY2bVlxakwtSlUaDGtnRURDTTBHOEFFQQ%3D%3D',
      ),
    );
  });
  test("get Album", () async {
    await provider.browse(
      YtBrowsePayload(
        params: {
          "browseId": "MPREb_MftU5XaVmDX",
          "params":
              "ggMrGilPTEFLNXV5X25ENXJuTUNlNzM3aUh2X085YWg5TXdWeDZzbE5DQkpBYw%3D%3D",
          "browseEndpointContextSupportedConfigs": {
            "browseEndpointContextMusicConfig": {
              "pageType": "MUSIC_PAGE_TYPE_ALBUM",
            },
          },
        },
      ),
    );
  });
}
