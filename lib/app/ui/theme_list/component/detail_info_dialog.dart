import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:onemm/app/controller/store_controller.dart';
import 'package:onemm/app/model/theme_item.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../model/theme_list.dart';
import '../../common/style.dart';
import '../../component/save_button.dart';

class DetailInfoDialog extends GetView<StoreController> {
  var _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';

  Future<dynamic> first_dialog(context) {
    int _len = controller.themeController.themeListByUser.length;
    List<bool> isChecked = List.generate(_len, (index) => false);
    String _getTitle() => "Checkbox Demo : Checked = ${isChecked.where((check) => check == true).length}, Unchecked = ${isChecked.where((check) => check == false).length}";
    String _title = "Checkbox Demo";
    List<int> selectedButtonList = List.empty(growable: true);

    return Get.dialog(StatefulBuilder(builder: (context, state) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AlertDialog(
          content: Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.store.name, style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp, fontWeight: FontWeight.w700)),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                InkWell(
                  onTap: () {
                    second_dialog(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.add_circle_outline_sharp, size: 16, color: OnemmColor.DARK_GRAY_COLOR),
                      SizedBox(width: 5.w),
                      Text(
                        "새 테마리스트 만들기",
                        style: TextStyle(
                          fontSize: FontSize.TITLE_MIDDLE_16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Container(color: OnemmColor.LIGHT_GRAY_COLOR, width: double.infinity, height: 1.h),
                SizedBox(height: 15.h),
                StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: _len,
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return ZoomTapAnimation(
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            title: Transform.translate(
                              offset: Offset(-16, 0),
                              child: Text(
                                "${controller.themeController.themeListByUser[index].title}",
                                style: TextStyle(fontSize: FontSize.BASIC_TEXT.sp),
                              ),
                            ),
                            leading: Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                  activeColor: OnemmColor.ONE_MM_COLOR,
                                  // checkColor: Colors.orange,
                                  onChanged: (checked) {
                                    setState(
                                      () {
                                        isChecked[index] = checked!;
                                        _title = _getTitle();
                                        selectedButtonList.add(controller.themeController.themeListByUser[index].id);
                                      },
                                    );
                                  },
                                  value: isChecked[index]),
                            ),
                          ),
                        );
                      });
                    },
                  );
                }),
                SizedBox(height: 30.h),
                SaveButton(() async {
                  List<int> result = selectedButtonList.toList();
                  for (int i in result) {
                    ThemeItem themeItem = ThemeItem(i, controller.store.id);
                    await controller.themeController.addThemeItem(themeItem.toJson());
                    print("저장완료");
                  }
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
      );
    }));
  }

  Future<dynamic> second_dialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Form(
              key: this._formKey,
              child: Padding(
                padding: CustomStyle.PADDING,
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "새 테마리스트",
                          style: TextStyle(fontSize: FontSize.TITLE_MIDDLE_16.sp),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.close, size: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    TextFormField(
                      controller: _controller,
                      maxLength: 20,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                        filled: true,
                        fillColor: OnemmColor.GRAY_COLOR_1,
                        hintText: "새 테마리스트 이름",
                        hintStyle: TextStyle(fontSize: 14.sp),
                        suffixIcon: IconButton(
                          onPressed: _controller.clear,
                          icon: Icon(
                            Icons.close,
                            size: 14.sp,
                            color: OnemmColor.DARK_GRAY_COLOR,
                          ),
                        ),
                      ),
                      onSaved: (val) {
                        this.title = val!;
                        print(val);
                      },
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '내용을 입력해주세요.';
                        }
                      },
                    ),
                    SizedBox(height: 30.h),
                    TextFormField(
                      maxLength: 300,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
                        filled: true,
                        fillColor: OnemmColor.GRAY_COLOR_1,
                        hintText: "어떤 테마인지 부연 설명을 적어주시면 좋아요!",
                        hintStyle: TextStyle(fontSize: 14.sp),
                      ),
                      maxLines: 10,
                      minLines: 6,
                      onSaved: (val) {
                        this.description = val!;
                        print(val);
                      },
                    ),
                    SizedBox(height: 30.h),
                    SaveButton(() async {
                      _formKey.currentState?.save();

                      ThemeList newThemeList = ThemeList(controller.userController.user.id, title, description, false);
                      await controller.themeController.addThemeList(newThemeList.toJson());
                      await controller.themeController.getThemeListAllByUser(controller.userController.user.id);

                      Navigator.pop(context);
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
