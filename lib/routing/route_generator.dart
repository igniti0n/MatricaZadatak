import 'package:MatricaZadatak/constants.dart';
import 'package:MatricaZadatak/presentation/screens/dashboard.dart';
import 'package:MatricaZadatak/presentation/screens/single_view.dart';
import 'package:MatricaZadatak/presentation/screens/top_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSetting) {
  switch (routeSetting.name) {
    case fullViewRoute:
      return MaterialPageRoute(builder: (_) => DashBoard());
      break;
    case onlyCCRoute:
      return MaterialPageRoute(builder: (_) => TopView());
      break;
    case singleViewRoute:
      return MaterialPageRoute(builder: (_) => SingleView());
      break;
    default:
      return null;
  }
}
