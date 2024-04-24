import 'package:flutter/material.dart';

import 'package:piaoxingqiu/models/order.dart';
import 'package:piaoxingqiu/services/user_service.dart';
import 'package:piaoxingqiu/helpers/exception_helper.dart';
import 'package:piaoxingqiu/widgets/show_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderScreen extends StatefulWidget {
  final OrderConfig orderConfig;

  const OrderScreen({Key? key, required this.orderConfig}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  PreOrderResult? _preOrderResult;

  @override
  void initState() {
    super.initState();

    _preOrder();
  }

  void _preOrder() async {
    try {
      var result = await UserService().perOrder(widget.orderConfig);
      setState(() {
        _preOrderResult = result;
      });
    } catch (e) {
      if (!mounted) return;
      print(e);
      Future.microtask(() => handleErrors(context, e as Exception));
    }
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    if (_preOrderResult == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(localizations!.orderConfirm)),
        body: Center(
            child: Poster(
          posterUrl: _preOrderResult!.shows[0].poster!,
        )),
      );
    }
  }
}
