part of 'navigator_cubit.dart';

@immutable
abstract class NavigatorState {}

class NavigatorInitial extends NavigatorState {}

class NavigatorRight extends NavigatorState {}

class NavigatorLeft extends NavigatorState {}
