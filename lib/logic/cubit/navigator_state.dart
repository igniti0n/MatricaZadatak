part of 'navigator_cubit.dart';

@immutable
abstract class NavigatorState {
  final int day;
  const NavigatorState(this.day);
}

class NavigatorInitial extends NavigatorState {
  final int day = 0;
  const NavigatorInitial() : super(0);
}

class NavigatorRight extends NavigatorState {
  const NavigatorRight(int day) : super(day);
}

class NavigatorLeft extends NavigatorState {
  const NavigatorLeft(int day) : super(day);
}
