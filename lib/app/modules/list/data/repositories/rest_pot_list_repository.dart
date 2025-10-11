import 'package:injectable/injectable.dart';
import 'package:pot_g/app/modules/core/domain/entities/pot_summary_entity.dart';
import 'package:pot_g/app/modules/core/domain/entities/route_entity.dart';
import 'package:pot_g/app/modules/core/domain/repositories/pot_list_repository.dart';
import 'package:pot_g/app/modules/list/data/data_source/remote/pot_list_api.dart';

@Injectable(as: PotListRepository)
class RestPotListRepository implements PotListRepository {
  final PotListApi _api;

  RestPotListRepository(this._api);

  @override
  Future<List<PotSummaryEntity>> getPotList({
    DateTime? date,
    RouteEntity? route,
  }) async {
    final potListModel = await _api.getList(
      routeId: route?.id,
      startsAt:
          date != null
              ? DateTime(date.year, date.month, date.day, 0, 0, 0, 0)
              : null,
      endsAt:
          date != null
              ? DateTime(date.year, date.month, date.day, 23, 59, 59, 999)
              : null,
      offset: 0,
      limit: 10,
    );

    return potListModel.list;
  }
}
