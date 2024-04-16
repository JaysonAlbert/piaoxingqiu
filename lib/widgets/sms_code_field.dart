import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:piaoxingqiu/models/user.dart';

class SmsCodeField extends StatefulWidget {
  @override
  _SmsCodeFieldState createState() => _SmsCodeFieldState();
}

class _SmsCodeFieldState extends State<SmsCodeField> {
  late TextEditingController _smsCode;
  Timer? _timer;
  int _start = 60;
  bool _hasClicked = false;

  @override
  void initState() {
    super.initState();
    _smsCode = TextEditingController();
  }

  void _sendVerifySms() {
    print('sending sms');
    context.read<UserModel>().sendVerifySms();
    setState(() {
      _hasClicked = true;
      _start = 60;
    });
    // Place actual SMS sending logic here
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _hasClicked = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _smsCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return TextFormField(
      controller: _smsCode,
      obscureText: true,
      decoration: InputDecoration(
        labelText:
            localizations!.passwordHint, // Replace with your localization
        border: OutlineInputBorder(),
        suffixIcon: _hasClicked
            ? Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 20),
                // height: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('$_start',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    Text(' s')
                  ],
                ))
            : TextButton(
                onPressed: _sendVerifySms,
                child: Text(
                    localizations.sendSms), // Replace with your localization
              ),
      ),
    );
  }
}
