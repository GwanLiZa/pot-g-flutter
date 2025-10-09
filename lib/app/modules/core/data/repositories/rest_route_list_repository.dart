import 'package:injectable/injectable.dart';
import 'package:pot_g/app/modules/core/data/data_sources/route_list_api.dart';
import 'package:pot_g/app/modules/core/data/models/route_model.dart';
import 'package:pot_g/app/modules/core/domain/repositories/route_list_repository.dart';

@Injectable(as: RouteListRepository)
class RestRouteListRepository implements RouteListRepository {
  final RouteListApi _api;

  RestRouteListRepository(this._api);

  @override
  Future<List<RouteModel>> getRouteList() async {
    final routeList = await _api.getRouteList();
    return routeList;
  }
}
