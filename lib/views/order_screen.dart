import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:piaoxingqiu/models/order.dart';
import 'package:piaoxingqiu/services/user_service.dart';
import 'package:piaoxingqiu/helpers/exception_helper.dart';
import 'package:piaoxingqiu/widgets/show_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piaoxingqiu/helpers/logger.dart';

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
    } catch (e, stack) {
      if (!mounted) return;
      logError("pre order failed", e, stack);
      Future.microtask(() => handleErrors(context, e));
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
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Poster(
                      posterUrl: _preOrderResult!.shows[0].poster!,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            _preOrderResult!.shows[0].showName,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(_preOrderResult!.shows[0].cityName +
                              _preOrderResult!.shows[0].venue.venueName),
                        ])
                  ],
                ),
              )
            ],
          ));
    }
  }
}
