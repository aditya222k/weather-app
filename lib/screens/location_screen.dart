import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/weather.dart';
import 'package:lottie/lottie.dart';
import 'package:clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  int temperature;
  String weatherIcon;
  String weatherMessage;
  String cityName;

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
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
    });

    // print(cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'City name',
                              style: TextStyle(fontSize: 45),
                            ),
                            Text(
                              '25°',
                              style: kTempTextStyle,
                            ),
                            Text(
                              'Condition',
                              style: TextStyle(fontSize: 45),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Lottie.asset('Animations/weatherbaloon.json',
                                height: 320, width: 450)),
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
                                color: Colors.green,
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
                          about: 'chance of Rain',
                          temp: '25%',
                        ),
                        BodyExpands(
                          about: 'Real feels',
                          temp: '25°',
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    indent: 55,
                    endIndent: 55,
                    color: Colors.pink,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                    child: Row(
                      children: [
                        BodyExpands(
                          about: 'Wind',
                          temp: '25kph',
                        ),
                        BodyExpands(
                          about: 'Humidity',
                          temp: '25%',
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.yellow,
                  ),
                ],
              )),
        ));
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
