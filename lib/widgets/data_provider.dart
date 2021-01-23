import 'package:flutter/material.dart';

import '../widgets/dashboard_section.dart';
import '../models/agent.dart';
import '../services/data_provider_service.dart';

import 'package:provider/provider.dart';

class DataProvider extends StatelessWidget {
  final bool isUpper;
  const DataProvider({Key key, @required this.isUpper}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime _startDate = Provider.of<DateTime>(context, listen: false);
    return FutureBuilder(
      future: Provider.of<DataProviderService>(context, listen: false).getData(
        _startDate,
        isUpper,
      ),
      builder: (ctx, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final List<Agent> _agentsList = snapshot.data as List<Agent>;
          return DashBoardSection(
            isUpper: isUpper,
            agentsToBeDisplayed: _agentsList,
          );
        }
      },
    );
  }
}
