import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_apk/add_info.dart';
import 'package:weather_apk/weather_forecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "clear":
        return Icons.wb_sunny;
      case "clouds":
        return Icons.cloud;
      case "rain":
        return Icons.water_drop;
      case "drizzle":
        return Icons.grain;
      case "thunderstorm":
        return Icons.flash_on;
      case "snow":
        return Icons.ac_unit;
      case "mist":
      case "fog":
      case "haze":
        return Icons.blur_on;
      default:
        return Icons.wb_cloudy;
    }
  }

  final dio = Dio();
  String cityName = "Nepal";
  bool isLoading = true;

  final searchController = TextEditingController();

  String temperature = "";
  String weatherMain = "";
  String humidity = "";
  String pressure = "";
  String windSpeed = "";
  String tempMax = "";
  String tempMin = "";

  apiCall() async {
    setState(() {
      isLoading = true;
    });

    String apiKey = "20285f171ce9c172bde65e2bab72856b";
    Response response = await dio.get(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$apiKey',
    );

    temperature = response.data['main']['temp'].toStringAsFixed(1);
    tempMax = response.data['main']['temp_max'].toStringAsFixed(1);
    tempMin = response.data['main']['temp_min'].toStringAsFixed(1);
    weatherMain = response.data['weather'][0]['main'];
    humidity = response.data['main']['humidity'].toString();
    pressure = response.data['main']['pressure'].toString();
    windSpeed = response.data['wind']['speed'].toString();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Weather",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              apiCall();
            },
            child: Icon(Icons.refresh, color: Colors.white, size: 24),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(child: Center(child: CircularProgressIndicator()))
              : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 2,
                            ),
                            prefixIcon: const Icon((Icons.search)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            labelText: "Search",
                          ),
                          onFieldSubmitted: (value) {
                            cityName = value;
                            apiCall();
                            searchController.clear();
                          },
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 220,
                          width: deviceWidth,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 56, 56, 56),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${temperature}°F",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              Icon(getWeatherIcon(weatherMain), size: 82),

                              Text(
                                weatherMain,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Weather Forecast",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          height: 120,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,

                            child: Row(
                              children: [
                                WeatherForecast(
                                  time: "09:00",
                                  icon: Icons.sunny,
                                  temperature: temperature,
                                ),
                                SizedBox(width: 15),
                                WeatherForecast(
                                  time: "12:00",
                                  icon: Icons.cloud,
                                  temperature: tempMax,
                                ),
                                SizedBox(width: 15),
                                WeatherForecast(
                                  time: "03:00",
                                  icon: Icons.water_drop,
                                  temperature: tempMin,
                                ),
                                SizedBox(width: 15),
                                WeatherForecast(
                                  time: "08:00",
                                  icon: Icons.flash_on,
                                  temperature: tempMax,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Additional Information",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AddInformation(
                              icon: Icons.water_drop,
                              label: "Humidity",
                              value: humidity,
                            ),
                            AddInformation(
                              icon: Icons.air,
                              label: "Wind Speed",
                              value: windSpeed,
                            ),
                            AddInformation(
                              icon: Icons.beach_access,
                              label: "Pressure",
                              value: pressure,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
