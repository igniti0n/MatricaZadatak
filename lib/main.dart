import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/authentication_builder.dart';

import 'package:provider/provider.dart';
import './services/internet_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(
            LogicalKeyboardKey.select,
            LogicalKeyboardKey.gameButtonSelect,
            LogicalKeyboardKey.enter): const ActivateIntent(),
      },
      child: Provider(
        create: (ctx) => InternetService(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Matrica zadatak',
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
          home: FutureBuilder(
              future: InternetService.checkInternetConnection(),
              builder: (ctx, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.data == false || snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(
                          "Unable to connect to internet.\nPlease check your internet connection and try again."),
                    ),
                  );
                }

                return AuthenticationBuilder();
              }),
        ),
      ),
    );
  }
}
