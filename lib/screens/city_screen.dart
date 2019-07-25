//This screen allows the user to pick a city of
// his/her choosing

import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  static const routeName = '/city';
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
//              TODO show dropdown of city names that could match city entered
//              TODO show error on screen when city cant be found
//              This is how you create a simple text field
                child: TextField(
                  onChanged: (value) {
                    print(value);
                    cityName = value;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: Colors.grey),
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
//                Go back to the previous screen and give it the cityName
//                the user inputted
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
