import 'package:flutter/material.dart';

import '../services/authentication_service.dart';
import '../services/data_provider_service.dart';
import '../screens/dash_board_builder.dart';

import 'package:provider/provider.dart';

class AuthenticationBuilder extends StatelessWidget {
  const AuthenticationBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (ctx) => AuthenticationService(),
        ),
        Provider(
          create: (ctx) => DataProviderService(),
        ),
      ],
      builder: (ctx, _) {
        return FutureBuilder(
          future:
              Provider.of<AuthenticationService>(ctx, listen: false).login(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: Colors.grey[200],
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return DashBoardBuilder();
            }
          },
        );
      },
    );
  }
}
