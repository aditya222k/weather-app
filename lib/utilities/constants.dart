import 'package:flutter/material.dart';
import 'dart:math';

const kTempTextStyle = TextStyle(
    // fontFamily: 'Spartan MB',
    fontSize: 75.0,
    color: Colors.black);

const kMessageTextStyle = TextStyle(
    // fontFamily: 'Spartan MB',
    fontSize: 60.0,
    color: Colors.black);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  color: Colors.white,
  // fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kSecondaryInfo = TextStyle(fontSize: 37, color: Colors.black);
const kSecondaryText = TextStyle(fontSize: 11, color: Colors.black);

const apiKey = 'bf578cae77350e81058299bb32a592f9';

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  focusColor: Colors.pink,
  icon: Icon(Icons.location_city,),
  hintText: 'Enter city location',
  hintStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  fillColor: Colors.white,
);

double roundDouble(double value, int places) {
  double mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
} //learn
