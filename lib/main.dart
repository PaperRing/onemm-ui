import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/component/error.dart';
import 'package:onemm/app/routes/app_page.dart';
import 'package:onemm/app/routes/app_routes.dart';
import 'package:onemm/app/ui/common/style.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

// import 'app/component/slack/slack_message.dart';
import 'app/config/sentry_config.dart';
import 'app/ui/exception/error_page.dart';
import 'firebase_options.dart';

void splash() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  sleep(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

void firebase() async {
  await Firebase.initializeApp(name: "dev project", options: DefaultFirebaseOptions.currentPlatform);
}

void flutterReportError() {
  FlutterError.onError = (FlutterErrorDetails details) async {
    // await Error.exec(details.exception, details.stack, SlackMessage.FLUTTER_REPORT_ERROR, details.toString());
    // exit(1);
  };
}

Widget flutterBuildError(Widget? widget) {
  if (widget == null) throw Exception('widget is null');

  ErrorWidget.builder = (FlutterErrorDetails details) {
    // Error.exec(details.exception, details.stack, SlackMessage.FLUTTER_BUILD_ERROR, details.toString());
    return const ErrorPage();
  };
  return widget;
}

Widget app() {
  return ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (BuildContext context, Widget? child) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      return GetMaterialApp(
        builder: (context, widget) => flutterBuildError(widget),
        theme: ThemeData(
          fontFamily: 'spoqa',
          backgroundColor: Colors.white,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          primaryColor: OnemmColor.BACKGROUND_COLOR,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.INITIAL,
        defaultTransition: Transition.cupertino,
        getPages: AppPages.pages,
      );
    },
  );
}

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await SentryFlutter.init(
    (options) => SentryConfig().setOption(options),
    appRunner: () {
      runZonedGuarded(
        () async {
          splash();
          firebase();
          flutterReportError();
          runApp(app());
        },
        (exception, stack) {
          Sentry.captureException(exception, stackTrace: stack);
          Get.offAllNamed(AppRoutes.ERROR);
        },
      );
    },
  );
}
