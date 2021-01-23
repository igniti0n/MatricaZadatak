import 'package:MatricaZadatak/widgets/logo_intro.dart';
import 'package:flutter/material.dart';

import '../widgets/data_provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool _finishedIntro = false;

  @override
  Widget build(BuildContext context) {
    final _mediaData = MediaQuery.of(context);
    final double _availableHeight = _mediaData.size.height -
        _mediaData.padding.top -
        _mediaData.padding.bottom -
        kToolbarHeight;

    return !_finishedIntro
        ? LogoIntro()
        : Column(
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
