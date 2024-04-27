import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:piaoxingqiu/models/user.dart';
import 'package:piaoxingqiu/services/captcha_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:piaoxingqiu/helpers/logger.dart';

class CaptchaWidget extends StatefulWidget {
  const CaptchaWidget({super.key});

  @override
  _CaptchaWidgetState createState() => _CaptchaWidgetState();
}

class _CaptchaWidgetState extends State<CaptchaWidget> {
  final CaptchaService captchaService = CaptchaService();
  final TextEditingController _captcha = TextEditingController();

  String _phoneNumber = '';
  String? _captchaBase64;

  void _reloadCaptcha() {
    _captchaBase64 = null;
    _loadCaptcha();
  }

  void _loadCaptcha() async {
    try {
      if (_phoneNumber.isEmpty || _captchaBase64 != null) {
        return;
      }
      String captcha = await captchaService.generateCaptcha(_phoneNumber);
      setState(() {
        _captchaBase64 = captcha;
      });
    } catch (e, stack) {
      logError('Failed to load captcha: ', e, stack);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to load captcha'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget _imageFromBase64(String? base64) {
    if (base64 == null || base64.isEmpty) return Container();
    final base64Data = base64.split(',').last;
    return Image.memory(base64Decode(base64Data), height: 32, width: 32);
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Consumer<UserModel>(builder: (context, userModel, child) {
      if (_phoneNumber != userModel.phone || _captchaBase64 == null) {
        _phoneNumber = userModel.phone;
        _reloadCaptcha();
      }

      return TextFormField(
        controller: _captcha,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            return null;
          }
          return localizations.captcha;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              context.read<UserModel>().setPhotoCode(value);
            });
          }
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: localizations!.captcha,
            border: OutlineInputBorder(),
            suffixIcon: GestureDetector(
              onTap: _reloadCaptcha,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  width: 56,
                  height: 56,
                  child: _imageFromBase64(_captchaBase64),
                ),
              ),
            )),
      );
    });
  }
}
