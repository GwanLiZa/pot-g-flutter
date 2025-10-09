import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pot_g/app/modules/core/domain/entities/fcm_request_entity.dart';

part 'fcm_request_model.freezed.dart';
part 'fcm_request_model.g.dart';

@freezed
sealed class FcmRequestModel
    with _$FcmRequestModel
    implements FcmRequestEntity {
  factory FcmRequestModel({
    required String fcmToken,
    required String os,
    required String version,
  }) = _FcmRequestModel;

  factory FcmRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FcmRequestModelFromJson(json);
}
