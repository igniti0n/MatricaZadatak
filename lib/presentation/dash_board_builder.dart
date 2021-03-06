import 'dart:async';
import 'dart:developer';

import 'package:MatricaZadatak/instance_creator.dart';
import 'package:MatricaZadatak/logic/cubit/navigator_cubit.dart';
import 'package:MatricaZadatak/logic/data_bloc/data_bloc.dart';
import 'package:MatricaZadatak/routing/route_generator.dart';
import 'package:MatricaZadatak/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:async/async.dart';

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
  FocusNode left = new FocusNode();

  RestartableTimer _refreshTimer;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);

    DateTime currDate = DateTime.now();
    while (currDate.weekday != 1) {
      currDate = currDate.subtract(Duration(days: 1));
      print("${currDate.toString()}");
    }
    date = new DateNotifier(currDate);
    BlocProvider.of<DataBloc>(context, listen: false)
        .add(LoadData(date: currDate));

    ///RESET SVAKE MINUTE
    _refreshTimer = new RestartableTimer(Duration(minutes: 1), () {
      BlocProvider.of<DataBloc>(context, listen: false)
          .add(LoadData(date: currDate));
      _refreshTimer.reset();
    });
  }

  void _onForward() {
    if (!(BlocProvider.of<DataBloc>(context, listen: false).state
        is DataLoading)) {
      date.increaseStartDate();
      BlocProvider.of<DataBloc>(context, listen: false)
          .add(LoadData(date: date.getDate));
    }
  }

  void _onBackwards() {
    if (!(BlocProvider.of<DataBloc>(context, listen: false).state
        is DataLoading)) {
      date.decreaseStartDate();
      BlocProvider.of<DataBloc>(context, listen: false)
          .add(LoadData(date: date.getDate));
    }
  }

  void navigate(NavigatorCubit _navigatorCubit, String route, int index) {
    _tabController.animateTo(index);

    _navigatorCubit.goToReplace(route);
  }

  @override
  void dispose() {
    date.dispose();
    _refreshTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(left);

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
                IconButton(
                  // focusNode: left,
                  focusColor: Colors.green[900],
                  icon: Text("1."),
                  // style: ButtonStyle(
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () => navigate(_navigatorCubit, fullViewRoute, 0),
                ),

                IconButton(
                  //focusNode: middle,
                  icon: Text("2."),
                  focusColor: Colors.green[900],
                  // style: ButtonStyle(
                  //     foregroundColor:
                  //         MaterialStateProperty.all<Color>(Colors.white)),
                  onPressed: () => navigate(_navigatorCubit, onlyCCRoute, 1),
                ),

                IconButton(
                  // focusNode: right,
                  icon: Text("3."),
                  focusColor: Colors.green[900],
                  // style: ButtonStyle(
                  //   foregroundColor:
                  //       MaterialStateProperty.all<Color>(Colors.white),
                  // ),
                  onPressed: () =>
                      navigate(_navigatorCubit, singleViewRoute, 2),
                ),

                // DpadWidget(
                //     child: IconButton(
                //       // focusNode: back,
                //       icon: Icon(Icons.arrow_back_ios),
                //       color: Colors.white,
                //       onPressed: () {
                //         _navigatorCubit.goLeft();
                //         if (_navigatorCubit.view != View.SingleDay)
                //           _onBackwards();
                //       },
                //       focusColor: Colors.green[900],
                //     ),
                //     onClick: () {
                //       _navigatorCubit.goLeft();
                //       if (_navigatorCubit.view != View.SingleDay) _onBackwards();
                //     }),
                // DpadWidget(
                //   child: IconButton(
                //     // focusNode: forward,
                //     focusColor: Colors.green[900],
                //     icon: Icon(
                //       Icons.arrow_forward_ios,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {
                //       _navigatorCubit.goRight();
                //       if (_navigatorCubit.view != View.SingleDay) _onForward();
                //     },
                //   ),
                //   onClick: () {
                //     _navigatorCubit.goRight();
                //     if (_navigatorCubit.view != View.SingleDay) _onForward();
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.greenAccent[100],
      body: FocusScope(
        canRequestFocus: false,
        autofocus: true,
        child: RawKeyboardListener(
          autofocus: true,
          focusNode: left,
          onKey: (RawKeyEvent event) {
            // if (widget.onFocus != null) widget.onFocus(isFocused);

            if (event is RawKeyDownEvent &&
                event.data is RawKeyEventDataAndroid) {
              RawKeyDownEvent rawKeyDownEvent = event;
              RawKeyEventDataAndroid rawKeyEventDataAndroid =
                  rawKeyDownEvent.data;
              print(rawKeyEventDataAndroid.keyCode);
              switch (rawKeyEventDataAndroid.keyCode) {
                case 8:
                  if (_navigatorCubit.getView != View.FullView)
                    navigate(_navigatorCubit, fullViewRoute, 0);
                  break;
                case 9:
                  if (_navigatorCubit.getView != View.OnlyCC)
                    navigate(_navigatorCubit, onlyCCRoute, 1);
                  break;
                case 10:
                  if (_navigatorCubit.getView != View.SingleDay)
                    navigate(_navigatorCubit, singleViewRoute, 2);
                  break;
                case 21:
                  _navigatorCubit.goLeft();
                  if (_navigatorCubit.view != View.SingleDay) _onBackwards();
                  break;
                case 22:
                  _navigatorCubit.goRight();
                  if (_navigatorCubit.view != View.SingleDay) _onForward();
                  break;
                default:
                  break;
              }
            }
          },
          child: ChangeNotifierProvider<DateNotifier>(
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
        ),
      ),
    );
  }
}
