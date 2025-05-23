class FeeResponse {
  final String message;
  final FeeData data;

  FeeResponse({required this.message, required this.data});

  factory FeeResponse.fromJson(Map<String, dynamic> json) {
    return FeeResponse(
      message: json['message'],
      data: FeeData.fromJson(json['data']),
    );
  }
}

class FeeData {
  final PricingType pricingType;
  final String id;
  final StopPricing stopPricing;
  final List<String> acceptedPaymentMethods;
  final int distanceMin;
  final int distanceMax;
  final bool isActive;
  final DateTime lastUpdated;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  FeeData({
    required this.pricingType,
    required this.id,
    required this.stopPricing,
    required this.acceptedPaymentMethods,
    required this.distanceMin,
    required this.distanceMax,
    required this.isActive,
    required this.lastUpdated,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory FeeData.fromJson(Map<String, dynamic> json) {
    return FeeData(
      pricingType: PricingType.fromJson(json['pricingType']),
      id: json['_id'],
      stopPricing: StopPricing.fromJson(json['stopPricing']),
      acceptedPaymentMethods: List<String>.from(json['acceptedPaymentMethods']),
      distanceMin: json['distanceMin'],
      distanceMax: json['distanceMax'],
      isActive: json['isActive'],
      lastUpdated: DateTime.parse(json['lastUpdated']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class PricingType {
  final GlobalPricing global;
  final List<dynamic> customized; // puedes definir otro modelo si conoces su estructura

  PricingType({
    required this.global,
    required this.customized,
  });

  factory PricingType.fromJson(Map<String, dynamic> json) {
    return PricingType(
      global: GlobalPricing.fromJson(json['global']),
      customized: json['customized'] ?? [],
    );
  }
}

class GlobalPricing {
  final int price;
  final bool isActive;

  GlobalPricing({
    required this.price,
    required this.isActive,
  });

  factory GlobalPricing.fromJson(Map<String, dynamic> json) {
    return GlobalPricing(
      price: json['price'],
      isActive: json['isActive'],
    );
  }
}

class StopPricing {
  final int pricePerStop;
  final int maxStopsAllowed;
  final bool isActive;
  final String id;

  StopPricing({
    required this.pricePerStop,
    required this.maxStopsAllowed,
    required this.isActive,
    required this.id,
  });

  factory StopPricing.fromJson(Map<String, dynamic> json) {
    return StopPricing(
      pricePerStop: json['pricePerStop'],
      maxStopsAllowed: json['maxStopsAllowed'],
      isActive: json['isActive'],
      id: json['_id'],
    );
  }
}
