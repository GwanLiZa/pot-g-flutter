import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pot_g/app/modules/core/data/models/pot_detail_model.dart';

part 'my_pots_model.freezed.dart';
part 'my_pots_model.g.dart';

@freezed
sealed class MyPotsModel with _$MyPotsModel {
  factory MyPotsModel({
    @Default([]) List<PotDetailModel> potList,
    @Default([]) List<PotDetailModel> archivedPotList,
  }) = _MyPotsModel;

  factory MyPotsModel.fromJson(Map<String, dynamic> json) =>
      _$MyPotsModelFromJson(json);
}
