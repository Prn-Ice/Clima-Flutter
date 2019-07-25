/// This is the screen that shows up while we fetch data
/// it uses the [Location] and [NetworkHelper] classes to
/// obtain the devices location and then get the current
/// weather conditions

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';
import '../services/networking.dart';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  /// This function is the function actually responsible for fetching
  /// information from both the [Location] and [NetworkHelper] classes
  /// and then storing that data for use in the next screen

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeatherData();

    Navigator.pushNamed(
      context,
      LocationScreen.routeName,
      arguments: LocationScreenArguments(weatherData: weatherData),
    );
  }

  @override
  void initState() {
    super.initState();
//    getLocationData() is called in init so that it runs once the widget is
//    created

    ///  FIXME If user presses the back button on [LocationScreen] it comes back here but just runs the animation on an infinite loop

    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
//        Show a spinner while weather data is fetched,
//        don't worry it is killed after deactivate()
        child: SpinKitRipple(
          size: 200.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
