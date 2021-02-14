import 'dart:developer';

import 'package:MatricaZadatak/data/respositories/agents_repository.dart';
import 'package:MatricaZadatak/data/services/data_provider_service.dart';
import 'package:MatricaZadatak/instance_creator.dart';
import 'package:MatricaZadatak/logic/cubit/navigator_cubit.dart';
import 'package:MatricaZadatak/logic/data_bloc/data_bloc.dart';
import 'package:MatricaZadatak/presentation/dash_board_builder.dart';
import 'package:MatricaZadatak/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onEnd(AnimationStatus status) {
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
    log("BUILD INTRO BUILDER");
    return isLoaded
        ? MultiProvider(providers: [
            BlocProvider(
              create: (_) => DataBloc(
                  Provider.of<AgentsRepository>(context, listen: false)),
            ),
            BlocProvider(
                create: (_) => NavigatorCubit(instanceCreator<AppRouter>())),
          ], child: DashBoardBuilder())
        : Center(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (ctx, _) => Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.grey[200],
                child: Opacity(
                  opacity: 1 * _animationController.value,
                  child: SizedBox(
                    height: 100,
                    width: 200,
                    child: Image.asset('assets/logos/logo.png'),
                  ),
                ),
              ),
            ),
          );
  }
}
