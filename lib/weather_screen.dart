import 'dart:convert';
import 'dart:ui';
import 'package:weather_api/additinl_info.dart';
import 'package:http/http.dart' as http;
import 'card_widget.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future getCurrentWeather() async {
    try {
      final result = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=Delhi&APPID=5565ed5da3441dd72edd49b5aa70cae3'),
      );
      final data = jsonDecode(result.body);
      if (data['cod'] != '200') {
        throw 'An expected error occured';
      }
      return data;
      //data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Weather Screen'),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {          
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: RefreshProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text(
                snapshot.error.toString(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      '295 K',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.cloud,
                                    size: 64,
                                  ),
                                ),
                                const Text(
                                  'Rain',
                                  style: TextStyle(
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
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 110,
                          child: CardWidget(
                            label: '09:00',
                            icon: Icons.cloud,
                            value: '301.17',
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: 110,
                              child: CardWidget(
                                label: '12:00',
                                icon: Icons.cloud,
                                value: '301.54',
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                                width: 110,
                                child: CardWidget(
                                  label: '15:00',
                                  icon: Icons.cloud,
                                  value: '301.11',
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            SizedBox(
                              width: 110,
                              child: CardWidget(
                                label: '18:00',
                                icon: Icons.cloud,
                                value: '300.79',
                              ),
                            ),
                          ],
                        ),
                      ],
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AdditionalInfo(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '94',
                      ),
                      AdditionalInfo(
                        icon: Icons.air,
                        label: 'Wind Speed',
                        value: '7.67',
                      ),
                      AdditionalInfo(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '1006',
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
