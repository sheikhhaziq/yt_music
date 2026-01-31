import 'package:gyawun_services/gyawun_services.dart';

class YtContinuationPayload extends ContinuationPayload {
  final String continuation;
  // final Map<String, dynamic> params;

  YtContinuationPayload({required this.continuation});
}
