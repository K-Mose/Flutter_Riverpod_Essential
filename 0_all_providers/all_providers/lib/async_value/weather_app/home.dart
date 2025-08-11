import 'package:flutter/material.dart';

import 'pages/weather_first/weather_first_page.dart';
import 'pages/weather_second/weather_second_page.dart';
import 'widgets/custom_button.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: const [
            CustomButton(
              title: 'WeatherFirst',
              child: WeatherFirstPage(),
            ),
            CustomButton(
              title: 'WeatherSecond',
              child: WeatherSecondPage(),
            ),
          ],
        ),
      ),
    );
  }
}
