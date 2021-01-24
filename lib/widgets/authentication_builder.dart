import 'dart:async';

import 'package:MatricaZadatak/screens/dash_board_builder.dart';
import 'package:flutter/material.dart';

import '../services/authentication_service.dart';
import '../services/data_provider_service.dart';

import 'package:provider/provider.dart';

class AuthenticationBuilder extends StatefulWidget {
  const AuthenticationBuilder({Key key}) : super(key: key);

  @override
  _AuthenticationBuilderState createState() => _AuthenticationBuilderState();
}

class _AuthenticationBuilderState extends State<AuthenticationBuilder> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer(Duration(seconds: 2), () {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<AuthenticationService>(context, listen: false).login(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
              child: _timer.isActive
                  ? Container()
                  : CircularProgressIndicator(
                      strokeWidth: 1,
                    ),
            ),
          );
        } else {
          _timer.cancel();
          return DashBoardBuilder();
        }
      },
    );
  }
}
