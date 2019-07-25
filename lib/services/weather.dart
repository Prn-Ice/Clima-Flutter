///This class is responsible for sending get requests
///to the [openweather.org] using the [NetworkHelper]
///class and returning the weather data to calling classes

import '../utilities/constants.dart';
import 'location.dart';
import 'networking.dart';

class WeatherModel {
  //  Returns weather data for selected city
  Future<dynamic> getCityWeatherData(var cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherURL?q=$cityName&APPID=$kApiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

//  Returns weather data for devices current location
  Future<dynamic> getLocationWeatherData() async {
    Location location = Location();
    await location.getCurrentLocation();
    print('longitude: ${location.longitude}\tlatitude: ${location.latitude}');

    NetworkHelper networkHelper = NetworkHelper(
        '$kOpenWeatherURL?lat=${location.longitude}&lon=${location.latitude}&APPID=$kApiKey&units=metric');

    var weatherData = await networkHelper.getData();
    print('done');
    return weatherData;
  }

//  Returns an icon based on current weather conditions
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

  //  Returns an icon based on current temperature
  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
