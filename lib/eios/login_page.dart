import 'package:flutter/material.dart';
import 'package:flut_app/weather/currentWeather.dart';
import 'package:flut_app/eios/home_page.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'OAuth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  bool _isObscure = true;

  final Dio _dio = Dio();

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  // var access_token;
  //
  // var studentCode;
  // var email;
  // var user;
  // var bday;



  // Future<Response> login() async {
  //   var tokens;
  //   final data = {"grant_type": "password"};
  //
  //   data.addAll({"username": _emailController.text, "password": _passwordController.text});
  //   final encodedData = data.entries.toList().map((entry) => [
  //     Uri.encodeComponent(entry.key),
  //     Uri.encodeComponent(entry.value)
  //   ].join('='))
  //       .join('&');
  //     try {
  //       final response = await _dio.post(
  //         'https://p.mrsu.ru/OAuth/Token',
  //         data: encodedData,
  //           options: Options(
  //               contentType: 'application/x-www-form-urlencoded',
  //               headers: {
  //                 "Authorization":
  //                 "Basic ${stringToBase64.encode('8:qweasd')}"
  //               })
  //       );
  //       //returns the successful user data json object
  //       tokens = response.data.toString();
  //       var buff = tokens.split(", ");
  //       access_token = buff[0].split(": ");
  //       // getUserData(access_token[1]);
  //       return response;
  //     } on DioError catch (e) {
  //       //returns the error object if any
  //       return e.response!.data;
  //     }
  // }
  //
  // Future getUserData(String accesstoken) async {
  //   var response = await _dio.get('https://papi.mrsu.ru/v1/User',
  //       options: Options(
  //         headers: {
  //           'Accept': 'application/json',
  //           'Authorization': 'Bearer $accesstoken',
  //         },
  //       ),
  //   );
  //   if (response.statusCode == 200) {
  //     var buff = response.data.toString();
  //     var buff2 = buff.split(": ");
  //     var sCbuff = buff2[5].split(", ");
  //     var ebuff = buff2[1].split(", ");
  //     var ubuff = buff2[14].split(", ");
  //     var b_buff = buff2[6].split("T");
  //     setState(() {
  //       studentCode = sCbuff[0];
  //       email = ebuff[0];
  //       user = ubuff[0];
  //       bday = b_buff[0];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),

                //Hello again!
                Text(
                  'Hello Again!',
                  style:TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'We will been missed!',
                  style:TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 50),

                //Email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      hintText: 'Email',
                      fillColor: Colors.grey[200],
                      filled: true,
                      suffixIcon: Icon(Icons.account_circle),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                //Password textfield
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true,
                        suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }
                        ),
                      ),
                    )
                ),
                SizedBox(height: 15),

                //Sign in button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(_emailController.text,_passwordController.text)));
                      // login();
                      // login();
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(
                        child: Text( 'Sigh In',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),

                //Not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Register now',
                      style: TextStyle(
                        color:Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => currentWeather()),
                    );
                  },
                  child: const Text(
                    'Weather screen >>',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}




