import 'package:flutter/material.dart';

import './widgets/authentication_builder.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 9,
          ),
          bodyText1: TextStyle(
            //fontWeight: FontWeight.bold,
            fontSize: 7,
            color: Colors.grey[800],
          ),
        ),
      ),
      home: AuthenticationBuilder(),
    );
  }
}
