import 'dart:convert';

import 'package:app/constants/storage_keys.dart';
import 'package:app/di.dart';
import 'package:app/libraries/local_storage.dart';
import 'package:app/models/user/user.dart';

class StorageService {
  var storage = sl<LocalStorage>();

  Future<void> removeData({required String key}) => storage.removeData(key: key);

  bool get onboardStatus => storage.readData(key: ON_BOARD) ?? false;
  void setOnboardStatus(bool status) => storage.storeData(key: ON_BOARD, value: status);

  bool get rememberMe => storage.readData(key: REMEMBER) ?? false;
  void setRememberStatus(bool status) => storage.storeData(key: REMEMBER, value: status);

  bool get authStatus => storage.readData(key: AUTH_STATUS) ?? false;
  void setAuthStatus(bool status) => storage.storeData(key: AUTH_STATUS, value: status);

  String get username => storage.readData(key: USERNAME) ?? '';
  void setUsername(String email) => storage.storeData(key: USERNAME, value: email);

  String get password => storage.readData(key: PASSWORD) ?? '';
  void setPassword(String passcode) => storage.storeData(key: PASSWORD, value: passcode);

  String get accessToken => storage.readData(key: ACCESS_TOKEN) ?? '';
  void setAccessToken(String token) => storage.storeData(key: ACCESS_TOKEN, value: token);

  String get refreshToken => storage.readData(key: REFRESH_TOKEN) ?? '';
  void setRefreshToken(String token) => storage.storeData(key: REFRESH_TOKEN, value: token);

  User get user => !storage.hasLocalData(key: USER) ? User() : User.fromJson(json.decode(storage.readData(key: USER)));
  void setUser(User? data) => data == null ? null : storage.storeData(key: USER, value: json.encode(data));
}
