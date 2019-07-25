import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

import '../services/weather.dart';
import 'city_screen.dart';

class LocationScreenArguments {
  LocationScreenArguments({@required this.weatherData});
  final weatherData;
}

class LocationScreen extends StatefulWidget {
  static const routeName = '/location';

  final LocationScreenArguments args;

  LocationScreen(this.args);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temperature;
  String condition;
  String cityName;
  String message;

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData != null) {
        var temp = weatherData['main']['temp'];
        this.temperature = temp.toInt();

        int condition = weatherData['weather'][0]['id'];
        this.condition = weatherModel.getWeatherIcon(condition);

        this.message = weatherModel.getMessage(temperature);

        this.cityName = weatherData['name'];
        return;
      } else {
        temperature = 0;
        condition = 'Error';
        cityName = '';
        message = 'Could not fetch weather data';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    updateUI(widget.args.weatherData);
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
                  FlatButton(
                    onPressed: () async {
//                      TODO refresh ui with updated location data
                      var weatherData =
                          await weatherModel.getLocationWeatherData();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
//                    The Navigator.pushNamed function waits for the output of the
                    ///[CityScreen] class and then updates cityName with that value
                    ///if the city exists, the UI is updated with its weather data
                    onPressed: () async {
                      var cityName = await Navigator.pushNamed(
                          context, CityScreen.routeName);
                      var weatherData =
                          await weatherModel.getCityWeatherData(cityName);

                      if (weatherData != null) {
                        updateUI(weatherData);
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
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message ${cityName == '' ? '' : 'in'} $cityName",
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
