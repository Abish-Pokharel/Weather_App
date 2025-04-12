import 'package:flutter/material.dart';

class WeatherForecast extends StatefulWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const WeatherForecast({
    super.key,
    required this.icon,
    required this.time,
    required this.temperature,
  });

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      width: deviceWidth * 0.30,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 56, 56, 56),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.time,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          Icon(widget.icon, size: 40),

          Text(
            widget.temperature.isEmpty
                ? "Loading..."
                : "${widget.temperature}°F",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
