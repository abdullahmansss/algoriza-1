class CurrentWeatherModel {
  final WeatherLocation location;
  final WeatherCurrent current;

  CurrentWeatherModel({
    required this.location,
    required this.current,
  });

  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      location: WeatherLocation.fromJson(json['location'] as Map<String, dynamic>),
      current: WeatherCurrent.fromJson(json['current'] as Map<String, dynamic>),
    );
  }
}

class WeatherLocation {
  final String name;
  final String country;
  final double lat;
  final double lon;

  WeatherLocation({
    required this.name,
    required this.country,
    required this.lat,
    required this.lon,
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    return WeatherLocation(
      name: json['name'] as String,
      country: json['country'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }
}

class WeatherCurrent {
  final double tempC;
  final double tempF;
  final String condition;

  WeatherCurrent({
    required this.tempC,
    required this.tempF,
    required this.condition,
  });

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
      tempC: json['temp_c'] as double,
      tempF: json['temp_f'] as double,
      condition: json['condition']['text'] as String,
    );
  }
}
