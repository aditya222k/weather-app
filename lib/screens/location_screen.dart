import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:lottie/lottie.dart';
import 'package:clima/utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temperature;
  int maxT;
  int minT;
  String weatherIcon;
  String weatherMessage;
  String cityName;
  String description;
  int cloudCover;
  double windSpeed;
  int humidity;
  int feelsLike;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable ot get weather data';
        cityName = '';
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
      description = weatherData['weather'][0]['description'];
      cloudCover = weatherData['clouds']['all'];
      windSpeed = weatherData['wind']['speed'];
      humidity = weatherData['main']['humidity'];
      double maxTemp = weatherData['main']['temp_max'];
      maxT = maxTemp.toInt();
      double minTemp = weatherData['main']['temp_min'];
      minT = minTemp.toInt();
      double realFeels = weatherData['main']['feels_like'];
      feelsLike = realFeels.toInt();
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });

    // print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFFFFFF),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        //Weather of present location
                        onPressed: () {
                          setState(() {
                            updateUI(widget.locationWeather);
                          });
                        },
                        child: Icon(
                          Icons.near_me,
                          color: Colors.black,
                          size: 55,
                        ),
                      ),
                      MaterialButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        //Weather of present location
                        onPressed: () async {
                          var typedName = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CityScreen();
                          }));
                          if (typedName != null) {
                            var weatherData =
                                await weather.getCityWeather('$typedName');
                            updateUI(weatherData);
                          }
                        },
                        child: Icon(
                          Icons.add_business_rounded,
                          color: Colors.black,
                          size: 55,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 70, 0, 0),
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                '$cityName',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                              ),
                              Text(
                                '$temperature°',
                                style: kTempTextStyle,
                              ),
                              Text(
                                '$maxT°/$minT° Feels like $feelsLike',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  '$description',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // color: Colors.red,
                          width: MediaQuery.of(context).size.width,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Lottie.asset(
                                  'Animations/weatherbaloon.json',
                                  height: 300,
                                  width: 240)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      height: 2,
                      margin: EdgeInsetsDirectional.only(top: 0, bottom: 0),
                      decoration: BoxDecoration(
                        border: Border(
                          left: Divider.createBorderSide(context,
                              color: Colors.grey[300],
                              width: MediaQuery.of(context).size.width),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Row(
                    children: [
                      BodyExpands(
                        about: 'Cloud cover',
                        temp: '$cloudCover%',
                      ),
                      BodyExpands(
                        about: 'Real feels',
                        temp: '$feelsLike°',
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 55,
                  endIndent: 55,
                  color: Colors.grey[300],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                  child: Row(
                    children: [
                      BodyExpands(
                        about: 'Wind',
                        temp: '${roundDouble(windSpeed * 18 / 5, 2)}kph',
                      ),
                      BodyExpands(
                        about: 'Humidity',
                        temp: '$humidity%',
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey[300],
                ),
                Container(
                  child: SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Wind'),
                                    Row(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ))),
      ),
    );
  }
}

class BodyExpands extends StatelessWidget {
  BodyExpands({this.about, this.temp});
  final String about;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          about,
          style: kSecondaryText,
        ),
        Text(
          '$temp',
          style: kSecondaryInfo,
        ),
      ],
    ));
  }
}

// Container(
// color: Colors.grey,
// constraints: BoxConstraints.expand(),
// child: SafeArea(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: <Widget>[
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// FlatButton(
// onPressed: () {setState(() {
// updateUI(widget.locationWeather);
// });
// },
// child: Icon(
// Icons.near_me,
// size: 50.0,
// ),
// ),
// MaterialButton(
// onPressed: () async{
// var typedName = await Navigator.push(context,
// MaterialPageRoute(builder: (context) {
// return CityScreen();
// }));
// if (typedName != null){
// var weatherData= await weather.getCityWeather('$typedName');
// updateUI(weatherData);
// }
// },
// child: Icon(
// Icons.location_city,
// size: 50.0,
// ),
// ),
// ],
// ),
// Padding(
// padding: EdgeInsets.only(left: 15.0),
// child: Row(
// children: <Widget>[
// Text(
// '$temperature°',
// style: kTempTextStyle,
// ),
// Material(
// shape: RoundedRectangleBorder(
// borderRadius: const BorderRadius.all(
// Radius.circular(150.0))),
// child: Lottie.asset(
// weatherIcon,
// height: 150,
// width: 150,
// fit: BoxFit.fill,
// ),
// ),
// ],
// ),
// ),
// Padding(
// padding: EdgeInsets.only(right: 15.0),
// child: Text(
// '$weatherMessage in $cityName!',
// textAlign: TextAlign.right,
// style: kMessageTextStyle,
// ),
// ),
// ],
// ),
// ),
// ),
