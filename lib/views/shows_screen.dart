import 'package:flutter/material.dart';
import 'package:piaoxingqiu/models/show.dart';
import 'package:go_router/go_router.dart';

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
  List<ShowData> showDataList = [];
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  bool hasMoreData = true;
  int currentPage = 1;
  int pageSize = 10;
  String currentSearch = "";

  void _onSearch(String search) async {
    if (currentSearch != search) {
      showDataList.clear();
    }
    setState(() {
      isLoading = true;
      currentSearch = search;
    });
    var shows =
        await ShowService().getShows(keyword: search, pageNo: currentPage);
    print('search: $search, num: ${shows.showData.length}');
    setState(() {
      showDataList.addAll(shows.showData);
      hasMoreData = shows.pagination.hasNextPage;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener((_onScroll));
    _onSearch("");
  }

  void _onScroll() {
    if (!isLoading &&
        hasMoreData &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() async {
    setState(() {
      currentPage += 1;
    });
    print('load more items: $currentPage');
    _onSearch(currentSearch);
  }

  Widget _buildScrollable(BuildContext context) {
    return CustomScrollView(controller: _scrollController, slivers: [
      SearchBarSliverAppBar(
        onSearch: _onSearch,
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return InkWell(
          onTap: () {
            print('go to page show id: ${showDataList[index].showId}');
            context.go('/show/${showDataList[index].showId}');
          },
          child: Center(
            child: ShowCardWidget(showData: showDataList[index]),
          ),
        );
      }, childCount: showDataList.length))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    int currentPageIndex = 0;
    var localizations = AppLocalizations.of(context);

    return Scaffold(
      body: _buildScrollable(context),
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
