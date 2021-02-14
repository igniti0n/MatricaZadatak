import 'dart:developer';

import 'package:MatricaZadatak/instance_creator.dart';
import 'package:MatricaZadatak/logic/cubit/navigator_cubit.dart';
import 'package:MatricaZadatak/logic/data_bloc/data_bloc.dart';
import 'package:MatricaZadatak/presentation/widgets/dpad.dart';
import 'package:MatricaZadatak/routing/route_generator.dart';
import 'package:MatricaZadatak/routing/router.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../logic/date_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';

class DashBoardBuilder extends StatefulWidget {
  DashBoardBuilder({Key key}) : super(key: key);

  @override
  _DashBoardBuilderState createState() => _DashBoardBuilderState();
}

class _DashBoardBuilderState extends State<DashBoardBuilder>
    with SingleTickerProviderStateMixin {
  DateNotifier date;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);

    DateTime currDate = DateTime.now();
    while (currDate.weekday != 1) {
      currDate = currDate.subtract(Duration(days: 1));
    }
    date = new DateNotifier(currDate);
    BlocProvider.of<DataBloc>(context, listen: false)
        .add(LoadData(date: currDate));
  }

  void _onForward() {
    date.increaseStartDate();
    print("FORWARDS");
    BlocProvider.of<DataBloc>(context, listen: false)
        .add(LoadData(date: date.getDate));
  }

  void _onBackwards() {
    date.decreaseStartDate();
    print("BACKWARDS");
    BlocProvider.of<DataBloc>(context, listen: false)
        .add(LoadData(date: date.getDate));
  }

  void navigate(NavigatorCubit _navigatorCubit, String route, int index) {
    _tabController.animateTo(index);
    _navigatorCubit.goToReplace(route);
  }

  @override
  void dispose() {
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NavigatorCubit _navigatorCubit =
        BlocProvider.of<NavigatorCubit>(context, listen: false);
    log("BUILD DASH BOARD BUILDER ");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SalvisTV Dashboard'),
        actions: [
          SizedBox(
            width: 400,
            height: kToolbarHeight - 10,
            child: TabBar(
              controller: _tabController,
              isScrollable: false,
              automaticIndicatorColorAdjustment: true,
              overlayColor: MaterialStateProperty.all<Color>(Colors.green[900]),
              indicatorColor: Colors.green[800],
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 6,
              tabs: [
                DpadWidget(
                  child: TextButton(
                    child: Text("full"),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () =>
                        navigate(_navigatorCubit, fullViewRoute, 0),
                  ),
                  onClick: () => navigate(_navigatorCubit, fullViewRoute, 0),
                ),
                DpadWidget(
                  child: TextButton(
                    child: Text("only cc"),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () => navigate(_navigatorCubit, onlyCCRoute, 1),
                  ),
                  onClick: () => navigate(_navigatorCubit, onlyCCRoute, 1),
                ),
                DpadWidget(
                  child: TextButton(
                    child: Text("single"),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    onPressed: () =>
                        navigate(_navigatorCubit, singleViewRoute, 2),
                  ),
                  onClick: () => navigate(_navigatorCubit, singleViewRoute, 2),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
          ),
          DpadWidget(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: () {
                  _navigatorCubit.goLeft();
                  if (_navigatorCubit.view != View.SingleDay) _onBackwards();
                },
                focusColor: Colors.green[900],
              ),
              onClick: () {
                _navigatorCubit.goLeft();
                if (_navigatorCubit.view != View.SingleDay) _onBackwards();
              }),
          DpadWidget(
            child: IconButton(
              focusColor: Colors.green[900],
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              onPressed: () {
                _navigatorCubit.goRight();
                if (_navigatorCubit.view != View.SingleDay) _onForward();
              },
            ),
            onClick: () {
              _navigatorCubit.goRight();
              if (_navigatorCubit.view != View.SingleDay) _onForward();
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body: ChangeNotifierProvider<DateNotifier>(
        create: (ctx) => date,
        builder: (ctx, child) {
          return child;
        },
        child: SizedBox.expand(
          child: Navigator(
            key: instanceCreator<AppRouter>().navigatorKey,
            initialRoute: fullViewRoute,
            onGenerateRoute: onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
