import 'package:pot_g/app/modules/chat/domain/enums/pot_status.dart';
import 'package:pot_g/app/modules/core/domain/entities/pot_summary_entity.dart';

abstract class PotDetailEntity extends PotSummaryEntity {
  PotDetailEntity({
    required super.id,
    required super.route,
    required super.startsAt,
    required super.endsAt,
    required super.current,
    required super.total,
  });

  DateTime? get departureTime;
  PotStatus get status;
  int? get accountingRequested;
}
