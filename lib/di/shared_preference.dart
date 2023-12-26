import 'dart:convert';

import 'package:bronco_trucking/models/response/user_data.dart';
import 'package:bronco_trucking/ui/common/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference extends SharedPreferenceRepository {
  SharedPreferences? _pref;

  SharedPreference._privateConstructor();

  static final SharedPreference instance =
      SharedPreference._privateConstructor();

  @override
  Future<bool?> clearData() async {
    return _pref?.clear();
  }

  Future<SharedPreferences> initPreference() async =>
      _pref = await SharedPreferences.getInstance();

  @override
  Future<bool> isLogin() async {
    _pref ??= await initPreference();
    return _pref!.getBool(Constant.preIsLogin) ?? false;
  }

  @override
  Future<LoginType> getLoginType() async {
    _pref ??= await initPreference();
    var index = _pref!.getInt(Constant.preLoginType) ?? 0;
    return LoginType.values[index];
  }

  @override
  void setIsLogin() {
    _pref!.setBool(Constant.preIsLogin, true);
  }

  @override
  void setLoginType(LoginType loginType) {
    _pref!.setInt(Constant.preLoginType, loginType.index);
  }

  @override
  Future<UserData> getUserData() async {
    _pref ??= await initPreference();
    var jsonData = _pref!.getString(Constant.preUserData);
    return UserData.fromJson(jsonDecode(jsonData!) as Map<String, dynamic>);
  }

  @override
  void setUserData(UserData userData) {
    _pref!.setString(Constant.preUserData, jsonEncode(userData.toJson()));
  }
}

abstract class SharedPreferenceRepository {
  Future<bool?> clearData();

  Future<bool> isLogin();

  Future<LoginType> getLoginType();

  void setIsLogin();

  void setLoginType(LoginType loginType) {}

  void setUserData(UserData userData) {}

  Future<UserData> getUserData();
}
