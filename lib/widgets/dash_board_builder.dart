import 'package:flutter/material.dart';

import '../widgets/data_provider.dart';

class DashBoardBuilder extends StatelessWidget {
  const DashBoardBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DataProvider(),
    );
  }
}
