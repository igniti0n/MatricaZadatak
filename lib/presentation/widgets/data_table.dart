import 'package:flutter/material.dart';

import '../../data/models/agent.dart';

import 'package:auto_size_text/auto_size_text.dart';

//12 REDOVA +1 UKUPNO, 8 REDOVA + 1 UKUPNO

class DataTableWidget extends StatefulWidget {
  final List<Agent> agentsForThisDate;
  final AutoSizeGroup headlineGroup;
  final AutoSizeGroup textGroup;
  final List<String> allAgentNamesInOrder;
  final bool isUpper;
  final bool isOnly;
  final bool displayNames;
  DataTableWidget({
    Key key,
    this.agentsForThisDate,
    this.isUpper = true,
    this.isOnly = false,
    this.headlineGroup,
    this.allAgentNamesInOrder,
    this.displayNames = false,
    @required this.textGroup,
  }) : super(key: key);

  @override
  _DataTableWidgetState createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget>
    with SingleTickerProviderStateMixin {
  final List<String> _emptyData = ['-', '-', '-', '-'];

  List<Widget> _tableRows = [];
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
      {bool isFinal = false, String agentName = ""}) {
    final flex1 = widget.isOnly ? 6 : 1;
    final flex2 = widget.isOnly ? 4 : 1;
    return Expanded(
      child: Row(
        children: [
          if (widget.displayNames)
            Expanded(
              flex: flex1,
              child: Container(
                decoration: BoxDecoration(
                  border: isFinal
                      ? Border(top: BorderSide(color: Colors.black, width: 1))
                      : null,
                ),
                child: AutoSizeText(
                  isFinal ? "UKUPNO" : agentName,
                  style: isFinal
                      ? theme.textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.w900,
                          // decoration: TextDecoration.underline,
                        )
                      : theme.textTheme.bodyText1,
                  group: widget.textGroup,
                  textAlign: TextAlign.left,
                  minFontSize: 1,
                ),
              ),
            ),
          Expanded(
            flex: flex2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                // color: isFinal ? Colors.green : Colors.blue[800],
                height: double.infinity,
                // width: double.minPositive,
                alignment: Alignment.center,
                child: AutoSizeText(
                  text[1],
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                  minFontSize: 1,
                ),
              ),
            ),
          ),
          Expanded(
            flex: flex2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                //color: isFinal ? Colors.green : Colors.blue,
                height: double.infinity,
                // width: double.minPositive,
                alignment: Alignment.center,
                child: AutoSizeText(
                  text[2],
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                  minFontSize: 1,
                ),
              ),
            ),
          ),
          Expanded(
            flex: flex2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                // color: isFinal ? Colors.green : Colors.blue,
                height: double.infinity,
                // width: double.minPositive,
                alignment: Alignment.center,
                child: AutoSizeText(
                  text[3],
                  style: theme.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                  minFontSize: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    // final Size _availableSize = MediaQuery.of(context).size;

    final TextStyle _headlineStyle = _theme.textTheme.bodyText1.copyWith(
        fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20);

    final Widget _headlineText = Expanded(
      child: Row(children: [
        if (widget.displayNames)
          Expanded(
            child: AutoSizeText(
              'Agent',
              style: _headlineStyle,
              textAlign: TextAlign.center,
              group: widget.headlineGroup,
              maxLines: 1,
              minFontSize: 1,
            ),
          ),
        if (widget.displayNames) Spacer(),
        Expanded(
          child: AutoSizeText(
            'Sastanci',
            style: _headlineStyle,
            maxLines: 1,
            group: widget.headlineGroup,
            textAlign: widget.displayNames ? TextAlign.left : TextAlign.center,
            maxFontSize: 10,
            minFontSize: 1,
          ),
        ),
        Expanded(
          child: AutoSizeText(
            'Prodaja',
            style: _headlineStyle,
            group: widget.headlineGroup,
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 1,
          ),
        ),
        Expanded(
          child: AutoSizeText(
            'Lead-ovi',
            style: _headlineStyle,
            maxLines: 1,
            group: widget.headlineGroup,
            textAlign: TextAlign.center,
            minFontSize: 1,
          ),
        ),
      ]),
    );

    final int _rowDataLimit = widget.isUpper ? 10 : 8;
    List<String> _agentData;
    List<String> _ukupno = [
      'UKUPNO',
    ];
    print("BUILDING THIS");
    print(widget.agentsForThisDate.length);
    _tableRows = [];
    return
        // AnimatedBuilder(
        //   animation: _animationController,
        //   builder: (ctx, child) => Opacity(
        //     opacity: _animationController.value,
        //     child: child,
        //   ),
        //   child:
        LayoutBuilder(
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
          //    print("DATA TABLE NAMES + ${widget.agentsForThisDate}" +
          //    widget.allAgentNamesInOrder.toString());
          if (i < widget.allAgentNamesInOrder.length) {
            //AKO TRENUTNI AGENT IMA UNOS U OVOM DATUMU
            if (widget.agentsForThisDate.any((Agent agent) =>
                agent.name == widget.allAgentNamesInOrder[i])) {
              //nadji agenta
              int _agentIndex = widget.agentsForThisDate.indexWhere(
                  (Agent agent) =>
                      agent.name == widget.allAgentNamesInOrder[i]);
              _agentData = [
                ' ${widget.agentsForThisDate[_agentIndex].name}',
                '${widget.agentsForThisDate[_agentIndex].agreedAppointments}',
                '${widget.agentsForThisDate[_agentIndex].sales}',
                '${widget.agentsForThisDate[_agentIndex].leads}',
              ];
              _tableRows.add(_createRow(
                  _theme, _agentData, constraints.maxWidth * 0.1,
                  agentName: widget.allAgentNamesInOrder[i]));
            } else {
              _tableRows.add(_createRow(
                  _theme, _emptyData, constraints.maxWidth * 0.1,
                  agentName: widget.allAgentNamesInOrder[i]));
            }
          } else {
            _tableRows.add(
                _createRow(_theme, _emptyData, constraints.maxWidth * 0.1));
          }
        }

        _tableRows.add(
          _createRow(_theme, _ukupno, constraints.maxWidth * 0.1,
              isFinal: true),
        );

        // log(constraints.maxHeight.toString());
        // log(constraints.maxWidth.toString());
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
                  height: 25,
                ),
                Container(
                  width: 2,
                  height: widget.isUpper
                      ? constraints.maxHeight * 0.8
                      : constraints.maxHeight * 0.75,
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
      // ),
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
