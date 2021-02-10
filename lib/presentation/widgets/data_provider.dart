import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/dashboard_section.dart';
import '../../data/models/agent.dart';
import '../../data/services/data_provider_service.dart';
import '../../logic/date_provider.dart';

import 'package:provider/provider.dart';

class DataProvider extends StatefulWidget {
  final bool isUpper;
  DataProvider({Key key, @required this.isUpper}) : super(key: key);

  @override
  _DataProviderState createState() => _DataProviderState();
}

class _DataProviderState extends State<DataProvider> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = new Timer(Duration(minutes: 1), callbackTimer);
  }

  void callbackTimer() {
    setState(() {});
    _timer = new Timer(Duration(minutes: 1), callbackTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateNotifier>(builder: (ctx, dateNotifier, _) {
      return FutureBuilder(
        future:
            Provider.of<DataProviderService>(context, listen: false).getData(
          dateNotifier.getDate,
          widget.isUpper,
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
            //print(_agentsList);
            Map<String, Map<String, int>> _sumeAgenata = {};
            if (widget.isUpper) {
              _agentsList.forEach((Agent agent) {
                // final Map<String, int> _temp = _sumeAgenata.putIfAbsent(
                //     agent.name,
                //     () => {
                //           'agreedAppointments': agent.agreedAppointments,
                //           'sales': agent.sales,
                //           'leads': agent.leads,
                //         });

                _sumeAgenata.update(
                    agent.name,
                    (value) => {
                          'agreedAppointments': value['agreedAppointments'] +
                              agent.agreedAppointments,
                          'sales': value['sales'] + agent.sales,
                          'leads': value['leads'] + agent.leads,
                        },
                    ifAbsent: () => {
                          'agreedAppointments': agent.agreedAppointments,
                          'sales': agent.sales,
                          'leads': agent.leads,
                        });
              });

              print(_agentsList.first.name +
                  _sumeAgenata[_agentsList.first.name].toString());
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
                isUpper: widget.isUpper,
                agentsToBeDisplayed: _agentsList,
                startDate: dateNotifier.getDate,
              ),
            );
          }
        },
      );
    });
  }
}
