import 'package:piaoxingqiu/models/pagination.dart';

class ShowData {
  String searchType;
  String showId;
  String stdShowId;
  String showName;
  String showDate;
  String cityName;
  String cityId;
  String showStatus;
  double minOriginalPrice;
  String posterUrl;
  String venueId;
  String venueName;
  BackendCategory backendCategory;
  bool isFree;
  int firstShowTime;
  int lastShowTime;
  MinOriginalPriceInfo minOriginalPriceInfo;
  int latestShowTime;
  List<String> showSessionDates;
  bool soldOut;
  int sessionNum;
  int seatPlanNum;

  ShowData({
    required this.searchType,
    required this.showId,
    required this.stdShowId,
    required this.showName,
    required this.showDate,
    required this.cityName,
    required this.cityId,
    required this.showStatus,
    required this.minOriginalPrice,
    required this.posterUrl,
    required this.venueId,
    required this.venueName,
    required this.backendCategory,
    required this.isFree,
    required this.firstShowTime,
    required this.lastShowTime,
    required this.minOriginalPriceInfo,
    required this.latestShowTime,
    required this.showSessionDates,
    required this.soldOut,
    required this.sessionNum,
    required this.seatPlanNum,
  });

  factory ShowData.fromJson(Map<String, dynamic> json) {
    return ShowData(
      searchType: json['searchType'] as String,
      showId: json['showId'] as String,
      stdShowId: json['stdShowId'] as String,
      showName: json['showName'] as String,
      showDate: json['showDate'] as String,
      cityName: json['cityName'] as String,
      cityId: json['cityId'] as String,
      showStatus: json['showStatus'] as String,
      minOriginalPrice: (json['minOriginalPrice'] as num).toDouble(),
      posterUrl: json['posterUrl'] as String,
      venueId: json['venueId'] as String,
      venueName: json['venueName'] as String,
      backendCategory: BackendCategory.fromJson(
          json['backendCategory'] as Map<String, dynamic>),
      isFree: json['isFree'] as bool,
      firstShowTime: json['firstShowTime'] as int,
      lastShowTime: json['lastShowTime'] as int,
      minOriginalPriceInfo: MinOriginalPriceInfo.fromJson(
          json['minOriginalPriceInfo'] as Map<String, dynamic>),
      latestShowTime: json['latestShowTime'] as int,
      showSessionDates: List<String>.from(json['showSessionDates'] as List),
      soldOut: json['soldOut'] as bool,
      sessionNum: json['sessionNum'] as int,
      seatPlanNum: json['seatPlanNum'] as int,
    );
  }
}

class BackendCategory {
  int code;
  String displayName;
  String name;

  BackendCategory({
    required this.code,
    required this.displayName,
    required this.name,
  });

  factory BackendCategory.fromJson(Map<String, dynamic> json) {
    return BackendCategory(
      code: json['code'] as int,
      displayName: json['displayName'] as String,
      name: json['name'] as String,
    );
  }
}

class MinOriginalPriceInfo {
  String yuanNum;
  String centNum;
  String suffix;
  String prefix;

  MinOriginalPriceInfo({
    required this.yuanNum,
    required this.centNum,
    required this.suffix,
    required this.prefix,
  });

  factory MinOriginalPriceInfo.fromJson(Map<String, dynamic> json) {
    return MinOriginalPriceInfo(
      yuanNum: json['yuanNum'] as String,
      centNum: json['centNum'] as String,
      suffix: json['suffix'] as String,
      prefix: json['prefix'] as String,
    );
  }
}

class PageShowData {
  final List<ShowData> showData;

  final Pagination pagination;

  PageShowData({required this.showData, required this.pagination});

  factory PageShowData.fromJson(Map<String, dynamic> json) {
    return PageShowData(
      showData: json['searchData']!
          .map<ShowData>((item) => ShowData.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}
