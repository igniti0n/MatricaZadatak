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

  @override
  Widget build(BuildContext context) {
    final DateTime _startDate = Provider.of<DateTime>(context, listen: false);
    final AutoSizeGroup _textSizeGroup = new AutoSizeGroup();

    return LayoutBuilder(builder: (ctx, constraint) {
      // log('SECTION CONSTRAINT:' + constraint.maxHeight.toString());
      return SizedBox(
        height: constraint.maxHeight,
        width: constraint.maxWidth,
        child: Column(
          children: [
            SizedBox(
              height: constraint.maxHeight * 0.05,
              width: constraint.maxWidth,
              child: AutoSizeText(
                isUpper
                    ? 'SASTANCI I PRODAJE PO AGENTU CC (tjedan po tijedan i suma za mijesec)'
                    : 'SASTANCI I PRODAJE PO AGENTU PRODAJE (svaki tijedan od ponedjeljka do petka)',
                minFontSize: 3,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: constraint.maxHeight * 0.05,
              width: constraint.maxWidth,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      'PONEDJELJAK ${DateFormat('d-M').format(_startDate)}',
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
                      'UTORAK ${DateFormat('d-M').format(_startDate.add(Duration(days: 1)))}',
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
                      'SRIJEDA ${DateFormat('d-M').format(_startDate.add(Duration(days: 2)))}',
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
                      'ČETVRTAK ${DateFormat('d-M').format(_startDate.add(Duration(days: 3)))}',
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
                      'PETAK ${DateFormat('d-M').format(_startDate.add(Duration(days: 4)))}',
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
                          : 'PONEDJELJAK ${DateFormat('d-M').format(_startDate.add(Duration(days: 7)))}',
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
            SizedBox(
              height: constraint.maxHeight * 0.9,
              width: constraint.maxWidth,
              child: Row(
                children: [
                  //TODO: SORT AGENTS BY NAME
                  Expanded(
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 0)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 1)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 2)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 3)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      isUpper: isUpper,
                      agentsForThisDate: agentsToBeDisplayed
                          .where((agent) =>
                              agent.date.day ==
                              _startDate.add(Duration(days: 4)).day)
                          .toList()
                            ..sort((a, b) {
                              return a.name.codeUnits.first
                                  .compareTo(b.name.codeUnits.first);
                            }),
                    ),
                  ),
                  Expanded(
                    child: DataTableWidget(
                      textGroup: _textSizeGroup,
                      isUpper: isUpper,
                      agentsForThisDate: isUpper
                          ? []
                          : agentsToBeDisplayed
                              .where((agent) =>
                                  agent.date.day ==
                                  _startDate.add(Duration(days: 7)).day)
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
