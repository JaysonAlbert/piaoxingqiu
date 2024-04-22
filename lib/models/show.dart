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

class ShowDetail {
  final BasicInfo basicInfo;
  final AdditionalInfo additionalInfo;

  ShowDetail({required this.basicInfo, required this.additionalInfo});

  factory ShowDetail.fromJson(Map<String, dynamic> json) {
    return ShowDetail(
      basicInfo: BasicInfo.fromJson(json['basicInfo']),
      additionalInfo: AdditionalInfo.fromJson(json['additionalInfo']),
    );
  }
}

class BasicInfo {
  bool hotMode;
  String stdShowId;
  String showName;
  String sourceType;
  String originalSeatPickType;
  String contentUrl;
  String posterUrl;
  String posterColor;
  String venueId;
  String venueName;
  String venueAddress;
  double venueLat;
  double venueLng;
  String cityId;
  String cityName;
  int onSaleShowCount;
  List<dynamic> showTags;
  String authorizationUrl;
  PriceInfo minOriginalPriceInfo;
  PriceInfo maxOriginalPriceInfo;
  String showDate;
  String showDuration;
  String? seatPlanURL;
  bool displayAdvance;
  bool venueDisplayAdvance;
  bool sessionDisplayAdvance;
  bool seatPlanDisplayAdvance;
  ShowType showType;
  String showDetailStatus;
  bool existsPrivilegePurchase;
  bool displayCountdownTime;
  List<dynamic> captchaTypes;

  BasicInfo({
    required this.hotMode,
    required this.stdShowId,
    required this.showName,
    required this.sourceType,
    required this.originalSeatPickType,
    required this.contentUrl,
    required this.posterUrl,
    required this.posterColor,
    required this.venueId,
    required this.venueName,
    required this.venueAddress,
    required this.venueLat,
    required this.venueLng,
    required this.cityId,
    required this.cityName,
    required this.onSaleShowCount,
    required this.showTags,
    this.authorizationUrl = "",
    required this.minOriginalPriceInfo,
    required this.maxOriginalPriceInfo,
    required this.showDate,
    required this.showDuration,
    required this.seatPlanURL,
    required this.displayAdvance,
    required this.venueDisplayAdvance,
    required this.sessionDisplayAdvance,
    required this.seatPlanDisplayAdvance,
    required this.showType,
    required this.showDetailStatus,
    required this.existsPrivilegePurchase,
    required this.displayCountdownTime,
    required this.captchaTypes,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
        hotMode: json['hotMode'],
        stdShowId: json['stdShowId'],
        showName: json['showName'],
        sourceType: json['sourceType'],
        originalSeatPickType: json['originalSeatPickType'],
        contentUrl: json['contentUrl'],
        posterUrl: json['posterUrl'],
        posterColor: json['posterColor'],
        venueId: json['venueId'],
        venueName: json['venueName'],
        venueAddress: json['venueAddress'],
        venueLat: json['venueLat'].toDouble(),
        venueLng: json['venueLng'].toDouble(),
        cityId: json['cityId'],
        cityName: json['cityName'],
        onSaleShowCount: json['onSaleShowCount'],
        showTags: json['showTags'],
        authorizationUrl: json['authorizationUrl'] ?? "",
        minOriginalPriceInfo: PriceInfo.fromJson(json['minOriginalPriceInfo']),
        maxOriginalPriceInfo: PriceInfo.fromJson(json['maxOriginalPriceInfo']),
        showDate: json['showDate'],
        showDuration: json['showDuration'],
        seatPlanURL: json['seatPlanURL'],
        displayAdvance: json['displayAdvance'],
        venueDisplayAdvance: json['venueDisplayAdvance'],
        sessionDisplayAdvance: json['sessionDisplayAdvance'],
        seatPlanDisplayAdvance: json['seatPlanDisplayAdvance'],
        showType: ShowType.fromJson(json['showType']),
        showDetailStatus: json['showDetailStatus'],
        existsPrivilegePurchase: json['existsPrivilegePurchase'],
        displayCountdownTime: json['displayCountdownTime'],
        captchaTypes: json['captchaTypes'],
      );
}

class PriceInfo {
  String yuanNum;
  String centNum;
  String suffix;
  String prefix;

  PriceInfo({
    required this.yuanNum,
    this.centNum = "",
    this.suffix = "",
    this.prefix = "￥",
  });

  factory PriceInfo.fromJson(Map<String, dynamic> json) => PriceInfo(
        yuanNum: json['yuanNum'],
        centNum: json['centNum'] ?? "",
        suffix: json['suffix'] ?? "",
        prefix: json['prefix'],
      );
}

class ShowType {
  String name;

  ShowType({required this.name});

  factory ShowType.fromJson(Map<String, dynamic> json) => ShowType(
        name: json['name'],
      );
}

class AdditionalInfo {
  bool hasCoupon;
  bool hasPromo;
  bool hasUserPromo;
  bool hasPCard;
  bool hasPriority;
  bool hasChannelDiscount;
  bool checkChannelFreeCombo;
  bool channelPickSeatProject;
  bool hasTyingSale;

  AdditionalInfo({
    required this.hasCoupon,
    required this.hasPromo,
    required this.hasUserPromo,
    required this.hasPCard,
    required this.hasPriority,
    required this.hasChannelDiscount,
    required this.checkChannelFreeCombo,
    required this.channelPickSeatProject,
    required this.hasTyingSale,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
        hasCoupon: json['hasCoupon'],
        hasPromo: json['hasPromo'],
        hasUserPromo: json['hasUserPromo'],
        hasPCard: json['hasPCard'],
        hasPriority: json['hasPriority'],
        hasChannelDiscount: json['hasChannelDiscount'],
        checkChannelFreeCombo: json['checkChannelFreeCombo'],
        channelPickSeatProject: json['channelPickSeatProject'],
        hasTyingSale: json['hasTyingSale'],
      );
}
