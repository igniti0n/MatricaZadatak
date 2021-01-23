import 'package:MatricaZadatak/widgets/into_builder.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DashBoardBuilder extends StatefulWidget {
  const DashBoardBuilder({Key key}) : super(key: key);

  @override
  _DashBoardBuilderState createState() => _DashBoardBuilderState();
}

class _DashBoardBuilderState extends State<DashBoardBuilder> {
  DateTime startDate = DateTime(2020, 12, 21);

  void _onForward() {
    setState(() {
      startDate = startDate.add(Duration(days: 7));
    });
  }

  void _onBackwards() {
    setState(() {
      startDate = startDate.subtract(Duration(days: 7));
    });
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
            focusColor: Colors.red,
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
            onPressed: _onForward,
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: Provider.value(
        value: startDate,
        builder: (ctx, _) => IntroBuilder(),
      ),
    );
  }
}
