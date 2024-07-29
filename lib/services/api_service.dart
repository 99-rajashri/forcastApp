import 'dart:convert';
import 'package:flutter_application_1/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = '2091953ce6ab36724ab3ff0c928fb2d0';

  Future<List<String>> fetchCities() async {
    final response = await http.get(Uri.parse(
        'https://a944ede2-133d-45fa-82e1-0fb951492eda.mock.pstmn.io/cities'));
    if (response.statusCode == 200) {
      final List<String> cities =
          List<String>.from(json.decode(response.body)['cities']);
      return cities;
    } else {
      throw Exception('Failed to load cities');
    }
  }

  Future<WeatherData> fetchWeatherData(String city) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$apiKey'));
    if (response.statusCode == 200) {
      final weatherData = WeatherData.fromJson(json.decode(response.body));
      return weatherData;
    } else {
      throw Exception('Failed to load weather data for $city');
    }
  }
}
