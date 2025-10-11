import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pot_g/app/modules/core/data/dio/pot_dio.dart';
import 'package:pot_g/app/modules/list/data/model/pot_list_model.dart';
import 'package:retrofit/retrofit.dart';

part 'pot_list_api.g.dart';

@injectable
@RestApi(baseUrl: '/api/v1/discovery/')
abstract class PotListApi {
  @factoryMethod
  factory PotListApi(PotDio dio) = _PotListApi;

  @GET('list')
  Future<PotListModel> getList({
    @Query('route_id') String? routeId,
    @Query('starts_at') DateTime? startsAt,
    @Query('ends_at') DateTime? endsAt,
    @Query('offset') required int offset,
    @Query('limit') required int limit,
  });
}
