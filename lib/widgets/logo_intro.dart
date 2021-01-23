import 'package:flutter/material.dart';

class LogoIntro extends StatefulWidget {
  const LogoIntro({Key key}) : super(key: key);

  @override
  _LogoIntroState createState() => _LogoIntroState();
}

class _LogoIntroState extends State<LogoIntro>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: 1,
        duration: Duration(seconds: 2),
        curve: Curves.easeInCubic,
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset('assets/logos/logo.png'),
        ),
      ),
    );
  }
}
