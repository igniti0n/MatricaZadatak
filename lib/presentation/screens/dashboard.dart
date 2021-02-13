import 'dart:developer';

import 'package:MatricaZadatak/data/models/agent.dart';
import 'package:flutter/material.dart';

import '../widgets/data_provider.dart';

class DashBoard extends StatelessWidget {
  final List<Agent> upper;
  final List<Agent> lower;
  const DashBoard({this.lower, this.upper});

  @override
  Widget build(BuildContext context) {
    log("BUILD DASHBOARD ::::");
    final _mediaData = MediaQuery.of(context);
    final double _availableHeight = _mediaData.size.height -
        _mediaData.padding.top -
        _mediaData.padding.bottom -
        kToolbarHeight;

    print(upper.toString());
    return Column(
      children: [
        SizedBox(
          height: _availableHeight * 0.5,
          width: _mediaData.size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0, 2),
            child: DataProvider(
              agentsList: upper,
              isUpper: true,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0, 4),
            child: DataProvider(
              agentsList: lower,
              isUpper: false,
            ),
          ),
        ),
      ],
      // ),
    );
  }
}
