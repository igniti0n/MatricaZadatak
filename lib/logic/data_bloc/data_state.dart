part of 'data_bloc.dart';

@immutable
abstract class DataState {
  final List<Agent> upperData;
  final List<Agent> lowerData;
  const DataState({this.lowerData, this.upperData});
}

class DataLoading extends DataState {
  const DataLoading() : super(lowerData: const [], upperData: const []);
}

class DataLoaded extends DataState {
  DataLoaded(List<Agent> upperData, List<Agent> lowerData)
      : super(lowerData: lowerData, upperData: upperData);
}

class DataError extends DataState {
  final String error;
  DataError(this.error) : super(lowerData: [], upperData: []);
}
