import 'dart:async';

import 'package:MatricaZadatak/screens/dash_board_builder.dart';
import 'package:flutter/material.dart';

import '../widgets/dashboard_section.dart';
import '../models/agent.dart';
import '../services/data_provider_service.dart';

import 'package:provider/provider.dart';

class DataProvider extends StatefulWidget {
  final bool isUpper;
  const DataProvider({Key key, @required this.isUpper}) : super(key: key);

  @override
  _DataProviderState createState() => _DataProviderState();
}

class _DataProviderState extends State<DataProvider> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    print("tajmer pocinje");
    _timer = new Timer(Duration(seconds: 2), () {
      setState(() {
        print("TAJMER SE IZVRSIO");
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final DateTime _startDate = Provider.of<DateTime>(context, listen: true);
    return Consumer<DateNotifier>(
      builder: (ctx, dateNotifier, _) => FutureBuilder(
        future:
            Provider.of<DataProviderService>(context, listen: false).getData(
          dateNotifier.getDate,
          widget.isUpper,
        ),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child:
                  _timer.isActive ? Container() : CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Error while loading data.\n${snapshot.error.toString()}"),
            );
          } else {
            _timer.cancel();
            final List<Agent> _agentsList = snapshot.data as List<Agent>;
            return DashBoardSection(
              isUpper: widget.isUpper,
              agentsToBeDisplayed: _agentsList,
              startDate: dateNotifier.getDate,
            );
          }
        },
      ),
    );
  }
}
