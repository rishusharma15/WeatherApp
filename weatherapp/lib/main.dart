import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weatherapp/services/api_helper.dart';
import 'package:weatherapp/services/gps_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String city = "";
  double temp = 0;
  int humidity = 0;
  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather_background1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Weather App"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage('images/weather2.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 330,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "search location",
                      ),
                      onChanged: (value) {
                        city = value;
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var r = await ApiHelper(city).call_api();
                    GpsHelper gps = GpsHelper();
                    await gps.get_location();

                    print(r);

                    setState(() {
                      temp = r['current']['temp_c'];
                      humidity = r['current']['humidity'];
                      latitude = gps.latitude;
                      longitude = gps.longitude;
                    });
                  },
                  child: Text("search"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(""),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Temperature :  ",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Text(
                      '${temp}',
                      style: TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Column(
                      children: [
                        Text(
                          '°C',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(''),
                      ],
                    ),
                  ],
                ),
                //Text("tempreture: " '${temp}'),
                Text("humidity: " '${humidity}'),
                Text("latitude: " '${latitude}'),
                Text("longitude: " '${longitude}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
