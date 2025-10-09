import 'package:pot_g/app/modules/chat/data/models/my_pots_model.dart';
import 'package:pot_g/app/modules/core/data/models/pot_detail_model.dart';

abstract class PotDetailRepository {
  Future<MyPotsModel> getMyPotList();
}
