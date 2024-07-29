class WeatherData {
  final String city;
  final double temperature;
  final String description;
  final int humidity;
  final double low;
  final double high;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.low,
    required this.high,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      temperature: json['main']['temp'] - 273.15,
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      low: json['main']['temp_min'] - 273.15,
      high: json['main']['temp_max'] - 273.15,
    );
  }
}
