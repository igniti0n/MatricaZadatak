import 'package:flutter/material.dart';

import '../services/authentication_service.dart';

import 'package:provider/provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('UČITANO'),
    );
  }
}
