import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './presentation/widgets/authentication_builder.dart';
import './data/services/authentication_service.dart';
import './data/services/data_provider_service.dart';

import 'package:provider/provider.dart';

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
              fontSize: 7,
              color: Colors.grey[800],
            ),
          ),
        ),
        home: MultiProvider(
          providers: [
            Provider(
              create: (ctx) => AuthenticationService(),
            ),
            Provider(
              create: (ctx) => DataProviderService(),
            ),
          ],
          builder: (ctx, _) {
            return AuthenticationBuilder();
          },
        ),
      ),
    );
  }
}
