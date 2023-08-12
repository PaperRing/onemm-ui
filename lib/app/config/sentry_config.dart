import 'package:sentry_flutter/src/sentry_flutter_options.dart';

class SentryConfig {
  void setOption(SentryFlutterOptions options) {
    options.dsn = 'https://145881df638b4eb4bcd97e09aed78fef@o4505510182715393.ingest.sentry.io/4505511234240512';
    options.tracesSampleRate = 1.0;
  }
}
