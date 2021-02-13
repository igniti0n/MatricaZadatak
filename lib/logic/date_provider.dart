import 'package:MatricaZadatak/data/models/agent.dart';
import 'package:flutter/material.dart';

class DateNotifier extends ChangeNotifier {
  DateTime _startDate;
  List<Agent> _mjesecnoSvi = [];

  DateNotifier(DateTime date) {
    _startDate = date;
    print(_startDate.toIso8601String());
    while (_startDate.weekday != 1) {
      print(_startDate.weekday);
      print(_startDate.toIso8601String());
      _startDate = _startDate.subtract(Duration(days: 1));
    }
  }

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
