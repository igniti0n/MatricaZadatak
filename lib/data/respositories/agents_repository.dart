import 'package:MatricaZadatak/data/models/agent.dart';
import 'package:MatricaZadatak/data/services/data_provider_service.dart';
import 'package:flutter/cupertino.dart';

class AgentsRepository {
  final DataProviderService dataProviderService;
  AgentsRepository(this.dataProviderService)
      : assert(dataProviderService != null);

  Future<List<Agent>> getUpperAgents(DateTime startDate) async {
    return await dataProviderService.getData(startDate, true);
  }

  Future<List<Agent>> getLowerAgents(DateTime startDate) async {
    return await dataProviderService.getData(startDate, false);
  }
}
