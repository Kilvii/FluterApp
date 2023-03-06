import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flut_app/eios/login_page.dart';
import 'package:dio/dio.dart';

import 'OAuth.dart';

class HomePage extends StatefulWidget{
  final String emailC;
  final String passC;
  HomePage(this.emailC, this.passC);

  @override
  State<StatefulWidget> createState() {
    return _homePage();
  }
}

class _homePage extends State<HomePage> {

  var access_token;

  var studentCode;
  var email;
  var user;
  var bday;

  final Dio _dio = Dio();

  Future<Response> login() async {
    var tokens;
    final data = {"grant_type": "password"};

    data.addAll({"username": widget.emailC, "password": widget.passC});
    final encodedData = data.entries.toList().map((entry) => [
      Uri.encodeComponent(entry.key),
      Uri.encodeComponent(entry.value)
    ].join('='))
        .join('&');
    try {
      final response = await _dio.post(
          'https://p.mrsu.ru/OAuth/Token',
          data: encodedData,
          options: Options(
              contentType: 'application/x-www-form-urlencoded',
              headers: {
                "Authorization":
                "Basic ${stringToBase64.encode('8:qweasd')}"
              })
      );
      //returns the successful user data json object
      tokens = response.data.toString();
      var buff = tokens.split(", ");
      access_token = buff[0].split(": ");
      getUserData(access_token[1]);
      getTestArchive(access_token[1]);
      return response;
    } on DioError catch (e) {
      //returns the error object if any
      return e.response!.data;
    }
  }

  Future getUserData(String accesstoken) async {
    var response = await _dio.get('https://papi.mrsu.ru/v1/User',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
      ),
    );
    if (response.statusCode == 200) {
      var buff = response.data.toString();
      var buff2 = buff.split(": ");
      var sCbuff = buff2[5].split(", ");
      var ebuff = buff2[1].split(", ");
      var ubuff = buff2[14].split(", ");
      var b_buff = buff2[6].split("T");
      setState(() {
        studentCode = sCbuff[0];
        email = ebuff[0];
        user = ubuff[0];
        bday = b_buff[0];
      });
    }
  }

  Future getTestArchive(String accesstoken) async {
    var response = await _dio.get('https://papi.mrsu.ru/v1/TestProfileForPass?archive=true&count=10&offset=0',
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accesstoken',
        },
      ),
    );
    if (response.statusCode == 200) {
      var buff = response.data.toString();
      var buff2 = buff.split(": ");
      var sCbuff = buff2[5].split(", ");
      var ebuff = buff2[1].split(", ");
      var ubuff = buff2[14].split(", ");
      var b_buff = buff2[6].split("T");
      setState(() {
        studentCode = sCbuff[0];
        email = ebuff[0];
        user = ubuff[0];
        bday = b_buff[0];
      });
    }
  }

  @override
  void initState () {
    super.initState();
    login();
  }

  @override
  Widget build(BuildContext context) {
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
                    "EIOS User Data",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                // Text(
                //   temp != null ? temp.toString() + "\u00B0" : "Loading",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 40.0,
                //       fontWeight: FontWeight.w600
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(top: 10.0),
                //   child: Text(
                //     currently != null ? currently.toString() : "Loading",
                //     style: TextStyle(
                //         color:Colors.white,
                //         fontSize: 14.0,
                //         fontWeight: FontWeight.w600
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Expanded(
            child:Padding(
              padding: EdgeInsets.all(20.0),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    // leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Student Code"),
                    trailing: Text(studentCode != null ? studentCode : "Loading"),
                  ),
                  ListTile(
                    // leading: FaIcon(FontAwesomeIcons.cloud),
                    title: Text("Email"),
                    trailing: Text(email != null ? email : "Loading"),
                  ),
                  ListTile(
                    // leading: FaIcon(FontAwesomeIcons.sun),
                    title: Text("User"),
                    trailing: Text(user != null ? user : "Loading"),
                  ),
                  ListTile(
                    // leading: FaIcon(FontAwesomeIcons.wind),
                    title: Text("Birthday"),
                    trailing: Text(bday != null ? bday : "Loading"),
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
