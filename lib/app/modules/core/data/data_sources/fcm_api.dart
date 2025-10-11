import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pot_g/app/modules/core/data/dio/pot_dio.dart';
import 'package:pot_g/app/modules/core/data/models/fcm_request_model.dart';
import 'package:retrofit/retrofit.dart';

part 'fcm_api.g.dart';

@injectable
@RestApi(baseUrl: '/api/v1/user/')
abstract class FcmApi {
  @factoryMethod
  factory FcmApi(PotDio dio) = _FcmApi;

  @POST('device')
  Future<void> fcm(@Body() FcmRequestModel request);
}
