import 'dart:async';

import 'package:MatricaZadatak/data/models/agent.dart';
import 'package:MatricaZadatak/data/respositories/agents_repository.dart';
import 'package:MatricaZadatak/data/services/data_provider_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final AgentsRepository agentsRepository;

  DataBloc(this.agentsRepository) : super(DataLoading()) {}

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if (event is LoadData) {
      yield DataLoading();
      try {
        final List<Agent> _up =
            await agentsRepository.getUpperAgents(event.date);
        final List<Agent> _down =
            await agentsRepository.getLowerAgents(event.date);

        yield DataLoaded(
          _up,
          _down,
        );
        print("Data loaded");
      } catch (error) {
        yield DataError('Error while loading data' + error.toString());
      }
    }
  }
}
