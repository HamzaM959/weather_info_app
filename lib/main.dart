import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  final TextEditingController _cityController = TextEditingController();
  String cityName = '';
  String temperature = 'N/A';
  String weatherCondition = 'N/A';
  List<Map<String, String>> sevenDayForecast = [];

  void _fetchWeather() {
    setState(() {
      cityName = _cityController.text;

      Random random = Random();
      int temp = 15 + random.nextInt(16);

      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];
      String condition = conditions[random.nextInt(3)];

      temperature = '$temp°F';
      weatherCondition = condition;
    });
  }

  void _fetchSevenDayForecast() {
    setState(() {
      Random random = Random();
      List<String> conditions = ['Sunny', 'Cloudy', 'Rainy'];

      sevenDayForecast = List.generate(7, (index) {
        int temp = -30 + random.nextInt(116);
        String condition = conditions[random.nextInt(3)];
        String day = 'Day ${index + 1}';

        return {
          'day': day,
          'temperature': '$temp°F',
          'condition': condition,
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'Enter City Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _fetchWeather,
                child: const Text('Fetch Weather'),
              ),
              const SizedBox(height: 40.0),
              Text(
                'City: $cityName',
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Temperature: $temperature',
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Condition: $weatherCondition',
                style: const TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: _fetchSevenDayForecast,
                child: const Text('Fetch 7-Day Forecast'),
              ),
              const SizedBox(height: 20.0),
              if (sevenDayForecast.isNotEmpty)
                Column(
                  children: [
                    const Text(
                      '7-Day Weather Forecast:',
                      style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    ...sevenDayForecast.map((dayForecast) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text(dayForecast['day']!),
                          subtitle: Text(
                            'Temperature: ${dayForecast['temperature']} \nCondition: ${dayForecast['condition']}',
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
