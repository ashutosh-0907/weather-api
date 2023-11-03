import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      child: const Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                '09:00',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.cloud,
              size: 40,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '301.17',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
