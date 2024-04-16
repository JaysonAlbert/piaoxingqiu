import 'package:flutter/material.dart';

import 'package:piaoxingqiu/services/sms_service.dart';
import 'package:piaoxingqiu/services/user_service.dart';

class UserModel extends ChangeNotifier {
  String phone = '';
  String photoCode = '';
  String smsCode = '';
  String accessToken = '';
  String refreshToken = '';

  void setPhone(String phone) {
    this.phone = phone;
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
    print('sms msg send to $phone, code is $photoCode');
    return true;
  }

  Future<bool> login() async {
    print('username: $phone, smsCode: $smsCode');
    if (phone.isEmpty || smsCode.isEmpty) return false;
    Map<String, dynamic> res = await UserService().login(phone, smsCode);
    accessToken = res['accessToken'];
    refreshToken = res['refreshToken'];
    print(toString());
    notifyListeners();
    return true;
  }

  @override
  String toString() {
    return 'UserModel{phone: $phone, photoCode: $photoCode, smsCode: $smsCode, accessToken: $accessToken, refreshToken: $refreshToken}';
  }
}
