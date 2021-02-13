import 'package:MatricaZadatak/logic/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/agent.dart';
import '../widgets/data_table.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

class DashBoardSection extends StatelessWidget {
  final bool isUpper;

  final List<Agent> agentsToBeDisplayed;

  DashBoardSection({
    Key key,
    this.isUpper = true,
    @required this.agentsToBeDisplayed,
  })  : assert(agentsToBeDisplayed != null, "Provided Agents can't be null"),
        super(key: key);

  final AutoSizeGroup _textSizeGroup = new AutoSizeGroup();
  final AutoSizeGroup _headlineGroup = new AutoSizeGroup();

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
                isUpper
                    ? 'SASTANCI I PRODAJE PO AGENTU CC'
                    : 'SASTANCI I PRODAJE PO AGENTU PRODAJE',
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
                    child: AutoSizeText(
                      'PONEDJELJAK ${DateFormat('d.M.y').format(startDate)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                      minFontSize: 3,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      'UTORAK ${DateFormat('d.M.y').format(startDate.add(Duration(days: 1)))}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                      minFontSize: 3,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      'SRIJEDA ${DateFormat('d.M.y').format(startDate.add(Duration(days: 2)))}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                      minFontSize: 3,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      'ČETVRTAK ${DateFormat('d.M.y').format(startDate.add(Duration(days: 3)))}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                      minFontSize: 3,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      'PETAK ${DateFormat('d.M.y').format(startDate.add(Duration(days: 4)))}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                      minFontSize: 3,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      isUpper
                          ? 'UKUPNO'
                          : 'PONEDJELJAK ${DateFormat('d.M.y').format(startDate.add(Duration(days: 7)))}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey),
                      minFontSize: 3,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              // height: constraint.maxHeight * 0.9,
              // width: constraint.maxWidth,
              flex: 18,
              child: Row(
                children: [
                  Expanded(
                    flex: 10,
                    child: DataTableWidget(
                      displayNames: true,
                      textGroup: _textSizeGroup,
                      allAgentNamesInOrder: _allAgentNames,
                      headlineGroup: _headlineGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) => agent.date.day == startDate.day - 1)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      allAgentNamesInOrder: _allAgentNames,
                      headlineGroup: _headlineGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              startDate.add(Duration(days: 0)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      allAgentNamesInOrder: _allAgentNames,
                      headlineGroup: _headlineGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              startDate.add(Duration(days: 1)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      allAgentNamesInOrder: _allAgentNames,
                      headlineGroup: _headlineGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              startDate.add(Duration(days: 2)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      allAgentNamesInOrder: _allAgentNames,
                      headlineGroup: _headlineGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              startDate.add(Duration(days: 3)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      allAgentNamesInOrder: _allAgentNames,
                      headlineGroup: _headlineGroup,
                      isUpper: isUpper,
                      agentsForThisDate: isUpper
                          ? Provider.of<List<Agent>>(context, listen: false)
                          : agentsToBeDisplayed
                              .where((agent) =>
                                  agent.date.day ==
                                  startDate.add(Duration(days: 6)).day)
                              .toList()
                        ..sort((a, b) {
                          return a.name.codeUnits.first
                              .compareTo(b.name.codeUnits.first);
                        }),
                    ),
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
