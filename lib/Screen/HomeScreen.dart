import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/WeatherProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: weatherProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 2.5,
              ),
              itemCount: weatherProvider.weatherDataList.length,
              itemBuilder: (ctx, index) {
                final weatherData = weatherProvider.weatherDataList[index];
                return Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherData.city,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Temp:',
                                    style: TextStyle(color: Colors.white)),
                                Text(
                                    '${weatherData.temperature.toStringAsFixed(2)}°C',
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            getWeatherIcon(weatherData.description),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Description: ${weatherData.description}',
                            style: TextStyle(color: Colors.white)),
                        Text('Humidity: ${weatherData.humidity}%',
                            style: TextStyle(color: Colors.white)),
                        Text('Low: ${weatherData.low.toStringAsFixed(2)}°C',
                            style: TextStyle(color: Colors.white)),
                        Text('High: ${weatherData.high.toStringAsFixed(2)}°C',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget getWeatherIcon(String description) {
    if (description.contains('clear')) {
      return Icon(Icons.wb_sunny, color: Colors.orange);
    } else if (description.contains('clouds')) {
      return Icon(Icons.wb_cloudy, color: Colors.grey);
    } else if (description.contains('rain')) {
      return Icon(Icons.grain, color: Colors.blue);
    } else if (description.contains('snow')) {
      return Icon(Icons.ac_unit, color: Colors.lightBlue);
    } else if (description.contains('thunderstorm')) {
      return Icon(Icons.flash_on, color: Colors.yellow);
    } else {
      return Icon(Icons.help_outline, color: Colors.grey);
    }
  }
}
