import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piaoxingqiu/widgets/captcha_widget.dart';
import 'package:provider/provider.dart';

import '../helpers/validator.dart';
import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _login() {
    final username = _phone.text;
    final password = _password.text;
    print('username: $username, password: $password');
  }

  void refreshCaptcha() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: [
      Center(
        child: Column(
          children: [
            Image.network(
              'https://cdn.ticketmars.com/image/prod/20220617_27/16554485546192345.png',
              height: screenHeight / 6,
            ),
            Text(localizations!.appTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
          ],
        ),
      ),
      Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    controller: _phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (isValidPhoneNumber(value)) {
                        Future.microtask(() {
                          if (value != context.read<UserModel>().phone) {
                            context.read<UserModel>().setPhone(value!);
                          }
                        });
                        return null;
                      }
                      print('phone invalid');
                      return localizations.phoneInvalid;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: localizations.usernameHint,
                      border: OutlineInputBorder(),
                    )),
                SizedBox(height: 16),
                CaptchaWidget(),
                SizedBox(height: 16),
                TextFormField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: localizations.passwordHint,
                      border: OutlineInputBorder(),
                      suffixIcon: TextButton(
                        onPressed: () {
                          print('send sms');
                        },
                        style: TextButton.styleFrom(
                          iconColor: Theme.of(context).primaryColor,
                        ),
                        child: Text(localizations.sendSms),
                      ),
                    )),
                SizedBox(height: 16),
                Center(
                    child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(50)),
                            child: Text(
                              localizations.login,
                            )))
                  ],
                )),
              ],
            ),
          ))
    ]));
  }
}
