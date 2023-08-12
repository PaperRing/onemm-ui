// import 'dart:io';
//
// // import 'package:onemm/app/component/slack/slack.dart';
// // import 'package:onemm/app/component/slack/slack_channel.dart';
// // import 'package:onemm/app/component/slack/slack_message.dart';
// import 'package:logger/logger.dart';
// import 'package:sentry_flutter/sentry_flutter.dart';
//
// class Error {
//   Error._();
//
//   static final _logger = Logger(
//     printer: PrettyPrinter(
//       printEmojis: false,
//       methodCount: 2,
//       errorMethodCount: 8,
//       colors: false,
//       noBoxingByDefault: true,
//     ),
//   );
//   //
// static Future<void> exec(dynamic exception, StackTrace? stack, SlackMessage message, [String? additional]) async {
//   _logger.e(additional ?? '', exception, stack);
//   final sentryId = await Sentry.captureException(exception, stackTrace: stack);
//   await Slack.notify(message, SlackChannel.CARRY_ERROR_LOG, sentryId);
// }
// }
