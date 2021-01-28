import 'package:flutter/material.dart';

class DateNotifier extends ChangeNotifier {
  DateTime _startDate = DateTime(2020, 12, 21);

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
