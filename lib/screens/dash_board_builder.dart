import 'package:flutter/material.dart';

import '../widgets/dashboard.dart';

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
    final MediaQueryData _mediaData = MediaQuery.of(context);
    final double _availableHeight = _mediaData.size.height -
        _mediaData.padding.bottom -
        _mediaData.padding.top;
    final double _availableWidth = _mediaData.size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SalvisTV Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: _onBackwards,
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
        builder: (ctx, _) => DashBoard(),
      ),
    );
  }
}
