import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pot_g/app/modules/core/data/dio/pot_dio.dart';
import 'package:pot_g/app/modules/core/data/models/route_model.dart';
import 'package:retrofit/retrofit.dart';

part 'route_list_api.g.dart';

@injectable
@RestApi(baseUrl: '/api/v1/discovery/')
abstract class RouteListApi {
  @factoryMethod
  factory RouteListApi(PotDio dio) = _RouteListApi;

  @GET('route')
  Future<List<RouteModel>> getRouteList();
}
