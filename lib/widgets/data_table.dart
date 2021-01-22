import 'dart:developer' show log;

import 'package:flutter/material.dart';

import '../models/agent.dart';

import 'package:auto_size_text/auto_size_text.dart';

//12 REDOVA +1 UKUPNO, 8 REDOVA + 1 UKUPNO

class DataTableWidget extends StatelessWidget {
  final List<Agent> agentsForThisDate;
  final String currentDay;
  final bool isUpper;
  DataTableWidget(
      {Key key,
      this.agentsForThisDate,
      @required this.currentDay,
      this.isUpper = true})
      : super(key: key);

  List<Widget> _tableRows = new List<Widget>();

  Widget _createDataRow(ThemeData theme, int index, double spacing) {
    return Expanded(
      child: Row(children: [
        Expanded(
          child: AutoSizeText(
            agentsForThisDate[index].name,
            style: theme.textTheme.bodyText1,
            textAlign: TextAlign.center,
            minFontSize: 3,
          ),
        ),

        // SizedBox(
        //   width: spacing,
        // ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              color: Colors.blue[800],
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                '${agentsForThisDate[index].agreedAppointments}',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
                minFontSize: 3,
              ),
            ),
          ),
        ),
        // SizedBox(
        //   width: spacing,
        // ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              color: Colors.blue,
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                '${agentsForThisDate[index].sales}',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
                minFontSize: 3,
              ),
            ),
          ),
        ),
        // Expanded(child: Container()),
        // SizedBox(
        //   width: spacing,
        // ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              color: Colors.blue,
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                '${agentsForThisDate[index].leads}',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
                minFontSize: 3,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _createEmptyDataRow(ThemeData theme) {
    return Expanded(
      child: Row(children: [
        Expanded(
          child: AutoSizeText(
            '-',
            style: theme.textTheme.bodyText1,
            textAlign: TextAlign.center,
            minFontSize: 3,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              color: Colors.blue[800],
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                '-',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
                minFontSize: 3,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              color: Colors.blue,
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                '-',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
                minFontSize: 3,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              color: Colors.blue,
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                '-',
                style: theme.textTheme.bodyText1,
                textAlign: TextAlign.center,
                minFontSize: 3,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    final Size _availableSize = MediaQuery.of(context).size;

    final Widget _headlineText = Row(children: [
      Expanded(
        child: AutoSizeText(
          'Agent',
          style: _theme.textTheme.bodyText1
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
          minFontSize: 3,
        ),
      ),
      Expanded(
        child: AutoSizeText(
          'Dogovoreni Sastanci',
          style: _theme.textTheme.bodyText1
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
          minFontSize: 3,
        ),
      ),
      Expanded(
        child: AutoSizeText(
          'Prodaja',
          style: _theme.textTheme.bodyText1
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
          minFontSize: 3,
        ),
      ),
      Expanded(
        child: AutoSizeText(
          'Dogovoreni \n Lead-ovi',
          style: _theme.textTheme.bodyText1
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
          minFontSize: 2,
        ),
      ),
    ]);

    final int _rowDataLimit = isUpper ? 12 : 8;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        for (int i = 0; i < _rowDataLimit; i++) {
          if (i < agentsForThisDate.length) {
            _tableRows
                .add(_createDataRow(_theme, i, constraints.maxWidth * 0.1));
          } else {
            _tableRows.add(_createEmptyDataRow(_theme));
          }
        }

        log(constraints.maxHeight.toString());
        log(constraints.maxWidth.toString());
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _headlineText,
            ..._tableRows,
            if (!isUpper)
              Expanded(
                child: Container(),
              ),
            if (!isUpper)
              Expanded(
                child: Container(),
              ),
          ],
        );
      },
    );
  }
}
