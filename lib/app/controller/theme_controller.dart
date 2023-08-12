import 'package:get/get.dart';
import 'package:onemm/app/controller/user_controller.dart';
import 'package:onemm/app/model/theme_list.dart';

import '../mapper/theme_mapper.dart';
import '../model/like_theme.dart';
import '../model/theme_item.dart';

class ThemeController extends GetxController {
  final ThemeMapper themeMapper;
  late UserController userController;

  final RxList _themeList = <ThemeList>[].obs;
  final RxList _themeListByUser = <ThemeList>[].obs;
  final RxList _themeItems = <ThemeItem>[].obs;
  final RxList _themeItemsByOneList = <ThemeItem>[].obs;
  final _likeTheme = LikeTheme(0, 0, false).obs;
  final RxList _likeThemeList = <LikeTheme>[].obs;
  final RxList _likeThemeItems = <ThemeItem>[].obs;
  final _myThemeList = ThemeList(0, "", "", false).obs;

  RxBool check = false.obs;
  RxBool isLoading = false.obs;
  RxBool likeBool = false.obs;
  RxBool noItems = false.obs;
  RxBool editBool = false.obs;

  ThemeController({required this.themeMapper});

  get themeList => _themeList.value;

  set themeList(value) => _themeList.value = value;

  get themeListByUser => _themeListByUser.value;

  set themeListByUser(value) => _themeListByUser.value = value;

  get themeItems => _themeItems.value;

  set themeItems(value) => _themeItems.value = value;

  get themeItemsByOneList => _themeItemsByOneList.value;

  set themeItemsByOneList(value) => _themeItemsByOneList.value = value;

  get likeTheme => _likeTheme.value;

  set likeTheme(value) => _likeTheme.value = value;

  get likeThemeList => _likeThemeList.value;

  set likeThemeList(value) => _likeThemeList.value = value;

  get likeThemeItems => _likeThemeItems.value;

  set likeThemeItems(value) => _likeThemeItems.value = value;

  get myThemeList => _myThemeList.value;

  set myThemeList(value) => _myThemeList.value = value;

  @override
  void onInit() async {
    super.onInit();
  }

  getThemeListAllByUser(int userId) async {
    return await themeMapper.getThemeListAllByUser(userId).then((data) {
      themeListByUser = data;
    });
  }

  getThemeListAll(int userId) async {
    return await themeMapper.getThemeListAll(userId).then((data) {
      themeList = data;
    });
  }

  getThemeItems(int id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    return await themeMapper.getThemeItems(id).then((data) {
      themeItems = data;
    });
  }

  getThemeItemsByOneList(int id) async {
    return await themeMapper.getThemeItems(id).then((data) {
      themeItemsByOneList = data;
    });
  }

  addThemeList(Map<String, dynamic> themeList) async {
    await themeMapper.addThemeList(themeList);
  }

  addThemeItem(Map<String, dynamic> themeItem) async {
    await themeMapper.addThemeItem(themeItem);
  }

  addThemeListLike(Map<String, dynamic> likeTheme) async {
    await themeMapper.addThemeListLike(likeTheme);
  }

  deleteThemeList(int id) async {
    await themeMapper.deleteThemeList(id);
  }

  deleteThemeListLike(int userId, int themeId) async {
    await themeMapper.deleteThemeListLike(userId, themeId);
  }

  getLikeThemeList(int userId) async {
    return await themeMapper.getLikeThemeList(userId).then((data) {
      likeThemeList = data;
    });
  }

  getLikeOneTheme(int userId, int themeId) async {
    likeTheme = await themeMapper.getLikeOneTheme(userId, themeId);
    likeBool.value = likeTheme.likeBool ?? false;
    return likeTheme;
  }

  getLikeThemeItems(int themeId) async {
    return await themeMapper.getThemeItems(themeId).then((data) {
      likeThemeItems = data;
    });
  }

  deleteThemeItem(int themeId, int storeId) async {
    await themeMapper.deleteThemeItem(themeId, storeId);
  }

  getOneThemeList(int themeId) async {
    myThemeList = await themeMapper.getOneThemeList(themeId);
    return myThemeList;
  }

  updateThemeList(int id, Map<String, dynamic> theme) async {
    await themeMapper.updateThemeList(id, theme);
  }
}
