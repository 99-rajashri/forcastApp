import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/models/weather.dart';
import 'package:flutter_application_1/services/api_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  List<WeatherData> _weatherDataList = [];
  bool _isLoading = false;

  WeatherProvider() {
    fetchWeatherData();
  }

  List<WeatherData> get weatherDataList => _weatherDataList;
  bool get isLoading => _isLoading;

  Future<void> fetchWeatherData() async {
    _isLoading = true;
    notifyListeners();
    print("Fetching city data...");

    try {
      final cities = await _weatherService.fetchCities();
      print("Cities fetched: $cities");

      _weatherDataList.clear();

      for (String city in cities) {
        try {
          final weatherData = await _weatherService.fetchWeatherData(city);
          _weatherDataList.add(weatherData);
          print("Weather data for $city: $weatherData");
        } catch (error) {
          print("Failed to fetch weather data for $city: $error");
        }
      }
    } catch (error) {
      print("Failed to fetch city data: $error");
    }

    _isLoading = false;
    notifyListeners();
  }
}
