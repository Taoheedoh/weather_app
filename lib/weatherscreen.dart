import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/additioninfo.dart';
import 'package:weather_app/secrets.dart';
import 'HourlyWeatherForecast.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  Future getCurrentWeather() async {
    try {
      String cityName = 'London';
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(result.body);

      if (data['cod'] != '200') {
        throw 'An Unexpected Error Occur';
      }
      print(data['list'] [0] ['main'] ['temp']);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '300K',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(
                            Icons.cloud,
                            size: 64,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Rain',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            const Text(
              'Weather Forecast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            // weather forecast card

            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyWeatherForecast(
                    time: '00:00',
                    temperature: '301.22',
                    icon: Icons.cloud,
                  ),
                  HourlyWeatherForecast(
                    time: '03:00',
                    temperature: '300.22',
                    icon: Icons.sunny,
                  ),
                  HourlyWeatherForecast(
                    time: '04:00',
                    temperature: '300.12',
                    icon: Icons.sunny,
                  ),
                  HourlyWeatherForecast(
                    time: '08:00',
                    temperature: '304.22',
                    icon: Icons.cloud,
                  ),
                  HourlyWeatherForecast(
                    time: '12:00',
                    temperature: '301.22',
                    icon: Icons.sunny,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // additional information
            const Text(
              'Additional Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AddInfo(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AddInfo(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.5',
                ),
                AddInfo(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1000',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
