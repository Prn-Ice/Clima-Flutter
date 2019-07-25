import 'package:flutter/material.dart';

import 'screens/city_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/location_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        LoadingScreen.routeName: (context) => LoadingScreen(),
        LocationScreen.routeName: (context) =>
            LocationScreen(ModalRoute.of(context).settings.arguments),
        CityScreen.routeName: (context) => CityScreen()
      },
    );
  }
}
