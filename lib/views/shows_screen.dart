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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.7;

    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: containerWidth,
          child: Center(
            child: Column(
              children: [
                SearchBarWidget(onSearch: _onSearch),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      itemCount: showDataList.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child:
                                ShowCardWidget(showData: showDataList[index]));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
