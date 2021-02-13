import 'package:MatricaZadatak/presentation/widgets/data_provider.dart';
import 'package:flutter/material.dart';

class TopView extends StatelessWidget {
  const TopView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0, 4),
        child: DataProvider(
          isUpper: true,
        ),
      ),
    );
  }
}
