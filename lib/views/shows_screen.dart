import 'package:flutter/material.dart';

import 'package:piaoxingqiu/widgets/show_card_widget.dart';
import 'package:piaoxingqiu/widgets/search_bar_widget.dart';
import 'package:piaoxingqiu/services/show_service.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({super.key});

  @override
  _ShowsPageState createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  List<Map<String, dynamic>> showDataList = [];

  void _onSearch(String search) async {
    var shows = await ShowService().getShows(search);
    print('search: $search, num: ${shows.length}');
    setState(() {
      showDataList = shows;
    });
  }

  @override
  void initState() {
    super.initState();
    _onSearch("");
  }

  Widget _buildScrollable(BuildContext context) {
    return CustomScrollView(slivers: [
      SearchBarSliverAppBar(
        onSearch: _onSearch,
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Center(
          child: ShowCardWidget(showData: showDataList[index]),
        );
      }, childCount: showDataList.length))
    ]);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _buildScrollable(context),
    );
  }
}
