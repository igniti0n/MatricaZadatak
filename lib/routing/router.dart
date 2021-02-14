import 'package:flutter/material.dart';

class AppRouter {
  GlobalKey<NavigatorState> _navigatorKey = new GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  void goTo(String route) {
    _navigatorKey.currentState.pushNamed(route);
  }

  void goToReplace(String route) {
    _navigatorKey.currentState.pushReplacementNamed(route);
  }

  void goBack() {
    _navigatorKey.currentState.pop();
  }
}
