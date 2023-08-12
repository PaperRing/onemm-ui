import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';

class LoadData extends GetView<StoreController> {
  Future loadData(id, context) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    await controller.reviewController.getAllByStore(id, controller.userController.userId!);

    await controller.getStoreById(id);
    await controller.getFacilityByStoreId(id);
    await controller.getCategoryByStoreId(id);
    await controller.getMenuByStoreId(id);
    await controller.getWorkDayByStoreId(id);

    if (controller.userController.uid != '') {
      try {
        await controller.likeStoreController.getLikeOneStore(controller.userController.userId!, id);
      } catch (e) {}
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
