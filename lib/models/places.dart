class Place {
  final String id;
  final String name;
  final String country;
  final String region;
  final String category;
  final List<String> type;
  final Description description;
  final TravelInfo travelInfo;
  final Weather weather;
  final Pricing pricing;
  final Rating rating;
  final List<String> images;
  final MetaData metadata;

  const Place({
    required this.id,
    required this.name,
    required this.country,
    required this.region,
    required this.category,
    required this.type,
    required this.description,
    required this.travelInfo,
    required this.weather,
    required this.pricing,
    required this.rating,
    required this.images,
    required this.metadata,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      region: json['region'],
      category: json['category'],
      type: List<String>.from(json['type']),
      description: Description.fromJson(json['description']),
      travelInfo: TravelInfo.fromJson(json['travel_info']),
      weather: Weather.fromJson(json['weather']),
      pricing: Pricing.fromJson(json['pricing']),
      rating: Rating.fromJson(json['rating']),
      images: List<String>.from(json['images']),
      metadata: MetaData.fromJson(json['metadata']),
    );
  }
}

class Description {
  final String summary;
  final List<Detail> details;
  const Description({required this.summary, required this.details});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(summary: json['summary'], details: List<Detail>.from(json['details'].map((detail) => Detail.fromJson(detail))));
  }
}

class Detail {
  final String text;
  final String source;
  const Detail({required this.text, required this.source});


  factory Detail.fromJson(Map<String,dynamic> json){
    return Detail(text: json['text'], source: json['source']);
  }
}

class TravelInfo {
  final String fromCity;
  final double distanceKm;
  final double approxTimeHours;
  final List<String> transportModes;
  final Reference reference;
  const TravelInfo({
    required this.fromCity,
    required this.distanceKm,
    required this.approxTimeHours,
    required this.transportModes,
    required this.reference,
  });

  factory TravelInfo.fromJson(Map<String,dynamic> json){
    return TravelInfo(
        fromCity: json['from_city'],
        distanceKm: (json['distance_km'] as num).toDouble(),
        approxTimeHours: (json['approx_time_hours'] as num).toDouble(),
        transportModes: List<String>.from(json['transport_modes']),
        reference: Reference.fromJson(json['reference']));
  }
}

class Reference {
  final String source;
  final String url;
  const Reference({required this.source, required this.url});

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      source: json['source'],
      url: json['url'],
    );
  }
}

class Weather {
  final List<String> bestMonths;
  final TempRange averageTempCelsius;
  final String notes;
  final String source;

  const Weather({
    required this.bestMonths,
    required this.averageTempCelsius,
    required this.notes,
    required this.source,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      bestMonths: List<String>.from(json['best_months']),
      averageTempCelsius: TempRange.fromJson(json['average_temp_celsius']),
      notes: json['notes'],
      source: json['source'],
    );
  }
}

class TempRange {
  final double min;
  final double max;
  const TempRange({required this.max, required this.min});

  factory TempRange.fromJson(Map<String, dynamic> json) {
    return TempRange(min: (json['min'] as num).toDouble(), max: (json['max'] as num).toDouble());
  }
}

class Pricing {
  final String tier;
  final Range costEstimateUsd;
  final List<String> includes;
  final String notes;

  const Pricing({
    required this.tier,
    required this.costEstimateUsd,
    required this.includes,
    required this.notes,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      tier: json['tier'],
      costEstimateUsd: Range.fromJson(json['cost_estimate_usd']),
      includes: List<String>.from(json['includes']),
      notes: json['notes'],
    );
  }
}

class Range {
  final double min;
  final double max;
  const Range({required this.min, required this.max});

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(min: (json['min'] as num).toDouble(), max: (json['max'] as num).toDouble());
  }
}

class Rating {
  final double score;
  final String reviewSummary;
  const Rating({required this.score, required this.reviewSummary});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(score: json['score'], reviewSummary: json['review_summary']);
  }
}

class MetaData {
  final bool isFeatured;
  const MetaData({required this.isFeatured});

  factory MetaData.fromJson(Map<String, dynamic> json){
    return MetaData(isFeatured: json['isFeatured']);
  }
}