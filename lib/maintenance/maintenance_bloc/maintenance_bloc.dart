import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:ciclo_helper/maintenance/maintenance.dart';


class MaintenanceBloc extends Bloc<MaintenanceEvent, MaintenanceState> {
  MaintenanceDao _maintenanceDao = MaintenanceDao();

  @override
  MaintenanceState get initialState => MaintenanceLoading();

  @override
  Stream<MaintenanceState> mapEventToState(MaintenanceEvent event,) async* {
    if (event is LoadedMaintenance) {
      yield MaintenanceLoading();
      yield* _reloadMaintenance();
    }
    else if (event is AddedMaintenance) {
      // Loading indicator shouldn't be displayed while adding/updating/deleting
      // a single Maintenance from the database - we aren't yielding MaintenancesLoading().
      await _maintenanceDao.insert(
          event.maintenance);
      yield* _reloadMaintenance();
    }
    else if (event is UpdatedMaintenance) {
      final newMaintenance = event.maintenance;
      // Keeping the ID of the Maintenance the same
      newMaintenance.id = event.maintenance.id;
      await _maintenanceDao.update(newMaintenance);
      yield* _reloadMaintenance();
    }
    else if (event is DeletedMaintenance) {
      await _maintenanceDao.delete(event.maintenance);
      yield* _reloadMaintenance();
    }
  }

  Stream<MaintenanceState> _reloadMaintenance() async* {
    final maintenances = await _maintenanceDao.getAllSortedByData();
    // Yielding a state bundled with the Maintenances from the database.
    yield MaintenanceLoaded(maintenances);
  }
}

