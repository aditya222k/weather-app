import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'location_screen.dart';

class CityScreen extends StatefulWidget {
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
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: Hero(
                    tag: 'ani',
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  style:TextStyle(color: Colors.black),
                  onChanged: (value){cityName=value;},

                  decoration: kTextFieldInputDecoration,
                ),
              ),
              TextButton(
                onPressed: () {
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
