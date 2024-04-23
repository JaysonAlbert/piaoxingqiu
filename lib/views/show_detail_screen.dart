import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:piaoxingqiu/models/show_session.dart';
import 'package:piaoxingqiu/services/show_service.dart';
import '../models/show.dart';

class ShowDetailPage extends StatefulWidget {
  final String showId;

  ShowDetailPage({required this.showId});

  @override
  State<ShowDetailPage> createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  ShowDetail? _showDetail;
  List<ShowSession>? _showSessionList;
  int _selectedSessionIndex = -1;
  int _selectedSeatPlanIndex = -1;

  void _getShowSession(String showId) async {
    var res = await ShowService().getSession(showId);
    setState(() {
      _showSessionList = res;
    });
  }

  void _getShowData(String showId) async {
    var res = await ShowService().getShow(showId: showId);
    setState(() {
      _showDetail = res;
    });
  }

  @override
  void initState() {
    super.initState();
    _getShowSession(widget.showId);
    _getShowData(widget.showId);
  }

  @override
  Widget build(BuildContext context) {
    if (_showDetail == null || _showSessionList == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(_showDetail!.basicInfo.showName)),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('场次',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                title: Text(_showSessionList![index].sessionName),
                selected: index == _selectedSessionIndex,
                onTap: () {
                  setState(() {
                    _selectedSessionIndex = index;
                    _selectedSeatPlanIndex = -1;
                  });
                },
              );
            }, childCount: _showSessionList!.length)),
            if (_selectedSessionIndex != -1) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('票价',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                    selected: index == _selectedSeatPlanIndex,
                    title: Text(_showSessionList![_selectedSessionIndex]
                        .seatPlans[index]
                        .seatPlanName),
                    onTap: () {
                      setState(() {
                        _selectedSeatPlanIndex = index;
                      });
                    });
              },
                      childCount: _showSessionList![_selectedSessionIndex]
                          .seatPlans
                          .length)),
            ],
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          height: _selectedSessionIndex != -1 && _selectedSeatPlanIndex != -1
              ? 130
              : 56,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_selectedSessionIndex != -1 && _selectedSeatPlanIndex != -1)
                PriceCalculator(
                    seatPlan: _showSessionList![_selectedSessionIndex]
                        .seatPlans[_selectedSeatPlanIndex]),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(400, 40),
                ),
                onPressed: _toOrder,
                child: Text("下一步"),
              )
            ],
          ),
        ),
      );
    }
  }

  void _toOrder() {
    print('to order');
  }
}

class PriceCalculator extends StatefulWidget {
  final SeatPlan seatPlan;

  const PriceCalculator({
    super.key,
    required this.seatPlan,
  });

  @override
  State<PriceCalculator> createState() => _PriceCalculatorState();
}

class _PriceCalculatorState extends State<PriceCalculator> {
  int ticketCount = 1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  '￥${ticketCount * widget.seatPlan.originalPrice}',
                  style: TextStyle(color: Colors.red),
                ),
                Row(
                  children: [
                    Text('明细', style: TextStyle(fontSize: 10)),
                    Icon(Icons.arrow_drop_up, size: 14)
                  ],
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('选择数量'),
                ),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    if (ticketCount > 1) {
                      setState(() {
                        ticketCount--;
                      });
                    }
                  },
                  child: CircleIcon(
                    iconData: Icons.remove,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Text(
                    '$ticketCount',
                  ),
                ),
                InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    if (ticketCount < widget.seatPlan.limitation) {
                      setState(() {
                        ticketCount++;
                      });
                    }
                  },
                  child: CircleIcon(iconData: Icons.add),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  final IconData iconData;
  CircleIcon({
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Ink(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.grey,
        ));
  }
}
