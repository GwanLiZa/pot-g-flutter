import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_model.freezed.dart';
part 'token_model.g.dart';

@freezed
sealed class TokenModel with _$TokenModel {
  const factory TokenModel({
    required String accessToken,
    required String tokenType,
    required int expiresIn,
    required String refreshToken,
    required int refreshTokenExpiresIn,
    required String scope,
  }) = _TokenModel;

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
