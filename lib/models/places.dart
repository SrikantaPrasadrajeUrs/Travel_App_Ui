import 'package:cloud_firestore/cloud_firestore.dart';

/// Root model for a travel destination entry (e.g. Mount Fuji)
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
  final Metadata metadata;

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

  /// Factory to create from JSON (for asset import)
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      region: json['region'] ?? '',
      category: json['category'] ?? '',
      type: List<String>.from(json['type'] ?? []),
      description: Description.fromJson(json['description'] ?? {}),
      travelInfo: TravelInfo.fromJson(json['travel_info'] ?? {}),
      weather: Weather.fromJson(json['weather'] ?? {}),
      pricing: Pricing.fromJson(json['pricing'] ?? {}),
      rating: Rating.fromJson(json['rating'] ?? {}),
      images: List<String>.from(json['images'] ?? []),
      metadata: Metadata.fromJson(json['metadata'] ?? {}),
    );
  }

  /// Converts model to JSON (for Firestore write)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'region': region,
      'category': category,
      'type': type,
      'description': description.toJson(),
      'travel_info': travelInfo.toJson(),
      'weather': weather.toJson(),
      'pricing': pricing.toJson(),
      'rating': rating.toJson(),
      'images': images,
      'metadata': metadata.toJson(),
    };
  }

  /// Firestore converter helper
  factory Place.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Place.fromJson(data);
  }
}

/// Nested model for description
class Description {
  final String summary;
  final List<DescriptionDetail> details;

  const Description({required this.summary, required this.details});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      summary: json['summary'] ?? '',
      details: (json['details'] as List?)
          ?.map((d) => DescriptionDetail.fromJson(d))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'details': details.map((d) => d.toJson()).toList(),
    };
  }
}

class DescriptionDetail {
  final String text;
  final String source;

  const DescriptionDetail({required this.text, required this.source});

  factory DescriptionDetail.fromJson(Map<String, dynamic> json) {
    return DescriptionDetail(
      text: json['text'] ?? '',
      source: json['source'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'source': source};
  }
}

/// Travel information
class TravelInfo {
  final String fromCity;
  final double distanceKm;
  final double approxTimeHours;
  final List<String> transportModes;
  final ReferenceInfo reference;

  const TravelInfo({
    required this.fromCity,
    required this.distanceKm,
    required this.approxTimeHours,
    required this.transportModes,
    required this.reference,
  });

  factory TravelInfo.fromJson(Map<String, dynamic> json) {
    return TravelInfo(
      fromCity: json['from_city'] ?? '',
      distanceKm: (json['distance_km'] ?? 0).toDouble(),
      approxTimeHours: (json['approx_time_hours'] ?? 0).toDouble(),
      transportModes: List<String>.from(json['transport_modes'] ?? []),
      reference: ReferenceInfo.fromJson(json['reference'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from_city': fromCity,
      'distance_km': distanceKm,
      'approx_time_hours': approxTimeHours,
      'transport_modes': transportModes,
      'reference': reference.toJson(),
    };
  }
}

class ReferenceInfo {
  final String source;
  final String url;

  const ReferenceInfo({required this.source, required this.url});

  factory ReferenceInfo.fromJson(Map<String, dynamic> json) {
    return ReferenceInfo(
      source: json['source'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'source': source, 'url': url};
}

/// Weather details
class Weather {
  final List<String> bestMonths;
  final TemperatureRange averageTempCelsius;
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
      bestMonths: List<String>.from(json['best_months'] ?? []),
      averageTempCelsius:
      TemperatureRange.fromJson(json['average_temp_celsius'] ?? {}),
      notes: json['notes'] ?? '',
      source: json['source'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'best_months': bestMonths,
      'average_temp_celsius': averageTempCelsius.toJson(),
      'notes': notes,
      'source': source,
    };
  }
}

class TemperatureRange {
  final double min;
  final double max;

  const TemperatureRange({required this.min, required this.max});

  factory TemperatureRange.fromJson(Map<String, dynamic> json) {
    return TemperatureRange(
      min: (json['min'] ?? 0).toDouble(),
      max: (json['max'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'min': min, 'max': max};
}

/// Pricing info
class Pricing {
  final String tier;
  final CostEstimate costEstimateUsd;
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
      tier: json['tier'] ?? '',
      costEstimateUsd: CostEstimate.fromJson(json['cost_estimate_usd'] ?? {}),
      includes: List<String>.from(json['includes'] ?? []),
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tier': tier,
      'cost_estimate_usd': costEstimateUsd.toJson(),
      'includes': includes,
      'notes': notes,
    };
  }
}

class CostEstimate {
  final double min;
  final double max;

  const CostEstimate({required this.min, required this.max});

  factory CostEstimate.fromJson(Map<String, dynamic> json) {
    return CostEstimate(
      min: (json['min'] ?? 0).toDouble(),
      max: (json['max'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'min': min, 'max': max};
}

/// Rating info
class Rating {
  final double score;
  final String reviewSummary;

  const Rating({required this.score, required this.reviewSummary});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      score: (json['score'] ?? 0).toDouble(),
      reviewSummary: json['review_summary'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'score': score,
    'review_summary': reviewSummary,
  };
}

/// Metadata for Firestore tracking
class Metadata {
  final bool isFeatured;

  const Metadata({required this.isFeatured});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(isFeatured: json['isFeatured'] ?? false);
  }

  Map<String, dynamic> toJson() => {'isFeatured': isFeatured};
}
