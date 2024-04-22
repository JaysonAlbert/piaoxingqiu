class ShowSession {
  int showLimit;
  String showId;
  String stdShowId;
  String showName;
  bool supportSeatPicking;
  String bizShowSessionId;
  String stdShowSessionId;
  String sessionName;
  bool isPermanent;
  bool hasCombo;
  bool hasActivity;
  int beginDateTime;
  int endDateTime;
  int limitation;
  bool displayCountdownTime;
  List<String> saleTags;
  bool ctSession;
  List<String> promoTags;
  List<String> whiteTags;
  String sessionStatus;
  bool hasSessionSoldOut;
  List<String>? captchaTypes;
  List<SeatPlan> seatPlans;

  ShowSession({
    required this.showLimit,
    required this.showId,
    required this.stdShowId,
    required this.showName,
    required this.supportSeatPicking,
    required this.bizShowSessionId,
    required this.stdShowSessionId,
    required this.sessionName,
    required this.isPermanent,
    required this.hasCombo,
    required this.hasActivity,
    required this.beginDateTime,
    required this.endDateTime,
    required this.limitation,
    required this.displayCountdownTime,
    required this.saleTags,
    required this.ctSession,
    required this.promoTags,
    required this.whiteTags,
    required this.sessionStatus,
    required this.hasSessionSoldOut,
    required this.captchaTypes,
    required this.seatPlans,
  });

  factory ShowSession.fromJson(Map<String, dynamic> json) {
    return ShowSession(
      showLimit: json['showLimit'],
      showId: json['showId'],
      stdShowId: json['stdShowId'],
      showName: json['showName'],
      supportSeatPicking: json['supportSeatPicking'],
      bizShowSessionId: json['bizShowSessionId'],
      stdShowSessionId: json['stdShowSessionId'],
      sessionName: json['sessionName'],
      isPermanent: json['isPermanent'],
      hasCombo: json['hasCombo'],
      hasActivity: json['hasActivity'],
      beginDateTime: json['beginDateTime'],
      endDateTime: json['endDateTime'],
      limitation: json['limitation'],
      displayCountdownTime: json['displayCountdownTime'],
      saleTags: List<String>.from(json['saleTags']),
      ctSession: json['ctSession'],
      promoTags: List<String>.from(json['promoTags']),
      whiteTags: List<String>.from(json['whiteTags']),
      sessionStatus: json['sessionStatus'],
      hasSessionSoldOut: json['hasSessionSoldOut'],
      captchaTypes: json['captchaTypes'] == null
          ? null
          : List<String>.from(json['captchaTypes']),
      seatPlans: List<SeatPlan>.from(
          json['seatPlans'].map((x) => SeatPlan.fromJson(x))),
    );
  }
}

class SeatPlan {
  String seatPlanId;
  String stdSeatPlanId;
  String colorValue;
  double originalPrice;
  String seatPlanName;
  int displayOrder;
  int limitation;
  bool hasActivity;
  String seatPlanCategory;
  bool isCombo;
  List<String> saleTags;
  List<String> promoTags;
  String whiteRuleId;
  List<String> whiteTags;
  List<dynamic> items; // Adjust type based on actual item structure

  SeatPlan({
    required this.seatPlanId,
    required this.stdSeatPlanId,
    required this.colorValue,
    required this.originalPrice,
    required this.seatPlanName,
    required this.displayOrder,
    required this.limitation,
    required this.hasActivity,
    required this.seatPlanCategory,
    required this.isCombo,
    required this.saleTags,
    required this.promoTags,
    required this.whiteRuleId,
    required this.whiteTags,
    required this.items,
  });

  factory SeatPlan.fromJson(Map<String, dynamic> json) {
    return SeatPlan(
      seatPlanId: json['seatPlanId'],
      stdSeatPlanId: json['stdSeatPlanId'],
      colorValue: json['colorValue'],
      originalPrice: json['originalPrice'],
      seatPlanName: json['seatPlanName'],
      displayOrder: json['displayOrder'],
      limitation: json['limitation'],
      hasActivity: json['hasActivity'],
      seatPlanCategory: json['seatPlanCategory'],
      isCombo: json['isCombo'],
      saleTags: List<String>.from(json['saleTags']),
      promoTags: List<String>.from(json['promoTags']),
      whiteRuleId: json['whiteRuleId'],
      whiteTags: List<String>.from(json['whiteTags']),
      items: List<dynamic>.from(json['items']),
    );
  }
}
