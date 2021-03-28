import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

const String baseUrl = 'http://api.openweathermap.org/data/2.5/weather';
const String apiKey = '7c0be0c682578a68692483b0f8982c56';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      url: '$baseUrl?q=$cityName&appid=$apiKey&units=metric',
    );
    return networkHelper.getData();
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    double lat = location.lat;
    double long = location.long;

    NetworkHelper networkHelper = NetworkHelper(
      url: '$baseUrl?lat=$lat&lon=$long&appid=$apiKey&units=metric',
    );

    return networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time in';
    } else if (temp > 20) {
      return 'Time for shorts and  in👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in';
    } else {
      return 'Bring a 🧥 just in case in';
    }
  }
}
