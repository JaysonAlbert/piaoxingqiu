import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piaoxingqiu/helpers/validator.dart';
import 'package:piaoxingqiu/models/order.dart';
import 'package:piaoxingqiu/services/user_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AudienceAddScreen extends StatefulWidget {
  const AudienceAddScreen({key});

  @override
  State<AudienceAddScreen> createState() => _AudienceAddScreenState();
}

class _AudienceAddScreenState extends State<AudienceAddScreen> {
  var _isChecked = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _idNo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("新增观演/赛人")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: _name,
                  validator: (value) {
                    if (isValidName(value)) {
                      return null;
                    }
                    return localizations.nameInvalid;
                  },
                  decoration: InputDecoration(
                    labelText: localizations!.nameHint,
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 16),
              TextFormField(
                  controller: _idNo,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (isValidIdNo(value)) {
                      return null;
                    }
                    return localizations.idInvalid;
                  },
                  decoration: InputDecoration(
                    labelText: localizations.idHint,
                    border: OutlineInputBorder(),
                  )),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        print('111 $value');
                        setState(() {
                          _isChecked = value!;
                        });
                      }),
                  Text(
                    "已阅读并同意",
                    style: TextStyle(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 40),
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  if (!_isChecked) {
                    var res = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: Text("已阅读并同意"),
                              actions: [
                                TextButton(
                                  onPressed: () => context.pop("Cancel"),
                                  child: Text("取消"),
                                ),
                                TextButton(
                                    onPressed: () => context.pop("Confirm"),
                                    child: const Text("确定"))
                              ],
                            ));
                    if (res == "Cancel" || !mounted) {
                      return;
                    }
                    setState(() {
                      _isChecked = true;
                    });
                  } else {
                    _addAudience();
                    context.pop();
                  }
                },
                child: Text("保存"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addAudience() {
    UserService().addAudience(AudienceReq(idNo: _idNo.text, name: _name.text));
  }
}
