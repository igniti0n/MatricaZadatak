import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/agent.dart';
import '../widgets/data_table.dart';

import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

class DashBoardSection extends StatelessWidget {
  final bool isUpper;
  final List<Agent> agentsToBeDisplayed;
  const DashBoardSection({
    Key key,
    this.isUpper = true,
    @required this.agentsToBeDisplayed,
  })  : assert(agentsToBeDisplayed != null, "Provided Agents can't be null"),
        super(key: key);

  static final List<String> _days = [
    'PONEDJELJAK',
    'UTORAK',
    'SRIJEDA',
    'ČETVRTAK',
    'PETAK',
  ];

  @override
  Widget build(BuildContext context) {
    final DateTime _startDate = Provider.of<DateTime>(context, listen: false);

    return LayoutBuilder(builder: (ctx, constraint) {
      log('SECTION CONSTRAINT:' + constraint.maxHeight.toString());
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
        child: Column(
          children: [
            Expanded(
              child: AutoSizeText(
                isUpper
                    ? 'SASTANCI I PRODAJE PO AGENTU CC (tjedan po tijedan i suma za mijesec)'
                    : 'SASTANCI I PRODAJE PO AGENTU PRODAJE (svaki tijedan od ponedjeljka do petka)',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(color: Colors.black),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    'PONEDJELJAK ${DateFormat.Md().format(_startDate)}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey),
                  ),
                  AutoSizeText(
                    'UTORAK ${DateFormat.Md().format(_startDate.add(Duration(days: 1)))}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey),
                  ),
                  AutoSizeText(
                    'SRIJEDA ${DateFormat.Md().format(_startDate.add(Duration(days: 2)))}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey),
                  ),
                  AutoSizeText(
                    'ČETVRTAK ${DateFormat.Md().format(_startDate.add(Duration(days: 3)))}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey),
                  ),
                  AutoSizeText(
                    'PETAK ${DateFormat.Md().format(_startDate.add(Duration(days: 4)))}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.8,
              width: constraint.maxWidth,
              child: Row(
                children: [
                  //TODO: SORT AGENTS BY NAME
                  Expanded(
                    child: DataTableWidget(
                      isUpper: isUpper,
                      currentDay: _days[0],
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 0)).day)
                          .toList(),
                      key: ValueKey('${_days[0]} + $isUpper'),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      isUpper: isUpper,
                      currentDay: _days[1],
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 1)).day)
                          .toList(),
                      key: ValueKey('${_days[1]} + $isUpper'),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      isUpper: isUpper,
                      currentDay: _days[2],
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 2)).day)
                          .toList(),
                      key: ValueKey('${_days[2]} + $isUpper'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.red)),
                      child: DataTableWidget(
                        isUpper: isUpper,
                        currentDay: _days[3],
                        agentsForThisDate: agentsToBeDisplayed
                            .where((agent) =>
                                agent.date.day ==
                                _startDate.add(Duration(days: 3)).day)
                            .toList(),
                        key: ValueKey('${_days[3]} + $isUpper'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      isUpper: isUpper,
                      currentDay: _days[4],
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 4)).day)
                          .toList(),
                      key: ValueKey('${_days[4]} + $isUpper'),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      isUpper: isUpper,
                      currentDay: _days[4],
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 4)).day)
                          .toList(),
                      key: ValueKey('${_days[4]} + $isUpper'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
    // final List<Agent> _agentsForThisTable = agentsToBeDisplayed
    //     .where((agent) =>
    //         agent.date.day == _startDate.add(Duration(days: index)).day)
    //     .toList();
    // return DataTableWidget(
    //   currentDay: _days[index],
    //   agentsForThisDate: _agentsForThisTable,
    //   key: ValueKey('${_days[index]} + $isUpper'),
    // );
  }
}
