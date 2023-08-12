import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

import '../common/bottom_navigator.dart';
import 'store_list/component/store_category.dart';

class NearByPage extends GetView<StoreController> {
  final int selected;

  const NearByPage({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigator(),
      body: Obx(() {
        return SafeArea(
          child: controller.isLoading.value ? Center(child: CircularProgressIndicator()) : StoreCategory(selected),
        );
      }),
    );
  }
}
