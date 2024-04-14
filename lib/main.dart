import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
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
    return Scaffold(
        appBar: AppBar(title: Center(child: Text(localizations!.appTitle))),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      labelText: localizations.username,
                      border: OutlineInputBorder(),
                    )),
                const SizedBox(height: 20),
                TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: localizations.password,
                      border: OutlineInputBorder(),
                    )),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: _login, child: Text('login')),
              ],
            )));
  }
}
