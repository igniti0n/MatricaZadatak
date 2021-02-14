import 'package:MatricaZadatak/constants.dart';
import 'package:MatricaZadatak/routing/router.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorState> {
  final AppRouter appRouter;
  View view = View.FullView;
  int day = 0;

  NavigatorCubit(this.appRouter) : super(NavigatorInitial());

  View get getView => view;

  void goRight() {
    print(day);
    print(view);
    if (view == View.SingleDay) {
      if (day == 4) {
        day = 0;
      } else {
        day++;
      }
      emit(NavigatorRight(day));
    }
  }

  void goLeft() {
    print(day);
    print(view);
    if (view == View.SingleDay) {
      if (day == 0) {
        day = 4;
      } else {
        day--;
      }

      emit(NavigatorLeft(day));
    }
  }

  void _changeView(String route) {
    switch (route) {
      case fullViewRoute:
        this.view = View.FullView;
        break;
      case onlyCCRoute:
        this.view = View.OnlyCC;
        break;
      case singleViewRoute:
        this.view = View.SingleDay;
        break;
      default:
    }
  }

  void goTo(String route) {
    _changeView(route);
    appRouter.goTo(route);
  }

  void goToReplace(String route) {
    _changeView(route);
    appRouter.goToReplace(route);
  }

  void goBack() {
    appRouter.goBack();
  }
}
