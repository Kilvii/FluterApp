import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert' as convert;
import 'package:dio/dio.dart';

class currentWeather extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _currentWeather();
  }
}

class _currentWeather extends State<currentWeather> {

  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    var url = "Your Weather API URL";
    var response = await Dio().get(url);
    var results = response.data;
    var res1 = results.toString().split(":");
    var buf_temp = res1[11].split(", ");
    var buf_temp_2 = double.parse(buf_temp[0])-273.0;
    var buf_desc = res1[7].split(", ");
    var buf_curr = res1[6].split(", ");
    var buf_hum = res1[16].split(", ");
    var buf_wind = res1[21].split(", ");

    setState(() {
      temp = buf_temp_2.round().toString();
      description = buf_desc[0];
      currently = buf_curr[0];
      humidity = buf_hum[0];
      windSpeed = buf_wind[0];
    });
  }

  @override
  void initState () {
    super.initState();
    getWeather();
  }

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurple,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Current weather in Saransk",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : "Loading",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null ? currently.toString() : "Loading",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\u00B0" : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Weather"),
                    trailing: Text(description != null ? description.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("Humidity"),
                    trailing: Text(humidity != null ? humidity.toString() : "Loading"),
                  ),
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Wind"),
                    trailing: Text(windSpeed != null ? windSpeed.toString() : "Loading"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
