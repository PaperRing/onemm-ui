import 'package:get/get.dart';
import 'package:onemm/app/mapper/search_mapper.dart';

import '../model/search.dart';
import 'dto/store_dto.dart';

class SearchController extends GetxController {
  final SearchMapper searchMapper;

  final RxList _storeDto = <StoreDto>[].obs;
  final RxList _record = <Search>[].obs;

  SearchController({required this.searchMapper});

  get storeDto => _storeDto.value;

  set storeDto(value) => _storeDto.value = value;

  get record => _record.value;

  set record(value) => _record.value = value;

  searchStoreName(String storeName) async {
    return await searchMapper.searchStoreName(storeName);
  }

  saveSearchRecord(Map<String, dynamic> record) async {
    await searchMapper.saveSearchRecord(record);
  }

  getSearchRecord(int userId) async {
    return await searchMapper.getSearchRecord(userId).then((data) {
      record = data;
    });
  }

  deleteRecord(int id) async {
    await searchMapper.deleteRecord(id);
  }
}
