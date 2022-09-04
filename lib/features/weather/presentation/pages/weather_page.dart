import 'package:flutter/material.dart';
import 'package:test1/features/weather/presentation/widgets/weather_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: const WeatherWidget(),
    );
  }
}
