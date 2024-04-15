import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _login() {
    final username = _username.text;
    final password = _password.text;
    print('username: $username, password: $password');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                  controller: _username,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: localizations.username,
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 16),
              TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: localizations.password,
                    border: OutlineInputBorder(),
                    suffixIcon: TextButton(
                      onPressed: () {},
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
          ))
    ]));
  }
}
