import 'package:flutter/material.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic> currentLocationWeather;

  LocationScreen({this.currentLocationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String cityName;
  String tempMessage;
  String weatherIcon;
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.currentLocationWeather);
  }

  void updateUI(Map<String, dynamic> weather) {
    setState(() {
      if (weather == null) {
        temperature = 0;
        tempMessage = 'Error. Unable to get weather';
        cityName = '';
        weatherIcon = '';
        return;
      }
      var temp = weather['main']['temp'];
      temperature = temp.toInt();
      tempMessage = weatherModel.getMessage(temperature.toInt());
      cityName = weather['name'];
      int condition = weather['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Map<String, dynamic> weatherData =
                          await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      String typedCityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => CityScreen(),
                        ),
                      );
                      if (typedCityName != null) {
                        Map<String, dynamic> cityWeather =
                            await weatherModel.getCityWeather(typedCityName);
                        updateUI(cityWeather);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature.toString()}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$tempMessage $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
