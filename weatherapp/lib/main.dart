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
  double temp = 0.0;
  int humidity = 0;
  double latitude = 0;
  double longitude = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("weather2.png"),
            fit: BoxFit.cover,
          ),
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment(0.8, 1),
          //   colors: <Color>[
          //     Color.fromARGB(255, 244, 243, 246),
          //     Color.fromARGB(255, 206, 232, 240),
          //     Color.fromARGB(255, 187, 242, 249),
          //     Color.fromARGB(255, 140, 250, 250),
          //     Color.fromARGB(255, 131, 249, 249),
          //     Color.fromARGB(255, 154, 224, 247),
          //     Color.fromARGB(255, 66, 185, 196),
          //     Color.fromARGB(255, 131, 173, 222),
          //   ],
          // ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Weather App"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage('images/weather2.png'),
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
                Text("tempreture: " '${temp}'),
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
