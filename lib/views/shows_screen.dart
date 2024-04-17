import 'package:flutter/material.dart';

import 'package:piaoxingqiu/widgets/show_card_widget.dart';

class ShowsPage extends StatelessWidget {
  const ShowsPage({super.key});

  static const showData = {
    "searchType": "SHOW",
    "showId": "65fbb5419519d70001e27e6e",
    "stdShowId": "65fbb5419519d70001e27e6d",
    "showName": "【北京】凤凰传奇“吉祥如意”巡回演唱会-北京站",
    "showDate": "2024.05.04 - 05.05",
    "cityName": "北京",
    "cityId": "1101",
    "showStatus": "PRESALE",
    "minOriginalPrice": 380,
    "posterUrl":
        "https://cdn.ticketmars.com/image/prod/20240321_66/17109950410221333.png",
    "venueId": "575d0c2f0cf28969e9162f3d",
    "venueName": "国家体育场—鸟巢",
    "backendCategory": {
      "code": 17,
      "displayName": "演唱会",
      "name": "YanChangHui"
    },
    "isFree": false,
    "firstShowTime": 1714820400000,
    "lastShowTime": 1714915800000,
    "minOriginalPriceInfo": {
      "yuanNum": "380",
      "centNum": "",
      "suffix": "起",
      "prefix": "￥"
    },
    "latestShowTime": 1714820400000,
    "showSessionDates": ["20240505", "20240504"],
    "soldOut": false,
    "sessionNum": 2,
    "seatPlanNum": 14
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.7;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: containerWidth,
      child: Center(
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return Center(child: ShowCardWidget(showData: showData));
          },
        ),
      ),
    );
  }
}
