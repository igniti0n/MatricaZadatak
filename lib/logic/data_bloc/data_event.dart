part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

class LoadData extends DataEvent {
  final DateTime date;
  LoadData({this.date});
}
