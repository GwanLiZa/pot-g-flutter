import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_request_model.freezed.dart';
part 'fcm_request_model.g.dart';

@freezed
sealed class FcmRequestModel with _$FcmRequestModel {
  factory FcmRequestModel({
    required String fcmToken,
    required String os,
    required String version,
  }) = _FcmRequestModel;

  factory FcmRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FcmRequestModelFromJson(json);
}
