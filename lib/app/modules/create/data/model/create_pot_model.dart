import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_pot_model.freezed.dart';
part 'create_pot_model.g.dart';

@freezed
sealed class CreatePotModel with _$CreatePotModel {
  const factory CreatePotModel({
    @JsonKey(name: 'route_id') required String routeId,
    @JsonKey(name: 'starts_at') required DateTime startsAt,
    @JsonKey(name: 'ends_at') required DateTime endsAt,
    @JsonKey(name: 'max_count') required int maxCount,
  }) = _CreatePotModel;

  factory CreatePotModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePotModelFromJson(json);
}
