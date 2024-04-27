import 'package:flutter/material.dart';
import 'package:piaoxingqiu/services/shared_prefrences_service.dart';

import 'package:piaoxingqiu/services/sms_service.dart';
import 'package:piaoxingqiu/services/user_service.dart';
import 'package:piaoxingqiu/helpers/logger.dart';

class UserModel extends ChangeNotifier {
  String phone = '';
  String photoCode = '';
  String smsCode = '';
  String accessToken = '';
  String refreshToken = '';

  void setPhone(String phone) async {
    this.phone = phone;
    (await SharedPreferencesService.getInstance()).setPhone(phone);
    notifyListeners();
  }

  void setPhotoCode(String photoCode) {
    this.photoCode = photoCode;
    notifyListeners();
  }

  void setSmsCode(String smsCode) {
    this.smsCode = smsCode;
    notifyListeners();
  }

  Future<bool> sendVerifySms() async {
    if (phone.isEmpty || photoCode.isEmpty) return false;
    await SmsService().sendVerifyCode(phone, photoCode);
    logError('sms msg send to $phone, code is $photoCode');
    return true;
  }

  Future<bool> login() async {
    logError('username: $phone, smsCode: $smsCode');
    if (phone.isEmpty || smsCode.isEmpty) return false;
    Map<String, dynamic> res = await UserService().login(phone, smsCode);

    accessToken = res['accessToken'];
    refreshToken = res['refreshToken'];
    final sharedPreferencesService =
        await SharedPreferencesService.getInstance();
    await sharedPreferencesService.setAccessToken(accessToken);
    await sharedPreferencesService.setRefreshToken(refreshToken);

    logError(toString());
    notifyListeners();
    return true;
  }

  @override
  String toString() {
    return 'UserModel{phone: $phone, photoCode: $photoCode, smsCode: $smsCode, accessToken: $accessToken, refreshToken: $refreshToken}';
  }
}
