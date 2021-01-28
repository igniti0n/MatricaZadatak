import 'package:flutter/material.dart';

import '../../logic/date_provider.dart';
import '../../presentation/widgets/into_builder.dart';

import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  DashBoardBuilder({Key key}) : super(key: key);

  final DateNotifier date = new DateNotifier();

  void _onForward() {
    date.increaseStartDate();
  }

  void _onBackwards() {
    date.decreaseStartDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SalvisTV Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: _onBackwards,
            focusColor: Colors.green[900],
          ),
          IconButton(
            focusColor: Colors.green[900],
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: _onForward,
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: ChangeNotifierProvider(
        create: (ctx) => date,
        builder: (ctx, _) => IntroBuilder(),
      ),
    );
  }
}
