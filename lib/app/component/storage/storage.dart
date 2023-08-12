import 'package:onemm/app/component/storage/storage_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Future<bool> remove(StorageKey key) async {
    final storage = await SharedPreferences.getInstance();
    return storage.remove(key.name);
  }

  Future<void> setBool(StorageKey key, bool value) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setBool(key.name, value);
  }

  Future<bool?> getBool(StorageKey key) async {
    final storage = await SharedPreferences.getInstance();
    return storage.getBool(key.name);
  }

  Future<void> setString(StorageKey key, String value) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(key.name, value);
  }

  Future<String?> getString(StorageKey key) async {
    final storage = await SharedPreferences.getInstance();
    return storage.getString(key.name);
  }
}
