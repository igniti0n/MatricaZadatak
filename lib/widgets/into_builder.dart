import 'package:flutter/material.dart';

import '../widgets/dashboard.dart';

class IntroBuilder extends StatefulWidget {
  const IntroBuilder({Key key}) : super(key: key);

  @override
  _IntroBuilderState createState() => _IntroBuilderState();
}

class _IntroBuilderState extends State<IntroBuilder>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
        vsync: this,
        duration: Duration(
          seconds: 2,
        ))
      ..addStatusListener(_onEnd);
    _animationController.forward();
  }

  void _onEnd(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? DashBoard()
        : Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (ctx, _) => Opacity(
                opacity: 1 * _animationController.value,
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset('assets/logos/logo.png'),
                ),
              ),
            ),
          );
  }
}
