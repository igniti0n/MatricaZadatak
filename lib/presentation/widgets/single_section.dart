import 'package:MatricaZadatak/logic/cubit/navigator_cubit.dart' as nCubit;
import 'package:MatricaZadatak/logic/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../data/models/agent.dart';
import '../widgets/data_table.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

class SingleSection extends StatelessWidget {
  final List<Agent> agentsToBeDisplayed;

  SingleSection({
    Key key,
    @required this.agentsToBeDisplayed,
  })  : assert(agentsToBeDisplayed != null, "Provided Agents can't be null"),
        super(key: key);

  final AutoSizeGroup _textSizeGroup = new AutoSizeGroup();
  final AutoSizeGroup _headlineGroup = new AutoSizeGroup();

  final List<String> _days = [
    "PONEDJELJAK",
    "UTORAK",
    "SRIJEDA",
    "ČETVRTAK",
    "PETAK"
  ];

  @override
  Widget build(BuildContext context) {
    final DateTime startDate =
        Provider.of<DateNotifier>(context, listen: false).getDate;

    //služio kao reference svakoj data table, da zan koji agent fali i da ih poreda
    final List<String> _allAgentNames = [];
    agentsToBeDisplayed.forEach((Agent a) {
      if (!_allAgentNames.contains(a.name)) {
        _allAgentNames.add(a.name);
      }
    });

    _allAgentNames.sort((a, b) {
      return a.codeUnits.first.compareTo(b.codeUnits.first);
    });

    return LayoutBuilder(builder: (ctx, constraint) {
      // log('SECTION CONSTRAINT:' + constraint.maxHeight.toString());
      return SizedBox(
        height: constraint.maxHeight,
        width: constraint.maxWidth,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: AutoSizeText(
                'SASTANCI I PRODAJE PO AGENTU CC',
                minFontSize: 3,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<nCubit.NavigatorCubit,
                          nCubit.NavigatorState>(
                        builder: (context, state) => AutoSizeText(
                          '${_days[state.day]} ${DateFormat('d.M.y').format(startDate.add(Duration(days: state.day)))}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.grey),
                          textAlign: TextAlign.center,
                          minFontSize: 3,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        'UKUPNO',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey),
                        minFontSize: 3,
                      ),
                    ),
                  ],
                )),
            Flexible(
              flex: 18,
              child: Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  BlocBuilder<nCubit.NavigatorCubit, nCubit.NavigatorState>(
                      buildWhen: (a, b) => a.day != b.day,
                      builder: (context, state) {
                        List<Agent> agentsToDisplay = [];
                        agentsToDisplay = agentsToBeDisplayed
                            .where((agent) =>
                                agent.date.day ==
                                startDate.add(Duration(days: state.day)).day -
                                    1)
                            .toList();

                        return Expanded(
                          flex: 5,
                          child: DataTableWidget(
                            isOnly: true,
                            displayNames: true,
                            textGroup: _textSizeGroup,
                            allAgentNamesInOrder: _allAgentNames,
                            headlineGroup: _headlineGroup,
                            agentsForThisDate: agentsToDisplay
                              ..sort((a, b) {
                                return a.name.codeUnits.first
                                    .compareTo(b.name.codeUnits.first);
                              }),
                          ),
                        );
                      }),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 4,
                    child: DataTableWidget(
                        textGroup: _textSizeGroup,
                        allAgentNamesInOrder: _allAgentNames,
                        headlineGroup: _headlineGroup,
                        agentsForThisDate:
                            Provider.of<List<Agent>>(context, listen: false)),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
