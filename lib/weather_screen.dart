import 'dart:ui';
import 'package:weather_api/additinl_info.dart';

import 'card_widget.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                '300.67° K',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.cloud,
                              size: 64,
                            ),
                          ),
                          Text(
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
                    child: CardWidget(),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 110,
                        child: CardWidget(),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      SizedBox(width: 110, child: CardWidget()),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(width: 110, child: CardWidget()),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Additional Information',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            const Padding(
              padding:  EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.water_drop,
                        size: 40,
                        ),
                      Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Text(
                          'Humidity',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),                      
                      ),
                      Text(
                          '94',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                    ],
                  ),
                   Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: AdditionalInfo()
                  ),
                   Padding(
                    padding:  EdgeInsets.only(right: 10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.beach_access,
                          size: 40,
                          ),
                        Padding(
                          padding:  EdgeInsets.all(10.0),
                          child: Text(
                            'Pressure',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),                      
                        ),
                        Text(
                            '1006',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


