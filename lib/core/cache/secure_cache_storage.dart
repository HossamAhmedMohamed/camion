import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureCacheHelper {
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  //! Save data securely
  Future<void> saveData({
    required String key,
    required String value, // flutter_secure_storage بيخزن Strings بس
  }) async {
    await _secureStorage.write(key: key, value: value);
  }

  //! Get data securely
  Future<String?> getData({
    required String key,
  }) async {
    return await _secureStorage.read(key: key);
  }

  //! Remove specific key
  Future<void> removeData({
    required String key,
  }) async {
    await _secureStorage.delete(key: key);
  }

  //! Check if key exists
  Future<bool> containsKey({
    required String key,
  }) async {
    final allKeys = await _secureStorage.readAll();
    return allKeys.containsKey(key);
  }

  //! Clear all secure data
  Future<void> clearData() async {
    await _secureStorage.deleteAll();
  }

  //! Write any dynamic value by converting it to string
  Future<void> put({
    required String key,
    required dynamic value,
  }) async {
    await _secureStorage.write(key: key, value: value.toString());
  }

  //! Read and parse as needed
  Future<int?> getInt(String key) async {
    final value = await getData(key: key);
    return value != null ? int.tryParse(value) : null;
  }

  Future<bool?> getBool(String key) async {
    final value = await getData(key: key);
    return value == 'true' ? true : value == 'false' ? false : null;
  }

  Future<double?> getDouble(String key) async {
    final value = await getData(key: key);
    return value != null ? double.tryParse(value) : null;
  }
}
