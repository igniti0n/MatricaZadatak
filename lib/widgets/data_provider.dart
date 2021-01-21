import 'package:MatricaZadatak/services/data_provider_service.dart';
import 'package:flutter/material.dart';

import '../screens/dashboard.dart';

import 'package:provider/provider.dart';

class DataProvider extends StatelessWidget {
  const DataProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DataProviderService>(context, listen: false)
          .getUpperData(),
      builder: (ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("waiting upper data :(");
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return DashBoard();
        }
      },
    );
  }
}
