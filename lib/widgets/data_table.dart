import 'dart:developer' show log;

import 'package:flutter/material.dart';

import '../models/agent.dart';

import 'package:auto_size_text/auto_size_text.dart';

//12 REDOVA +1 UKUPNO, 8 REDOVA + 1 UKUPNO

class DataTableWidget extends StatefulWidget {
  final List<Agent> agentsForThisDate;

  final AutoSizeGroup textGroup;
  final bool isUpper;
  DataTableWidget({
    Key key,
    this.agentsForThisDate,
    this.isUpper = true,
    @required this.textGroup,
  }) : super(key: key);

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget>
    with SingleTickerProviderStateMixin {
  final List<String> _emptyData = ['-', '-', '-', '-'];

  List<Widget> _tableRows = new List<Widget>();
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _createRow(ThemeData theme, List<String> text, double spacing,
      {bool isFinal = false}) {
    return Expanded(
      child: Row(children: [
        Expanded(
          child: AutoSizeText(
            text[0],
            style: isFinal
                ? theme.textTheme.bodyText1
                    .copyWith(fontWeight: FontWeight.w900)
                : theme.textTheme.bodyText1,
            group: widget.textGroup,
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
              color: isFinal ? Colors.green : Colors.blue[800],
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                text[1],
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
              color: isFinal ? Colors.green : Colors.blue,
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                text[2],
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
              color: isFinal ? Colors.green : Colors.blue,
              height: double.infinity,
              // width: double.minPositive,
              alignment: Alignment.center,
              child: AutoSizeText(
                text[3],
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
    // final Size _availableSize = MediaQuery.of(context).size;

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

    final int _rowDataLimit = widget.isUpper ? 12 : 8;
    List<String> _agentData;
    List<String> _ukupno = [
      'UKUPNO',
    ];

    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) => Opacity(
        opacity: _animationController.value,
        child: child,
      ),
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          int _sumAgreed = 0, _sumSales = 0, _sumLeads = 0;

          widget.agentsForThisDate.forEach((agent) {
            _sumAgreed += agent.agreedAppointments;
            _sumSales += agent.sales;
            _sumLeads += agent.leads;
          });

          _ukupno.add(_sumAgreed.toString());
          _ukupno.add(_sumSales.toString());
          _ukupno.add(_sumLeads.toString());

          for (int i = 0; i < _rowDataLimit; i++) {
            if (i < widget.agentsForThisDate.length) {
              _agentData = [
                ' ${widget.agentsForThisDate[i].name}',
                '${widget.agentsForThisDate[i].agreedAppointments}',
                '${widget.agentsForThisDate[i].sales}',
                '${widget.agentsForThisDate[i].leads}',
              ];
              _tableRows.add(
                  _createRow(_theme, _agentData, constraints.maxWidth * 0.1));
            } else {
              _tableRows.add(
                  _createRow(_theme, _emptyData, constraints.maxWidth * 0.1));
            }
          }

          _tableRows.add(
            _createRow(_theme, _ukupno, constraints.maxWidth * 0.1,
                isFinal: true),
          );

          log(constraints.maxHeight.toString());
          log(constraints.maxWidth.toString());
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _headlineText,
                    ..._tableRows,
                    if (!widget.isUpper)
                      Expanded(
                        child: Container(),
                      ),
                    if (!widget.isUpper)
                      Expanded(
                        child: Container(),
                      ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 10,
                  ),
                  Container(
                    width: 2,
                    height: widget.isUpper
                        ? constraints.maxHeight * 0.9
                        : constraints.maxHeight * 0.7,
                    color: Colors.grey[700],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// Widget _createDataRow(ThemeData theme, int index, double spacing) {
//   return Expanded(
//     child: Row(children: [
//       Expanded(
//         child: AutoSizeText(
//           agentsForThisDate[index].name,
//           style: theme.textTheme.bodyText1,
//           textAlign: TextAlign.center,
//           minFontSize: 3,
//         ),
//       ),

//       // SizedBox(
//       //   width: spacing,
//       // ),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Container(
//             color: Colors.blue[800],
//             height: double.infinity,
//             // width: double.minPositive,
//             alignment: Alignment.center,
//             child: AutoSizeText(
//               '${agentsForThisDate[index].agreedAppointments}',
//               style: theme.textTheme.bodyText1,
//               textAlign: TextAlign.center,
//               minFontSize: 3,
//             ),
//           ),
//         ),
//       ),
//       // SizedBox(
//       //   width: spacing,
//       // ),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Container(
//             color: Colors.blue,
//             height: double.infinity,
//             // width: double.minPositive,
//             alignment: Alignment.center,
//             child: AutoSizeText(
//               '${agentsForThisDate[index].sales}',
//               style: theme.textTheme.bodyText1,
//               textAlign: TextAlign.center,
//               minFontSize: 3,
//             ),
//           ),
//         ),
//       ),
//       // Expanded(child: Container()),
//       // SizedBox(
//       //   width: spacing,
//       // ),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Container(
//             color: Colors.blue,
//             height: double.infinity,
//             // width: double.minPositive,
//             alignment: Alignment.center,
//             child: AutoSizeText(
//               '${agentsForThisDate[index].leads}',
//               style: theme.textTheme.bodyText1,
//               textAlign: TextAlign.center,
//               minFontSize: 3,
//             ),
//           ),
//         ),
//       ),
//     ]),
//   );
// }

// Widget _createEmptyDataRow(ThemeData theme) {
//   return Expanded(
//     child: Row(children: [
//       Expanded(
//         child: AutoSizeText(
//           '-',
//           style: theme.textTheme.bodyText1,
//           textAlign: TextAlign.center,
//           minFontSize: 3,
//         ),
//       ),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Container(
//             color: Colors.blue[800],
//             height: double.infinity,
//             // width: double.minPositive,
//             alignment: Alignment.center,
//             child: AutoSizeText(
//               '-',
//               style: theme.textTheme.bodyText1,
//               textAlign: TextAlign.center,
//               minFontSize: 3,
//             ),
//           ),
//         ),
//       ),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Container(
//             color: Colors.blue,
//             height: double.infinity,
//             // width: double.minPositive,
//             alignment: Alignment.center,
//             child: AutoSizeText(
//               '-',
//               style: theme.textTheme.bodyText1,
//               textAlign: TextAlign.center,
//               minFontSize: 3,
//             ),
//           ),
//         ),
//       ),
//       Expanded(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 5),
//           child: Container(
//             color: Colors.blue,
//             height: double.infinity,
//             // width: double.minPositive,
//             alignment: Alignment.center,
//             child: AutoSizeText(
//               '-',
//               style: theme.textTheme.bodyText1,
//               textAlign: TextAlign.center,
//               minFontSize: 3,
//             ),
//           ),
//         ),
//       ),
//     ]),
//   );
// }
