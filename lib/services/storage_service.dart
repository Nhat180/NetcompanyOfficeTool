import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:netcompany_office_tool/model/storage_item.dart';

class StorageService {
  final secureStorage = const FlutterSecureStorage();

  AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true);

  Future<void> writeSecureData (StorageItem item) async {
    await secureStorage.write(key: item.key, value: item.value, aOptions: _getAndroidOptions());
  }

  Future<String?> readSecureData (String key) async {
    var readData = await secureStorage.read(key: key, aOptions: _getAndroidOptions());
    return readData;
  }

  Future<void> deleteSecureData (StorageItem item) async {
    await secureStorage.delete(key: item.key, aOptions: _getAndroidOptions());
  }

  Future<void> deleteAllSecureData() async {
    await secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }

  Future<bool> isContainKey (String key) async {
    var isContain = await secureStorage.containsKey(key: key, aOptions: _getAndroidOptions());
    return isContain;
  }
}