import 'dart:convert';
import 'package:flutter/material.dart';

class OrderConfig extends ChangeNotifier {
  String showId = "";
  String sessionId = "";
  String seatPlanId = "";
  int price = 0;
  int qty = 1;

  OrderConfig({required this.showId});

  void addQty() {
    qty++;
    notifyListeners();
  }

  void minusQty() {
    qty--;
    notifyListeners();
  }

  void setShowId(String showId) {
    this.showId = showId;
    notifyListeners();
  }

  void setSessionId(String sessionId) {
    this.sessionId = sessionId;
    notifyListeners();
  }

  void setSeatPlanId(String seatPlanId) {
    this.seatPlanId = seatPlanId;
    notifyListeners();
  }

  void setPrice(int price) {
    this.price = price;
    notifyListeners();
  }

  factory OrderConfig.fromJson(Map<String, dynamic> json) {
    OrderConfig orderConfig = OrderConfig(showId: json['showId']);
    orderConfig.sessionId = json['sessionId'];
    orderConfig.seatPlanId = json['seatPlanId'];
    orderConfig.price = json['price'];
    orderConfig.qty = json['qty'];
    return orderConfig;
  }

  Map<String, dynamic> toJson() {
    return {
      'showId': showId,
      'sessionId': sessionId,
      'seatPlanId': seatPlanId,
      'price': price,
      'qty': qty,
    };
  }
}

class PreOrderResult {
  List<SupportDiscount> supportDiscounts;
  List<SupportDelivery> supportDeliveries;
  List<Show> shows;
  List<IdentityVO> identityVO;
  String pageType;
  List<PriceItem> priceItems;
  String ticketPickingInfo;
  List<Audience> audiences;

  PreOrderResult({
    required this.supportDiscounts,
    required this.supportDeliveries,
    required this.shows,
    required this.identityVO,
    required this.pageType,
    required this.priceItems,
    required this.ticketPickingInfo,
    required this.audiences,
  });

  factory PreOrderResult.fromJson(Map<String, dynamic> json) => PreOrderResult(
        supportDiscounts: List<SupportDiscount>.from(
            json["supportDiscounts"].map((x) => SupportDiscount.fromJson(x))),
        supportDeliveries: List<SupportDelivery>.from(
            json["supportDeliveries"].map((x) => SupportDelivery.fromJson(x))),
        shows: List<Show>.from(json["shows"].map((x) => Show.fromJson(x))),
        identityVO: List<IdentityVO>.from(
            json["identityVO"].map((x) => IdentityVO.fromJson(x))),
        pageType: json["pageType"],
        priceItems: List<PriceItem>.from(
            json["priceItems"].map((x) => PriceItem.fromJson(x))),
        ticketPickingInfo: json["ticketPickingInfo"],
        audiences: List<Audience>.from(
            json["audiences"].map((x) => Audience.fromJson(x))),
      );
}

class PriceItem {
  String priceItemType;
  String priceItemName;
  double priceItemVal;
  String direction;
  String? tagColor;
  String? tag;
  String priceItemSpecies;

  PriceItem({
    required this.priceItemType,
    required this.priceItemName,
    required this.priceItemVal,
    required this.direction,
    required this.tagColor,
    required this.tag,
    required this.priceItemSpecies,
  });

  factory PriceItem.fromJson(Map<String, dynamic> json) {
    return PriceItem(
      priceItemType: json['priceItemType'],
      priceItemName: json['priceItemName'],
      priceItemVal: json['priceItemVal'].toDouble(),
      direction: json['direction'],
      tagColor: json['tagColor'],
      tag: json['tag'],
      priceItemSpecies: json['priceItemSpecies'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'priceItemType': priceItemType,
      'priceItemName': priceItemName,
      'priceItemVal': priceItemVal,
      'direction': direction,
      'tagColor': tagColor,
      'tag': tag,
      'priceItemSpecies': priceItemSpecies,
    };
  }
}

class SupportDiscount {
  String discountType;
  String discountName;
  bool isSupport;

  SupportDiscount({
    required this.discountType,
    required this.discountName,
    required this.isSupport,
  });

  factory SupportDiscount.fromJson(Map<String, dynamic> json) =>
      SupportDiscount(
        discountType: json["discountType"],
        discountName: json["discountName"],
        isSupport: json["isSupport"],
      );
}

class SupportDelivery {
  int code;
  String name;
  String displayName;
  String desc;
  String enterTypeDesc;
  String subTitle4C;

  SupportDelivery({
    required this.code,
    required this.name,
    required this.displayName,
    required this.desc,
    required this.enterTypeDesc,
    required this.subTitle4C,
  });

  factory SupportDelivery.fromJson(Map<String, dynamic> json) =>
      SupportDelivery(
        code: json["code"],
        name: json["name"],
        displayName: json["displayName"],
        desc: json["desc"],
        enterTypeDesc: json["enterTypeDesc"],
        subTitle4C: json["subTitle4C"],
      );
}

class Show {
  String showId;
  String showName;
  String? showType;
  String? poster;
  bool? preSale;
  String? preSaleShowDesc;
  List<ShowNote>? showNotes;
  String cityName;
  String showTimeDesc;
  List<Session>? showSessions;
  List<SupportDiscount>? supportDiscounts;
  Venue venue;

  Show({
    required this.showId,
    required this.showName,
    required this.showType,
    required this.poster,
    required this.preSale,
    required this.preSaleShowDesc,
    required this.showNotes,
    required this.cityName,
    required this.showTimeDesc,
    required this.showSessions,
    required this.supportDiscounts,
    required this.venue,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        showId: json["showId"],
        showName: json["showName"],
        showType: json["showType"],
        poster: json["poster"],
        preSale: json["preSale"],
        preSaleShowDesc: json["preSaleShowDesc"],
        showNotes: json["showNotes"] == null
            ? null
            : List<ShowNote>.from(
                json["showNotes"].map((x) => ShowNote.fromJson(x))),
        cityName: json['cityName'],
        showTimeDesc: json['showTimeDesc'],
        showSessions: json['showSessions'] == null
            ? null
            : List<Session>.from(
                json['showSessions'].map((x) => Session.fromJson(x))),
        supportDiscounts: json['supportDiscounts'] == null
            ? null
            : List<SupportDiscount>.from(json['supportDiscounts']
                .map((x) => SupportDiscount.fromJson(x))),
        venue: Venue.fromJson(json['venue']),
      );
}

class ShowNote {
  String name;
  String value;
  bool type;
  String code;
  RefundCfg? refundCfg;

  ShowNote({
    required this.name,
    required this.value,
    required this.type,
    required this.code,
    required this.refundCfg,
  });

  factory ShowNote.fromJson(Map<String, dynamic> json) => ShowNote(
        name: json['name'],
        value: json['value'],
        type: json['type'],
        code: json['code'],
        refundCfg: json['refundCfg'] == null
            ? null
            : RefundCfg.fromJson(json['refundCfg']),
      );
}

class Venue {
  final String venueId;
  final String venueName;
  final String venueAddress;

  Venue({
    required this.venueId,
    required this.venueName,
    required this.venueAddress,
  });

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      venueId: json['venueId'],
      venueName: json['venueName'],
      venueAddress: json['venueAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'venueId': venueId,
      'venueName': venueName,
      'venueAddress': venueAddress,
    };
  }
}

class RefundCfg {
  String showName;
  String type;
  List<RateItem>? rateItems;
  int refundTimes;

  RefundCfg({
    required this.showName,
    required this.type,
    required this.rateItems,
    required this.refundTimes,
  });

  factory RefundCfg.fromJson(Map<String, dynamic> json) => RefundCfg(
        showName: json['showName'],
        type: json['type'],
        rateItems: json['rateItems'] == null
            ? null
            : List<RateItem>.from(
                json['rateItems'].map((x) => RateItem.fromJson(x))),
        refundTimes: json['refundTimes'],
      );
}

class RateItem {
  double rate;
  List<SessionItem>? sessionItems;

  RateItem({
    required this.rate,
    required this.sessionItems,
  });

  factory RateItem.fromJson(Map<String, dynamic> json) => RateItem(
        rate: json['rate'],
        sessionItems: json['sessionItems'] == null
            ? null
            : List<SessionItem>.from(
                json['sessionItems'].map((x) => SessionItem.fromJson(x))),
      );
}

class SessionItem {
  int sessionBeginTime;
  String sessionName;
  List<TimeRange>? timeRange;

  SessionItem({
    required this.sessionBeginTime,
    required this.sessionName,
    required this.timeRange,
  });

  factory SessionItem.fromJson(Map<String, dynamic> json) => SessionItem(
        sessionBeginTime: json['sessionBeginTime'],
        sessionName: json['sessionName'],
        timeRange: json['timeRange'] == null
            ? null
            : List<TimeRange>.from(
                json['timeRange'].map((x) => TimeRange.fromJson(x))),
      );
}

class TimeRange {
  String left;
  String right;

  TimeRange({
    required this.left,
    required this.right,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) => TimeRange(
        left: json['left'],
        right: json['right'],
      );
}

class AudienceReq {
  String bizCode = "FHL_M";
  String idNo;
  String idType = "ID_CARD";
  String name;
  String src = "WEB";
  String ver = "4.4.2";

  AudienceReq({
    required this.idNo,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'bizCode': bizCode,
      'idNo': idNo,
      'idType': idType,
      'name': name,
      'src': src,
      'ver': ver,
    };
  }
}

class Audience {
  String id;
  String idNo;
  String idType;
  String description;
  String name;
  int age;
  String contactWay;

  Audience({
    required this.id,
    required this.idNo,
    required this.idType,
    required this.description,
    required this.name,
    required this.age,
    required this.contactWay,
  });

  factory Audience.fromJson(Map<String, dynamic> json) {
    return Audience(
      id: json['id'],
      idNo: json['idNo'],
      idType: json['idType'],
      description: json['description'],
      name: json['name'],
      age: json['age'],
      contactWay: json['contactWay'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idNo': idNo,
      'idType': idType,
      'description': description,
      'name': name,
      'age': age,
      'contactWay': contactWay,
    };
  }
}

class IdentityVO {
  List<IdentityShow>? shows;
  String identityRequiredType;

  IdentityVO({
    required this.shows,
    required this.identityRequiredType,
  });

  factory IdentityVO.fromJson(Map<String, dynamic> json) => IdentityVO(
        shows: json['shows'] == null
            ? null
            : List<IdentityShow>.from(
                json['shows'].map((x) => IdentityShow.fromJson(x))),
        identityRequiredType: json['identityRequiredType'],
      );
}

class IdentityShow {
  String showId;
  String showName;
  List<Session>? sessions;
  int minAge;
  int maxAge;

  IdentityShow({
    required this.showId,
    required this.showName,
    required this.sessions,
    required this.minAge,
    required this.maxAge,
  });

  factory IdentityShow.fromJson(Map<String, dynamic> json) => IdentityShow(
        showId: json['showId'],
        showName: json['showName'],
        sessions: json['sessions'] == null
            ? null
            : List<Session>.from(
                json['sessions'].map((x) => Session.fromJson(x))),
        minAge: json['minAge'],
        maxAge: json['maxAge'],
      );
}

class Session {
  String sessionId;
  String sessionName;
  String? identityRequiredType;
  List<String>? identityTypeList;
  int? audienceNum;
  List<SeatPlanAgeLimit>? seatPlanAgeLimits;

  Session({
    required this.sessionId,
    required this.sessionName,
    required this.identityRequiredType,
    required this.identityTypeList,
    required this.audienceNum,
    required this.seatPlanAgeLimits,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        sessionId: json['sessionId'],
        sessionName: json['sessionName'],
        identityRequiredType: json['identityRequiredType'],
        identityTypeList: json['identityTypeList'] == null
            ? null
            : List<String>.from(json['identityTypeList']),
        audienceNum: json['audienceNum'],
        seatPlanAgeLimits: json['seatPlanAgeLimits'] == null
            ? null
            : List<SeatPlanAgeLimit>.from(json['seatPlanAgeLimits']
                .map((x) => SeatPlanAgeLimit.fromJson(x))),
      );
}

class SeatPlanAgeLimit {
  String seatPlanId;
  String stdSeatPlanId;
  String seatPlanName;
  int minAge;
  int maxAge;
  int minIdentityLimits;

  SeatPlanAgeLimit({
    required this.seatPlanId,
    required this.stdSeatPlanId,
    required this.seatPlanName,
    required this.minAge,
    required this.maxAge,
    required this.minIdentityLimits,
  });

  factory SeatPlanAgeLimit.fromJson(Map<String, dynamic> json) =>
      SeatPlanAgeLimit(
        seatPlanId: json['seatPlanId'],
        stdSeatPlanId: json['stdSeatPlanId'],
        seatPlanName: json['seatPlanName'],
        minAge: json['minAge'],
        maxAge: json['maxAge'],
        minIdentityLimits: json['minIdentityLimits'],
      );
}
