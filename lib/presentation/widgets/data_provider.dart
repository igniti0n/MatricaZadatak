import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/dashboard_section.dart';
import '../../data/models/agent.dart';
import '../../data/services/data_provider_service.dart';
import '../../logic/date_provider.dart';

import 'package:provider/provider.dart';

class DataProvider extends StatelessWidget {
  final bool isUpper;
  final List<Agent> agentsList;
  DataProvider({Key key, @required this.isUpper, this.agentsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, int>> _sumeAgenata = {};
    if (isUpper) {
      agentsList.forEach((Agent agent) {
        _sumeAgenata.update(
            agent.name,
            (value) => {
                  'agreedAppointments':
                      value['agreedAppointments'] + agent.agreedAppointments,
                  'sales': value['sales'] + agent.sales,
                  'leads': value['leads'] + agent.leads,
                },
            ifAbsent: () => {
                  'agreedAppointments': agent.agreedAppointments,
                  'sales': agent.sales,
                  'leads': agent.leads,
                });
      });

      // print(agentsList.first.name +
      //     _sumeAgenata[agentsList.first.name].toString());
    }
    final List<Agent> _listaSuma = [];
    _sumeAgenata.forEach((key, value) {
      _listaSuma.add(Agent(
        name: key,
        agreedAppointments: value['agreedAppointments'],
        leads: value['leads'],
        sales: value['sales'],
        date: DateTime.now(),
      ));
    });

    print(_listaSuma);
    return Provider<List<Agent>>(
      create: (ctx) => _listaSuma,
      builder: (ctx, _) => DashBoardSection(
        isUpper: isUpper,
        agentsToBeDisplayed: agentsList,
      ),
    );
  }
}
