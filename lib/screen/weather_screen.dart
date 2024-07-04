import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_api/widget/additinl_info.dart';
import 'package:weather_api/widget/card_widget.dart';
import 'package:http/http.dart' as http;
import '../secret.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _cityController = TextEditingController();
  String? _cityName;
  Future<Map<String, dynamic>>? _futureWeather;

  Future<Map<String, dynamic>> getCurrentWeather(String cityName) async {
    try {
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$weatherApiKey'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  void _fetchWeather() {
    setState(() {
      _cityName = _cityController.text;
      _futureWeather = getCurrentWeather(_cityName!);
    });
  }

  String _formatDate(String dateTxt) {
    final dateTime = DateTime.parse(dateTxt);
    return DateFormat('MMM d, h:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Weather App')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _fetchWeather,
                ),
              ),
              onFieldSubmitted: (_) => _fetchWeather(),
            ),
            const SizedBox(height: 16),
            _futureWeather == null
                ? const Center(child: Text('Enter a city to get weather info'))
                : FutureBuilder(
                    future: _futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text(
                          snapshot.error.toString(),
                        );
                      }

                      final data = snapshot.data!;
                      final weatherData = data['list'][0];
                      final currentTemp = (weatherData['main']['temp'] - 273.15)
                          .toStringAsFixed(2);
                      final currentSky = weatherData['weather'][0]['main'];
                      final currentPressure = weatherData['main']['pressure'];
                      final currentHumidity = weatherData['main']['humidity'];
                      final currentWindSpeed = weatherData['wind']['speed'];
                      final chanceOfRain = data['list'][0]['pop'] * 100;
                      final fellsTemp = (weatherData['main']['feels_like']-273.15).toStringAsFixed(2);

                      return Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  '$currentTemp° C',
                                                  style: const TextStyle(
                                                    fontSize: 32,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Icon(
                                              currentSky == 'Clouds' ||
                                                      currentSky == 'Rain'
                                                  ? Icons.cloud
                                                  : Icons.wb_sunny,
                                              size: 64,
                                            ),
                                            Text(
                                              '$currentSky',
                                              style: const TextStyle(
                                                fontSize: 32,
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    data['list'].length,
                                    (index) {
                                      final forecast = data['list'][index];
                                      final forecastTime =
                                          _formatDate(forecast['dt_txt']);
                                      final forecastTemp =
                                          (forecast['main']['temp'] - 273.15)
                                              .toStringAsFixed(2);
                                      final forecastIcon = forecast['weather']
                                                      [0]['main'] ==
                                                  'Clouds' ||
                                              forecast['weather'][0]['main'] ==
                                                  'Rain'
                                          ? Icons.cloud
                                          : Icons.wb_sunny;

                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 120,
                                          child: CardWidget(
                                            label: forecastTime,
                                            icon: forecastIcon,
                                            value: forecastTemp,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                'Additional Information',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 125,
                                        child: AdditionalInfo(
                                          icon: Icons.water_drop,
                                          label: 'Humidity',
                                          value: '$currentHumidity',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 125,
                                        child: AdditionalInfo(
                                          icon: Icons.air,
                                          label: 'Wind Speed',
                                          value: currentWindSpeed.toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 125,
                                        child: AdditionalInfo(
                                          icon: Icons.beach_access,
                                          label: 'Pressure',
                                          value: currentPressure.toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: AdditionalInfo(
                                          icon: Icons.water_sharp,
                                          label: 'Chances of Rain ',
                                          value: chanceOfRain.toString(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 125,
                                        child: AdditionalInfo(
                                          icon: Icons.wb_sunny,
                                          label: 'Feels Like ',
                                          value: fellsTemp.toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
