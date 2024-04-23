import 'package:flutter/material.dart';

import 'package:piaoxingqiu/widgets/show_card_widget.dart';
import 'package:piaoxingqiu/widgets/search_bar_widget.dart';
import 'package:piaoxingqiu/services/show_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    int currentPageIndex = 0;

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.7;
    var localizations = AppLocalizations.of(context);

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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: localizations!.home,
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.person),
            ),
            label: localizations.my,
          ),
        ],
      ),
    );
  }
}
