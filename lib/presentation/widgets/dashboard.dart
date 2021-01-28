import 'package:flutter/material.dart';

import '../widgets/data_provider.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _mediaData = MediaQuery.of(context);
    final double _availableHeight = _mediaData.size.height -
        _mediaData.padding.top -
        _mediaData.padding.bottom -
        kToolbarHeight;

    return Column(
      children: [
        SizedBox(
          height: _availableHeight * 0.53,
          width: _mediaData.size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0, 2),
            child: DataProvider(
              isUpper: true,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0, 4),
            child: DataProvider(
              isUpper: false,
            ),
          ),
        ),
      ],
      // ),
    );
  }
}
