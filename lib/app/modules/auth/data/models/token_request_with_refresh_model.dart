import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_request_with_refresh_model.freezed.dart';
part 'token_request_with_refresh_model.g.dart';

@freezed
sealed class TokenRequestWithRefreshModel with _$TokenRequestWithRefreshModel {
  const factory TokenRequestWithRefreshModel({
    @Default('refresh_token') String grantType,
    required String refreshToken,
    required String clientId,
    required String nonce,
  }) = _TokenRequestWithRefreshModel;

  factory TokenRequestWithRefreshModel.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestWithRefreshModelFromJson(json);
}
