import 'package:MatricaZadatak/logic/data_bloc/data_bloc.dart';
import 'package:MatricaZadatak/presentation/widgets/single_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/dashboard_section.dart';
import '../../data/models/agent.dart';

import 'package:provider/provider.dart';

class DataProvider extends StatelessWidget {
  final bool isUpper;
  final bool isOnly;
  final bool isSingle;

  DataProvider({
    Key key,
    @required this.isUpper,
    this.isOnly = false,
    this.isSingle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, int>> _sumeAgenata = {};

    return BlocBuilder<DataBloc, DataState>(
      builder: (_, state) {
        print("STATE CHANGED.");
        if (state is DataLoading) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            )),
          );
        } else if (state is DataLoaded) {
          print(state.upperData);
          return Provider<List<Agent>>(
            create: (ctx) => getSums(
                _sumeAgenata, isUpper ? state.upperData : state.lowerData),
            builder: (ctx, _) => isSingle
                ? SingleSection(agentsToBeDisplayed: state.upperData)
                : DashBoardSection(
                    isUpper: isUpper,
                    isOnly: isOnly,
                    agentsToBeDisplayed:
                        isUpper ? state.upperData : state.lowerData,
                  ),
          );
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(child: Text("Data failed to load.")),
          );
        }
      },
    );
  }

  List<Agent> getSums(
      Map<String, Map<String, int>> _sumeAgenata, List<Agent> agentsList) {
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
    return _listaSuma;
  }
}
