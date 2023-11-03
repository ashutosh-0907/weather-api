import 'package:flutter/material.dart';


class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(
          Icons.air,
          size: 40,
          ),
        Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text(
            'Wind Speed',
            style: TextStyle(
              fontSize: 20,
            ),
          ),                      
        ),
        Text(
            '7.67',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
      ],
    );
  }
}