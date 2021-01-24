import 'package:MatricaZadatak/widgets/into_builder.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DashBoardBuilder extends StatelessWidget {
  DashBoardBuilder({Key key}) : super(key: key);

  DateNotifier date = new DateNotifier();

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

class DateNotifier extends ChangeNotifier {
  //DateNotifier _notifier;
  DateTime _startDate = DateTime(2020, 12, 21);
  // DateNotifier._();

  DateTime get getDate => DateTime.parse(_startDate.toIso8601String());

  void increaseStartDate() {
    _startDate = _startDate.add(Duration(days: 7));
    notifyListeners();
  }

  void decreaseStartDate() {
    _startDate = _startDate.subtract(Duration(days: 7));
    notifyListeners();
  }
}
