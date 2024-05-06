import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:piaoxingqiu/models/order.dart';
import 'package:piaoxingqiu/services/user_service.dart';
import 'package:piaoxingqiu/helpers/exception_helper.dart';
import 'package:piaoxingqiu/widgets/show_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:piaoxingqiu/helpers/logger.dart';
import 'package:piaoxingqiu/widgets/audience_list_widget.dart';

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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4, 4, 8),
                    child: Card(
                      margin: EdgeInsets.all(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Poster(
                                  posterUrl: _preOrderResult!.shows[0].poster!,
                                ),
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        _preOrderResult!.shows[0].showName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium,
                                      ),
                                      Text(_preOrderResult!.shows[0].cityName +
                                          _preOrderResult!
                                              .shows[0].venue.venueName),
                                    ])
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                _createChip("支持有条件退"),
                                _createChip("支持有条件退"),
                                _createChip("支持有条件退"),
                                _createChip("支持有条件退"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 4, 4, 8),
                    child: AudienceListWdiget(
                      audiences: _preOrderResult!.audiences,
                      maxAudience: widget.orderConfig.qty,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  Widget _createChip(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Chip(
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).disabledColor,
          ),
        ),
        label: Text(text),
      ),
    );
  }
}
