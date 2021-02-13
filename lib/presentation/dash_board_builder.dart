import 'dart:developer';

import 'package:MatricaZadatak/data/models/agent.dart';
import 'package:MatricaZadatak/data/services/data_provider_service.dart';
import 'package:MatricaZadatak/logic/data_bloc/data_bloc.dart';
import 'package:MatricaZadatak/presentation/screens/dashboard.dart';
import 'package:MatricaZadatak/presentation/widgets/dpad.dart';
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

  View _currentView = View.FullView;

  void _onForward() {
    date.increaseStartDate();
    BlocProvider.of<DataBloc>(context, listen: false)
        .add(LoadData(date: date.getDate));
  }

  void _onBackwards() {
    date.decreaseStartDate();
    BlocProvider.of<DataBloc>(context, listen: false)
        .add(LoadData(date: date.getDate));
  }

  void _setView(View view) {
    setState(() {
      _currentView = view;
    });
  }

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

  @override
  void dispose() {
    date.dispose();
    super.dispose();
  }

  Widget buildBody(View view, List<Agent> upper, List<Agent> lower) {
    print(upper);
    print("!!!!!!!!!!!!!!!!!!");
    print(lower);
    return DashBoard(
      upper: upper,
      lower: lower,
    );
  }

  @override
  Widget build(BuildContext context) {
    log("BUILD DASH BOARD BUILDER ");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('SalvisTV Dashboard'),
        actions: [
          // DpadWidget(
          //     child: TextButton(
          //       onPressed: () => _setView(View.OnlyCC),
          //       style: ButtonStyle(),
          //       child: Text("Top View"),
          //     ),
          //     onClick: _onBackwards),
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
                  child: Text(
                    "full",
                  ),
                  onClick: () => _setView(View.FullView),
                ),
                DpadWidget(
                  child: Text("only cc"),
                  onClick: () => _setView(View.OnlyCC),
                ),
                DpadWidget(
                  child: Text("single"),
                  onClick: () => _setView(View.SingleDay),
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
                onPressed: _onBackwards,
                focusColor: Colors.green[900],
              ),
              onClick: _onBackwards),
          DpadWidget(
              child: IconButton(
                focusColor: Colors.green[900],
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
                onPressed: _onForward,
              ),
              onClick: _onForward),
        ],
      ),
      backgroundColor: Colors.grey[300],
      body:
          //  FutureBuilder(
          //   future: Provider.of<DataProviderService>(context, listen: false)
          //       .getData(date.getDate, true),
          //   builder: (ctx, _) => Container(
          //     width: double.infinity,
          //     height: double.infinity,
          //     child: Center(
          //         child: CircularProgressIndicator(
          //       strokeWidth: 2,
          //     )),
          //   ),
          // ),
          ChangeNotifierProvider(
              create: (_) => date,
              builder: (_, __) => BlocBuilder<DataBloc, DataState>(
                    builder: (_, state) {
                      print("STATE CHANGED.");
                      if (state is DataLoading) {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(
                              child: CircularProgressIndicator(
                            strokeWidth: 2,
                          )),
                        );
                      } else if (state is DataLoaded) {
                        return buildBody(
                            _currentView, state.upperData, state.lowerData);
                      } else {
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: Center(child: Text("Data failed to load.")),
                        );
                      }
                    },
                  )),
    );
  }
}
