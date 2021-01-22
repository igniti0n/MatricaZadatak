import 'package:flutter/material.dart';

import '../widgets/data_provider.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key key}) : super(key: key);

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
            padding: const EdgeInsets.all(8.0),
            child: DataProvider(
              isUpper: true,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
