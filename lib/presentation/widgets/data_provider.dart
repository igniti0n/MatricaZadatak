import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/dashboard_section.dart';
import '../../data/models/agent.dart';
import '../../data/services/data_provider_service.dart';
import '../../logic/date_provider.dart';

import 'package:provider/provider.dart';

class DataProvider extends StatelessWidget {
  final bool isUpper;
  const DataProvider({Key key, @required this.isUpper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DateNotifier>(builder: (ctx, dateNotifier, _) {
      return FutureBuilder(
        future:
            Provider.of<DataProviderService>(context, listen: false).getData(
          dateNotifier.getDate,
          isUpper,
        ),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator(
                strokeWidth: 1,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Error while loading data.\n${snapshot.error.toString()}"),
            );
          } else {
            final List<Agent> _agentsList = snapshot.data as List<Agent>;
            return DashBoardSection(
              isUpper: isUpper,
              agentsToBeDisplayed: _agentsList,
              startDate: dateNotifier.getDate,
            );
          }
        },
      );
    });
  }
}
