import 'package:get/get.dart';
import 'package:onemm/app/mapper/like_store_mapper.dart';

import '../model/like_store.dart';

class LikeStoreController extends GetxController {
  final LikeStoreMapper likeStoreMapper;
  final _likeStore = LikeStore(0, 0, 0, false).obs;
  RxList _likeStoreList = <LikeStore>[].obs;
  RxBool likeBool = false.obs;
  final more = false.obs;

  LikeStoreController({required this.likeStoreMapper});

  get likeStore => _likeStore.value;

  set likeStore(value) => _likeStore.value = value;

  get likeStoreList => _likeStoreList.value;

  set likeStoreList(value) => _likeStoreList.value = value;

  addLike(Map<String, dynamic> likeStore) async {
    await likeStoreMapper.addLike(likeStore);
  }

  deleteLike(int userId, int storeId) async {
    await likeStoreMapper.deleteLike(userId, storeId);
  }

  getLikeOneStore(int userId, int storeId) async {
    likeStore = await likeStoreMapper.getLikeByStore(userId, storeId);
    likeBool.value = likeStore.likeBool ?? false;
    return likeStore;
  }

  getLikeByUser(int userId) async {
    return await likeStoreMapper.getLikeByUser(userId).then((data) {
      likeStoreList = data;
    });
  }

}
