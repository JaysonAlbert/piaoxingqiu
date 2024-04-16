// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:piaoxingqiu/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Show Widget test', (WidgetTester tester) async {
    const data = {
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
  });
}
