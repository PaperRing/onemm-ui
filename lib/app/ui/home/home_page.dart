import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onemm/app/ui/home/component/main_category.dart';
import 'package:onemm/app/ui/home/component/main_popular.dart';
import 'package:onemm/app/ui/home/component/main_theme_list.dart';
import 'package:upgrader/upgrader.dart';

import '../../controller/store_controller.dart';
import '../common/bottom_navigator.dart';
import '../common/main_app_bar.dart';

class HomePage extends GetView<StoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppbar(),
      body: UpgradeAlert(
          upgrader: Upgrader(
              messages: UpgraderMessages(code: 'ko'),
              shouldPopScope: () => true,
              canDismissDialog: true,
              durationUntilAlertAgain: const Duration(days: 1),
              dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material),
          child: home()),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  Widget home() {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [MainCategory(), const MainPopular(), MainThemeList()],
    );
  }
}
