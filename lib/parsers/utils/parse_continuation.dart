import 'package:yt_music/modals/yt_continuation_payload.dart';

YtContinuationPayload? parseContinuationString(List<dynamic>? json) {
  if (json == null) return null;
  final continuation =
      json.firstOrNull?['nextContinuationData']?['continuation'] as String?;
  if (continuation == null) return null;
  return YtContinuationPayload(continuation: continuation);
}
