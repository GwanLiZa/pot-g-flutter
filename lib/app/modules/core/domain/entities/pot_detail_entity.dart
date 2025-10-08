import 'package:pot_g/app/modules/chat/data/enums/pot_status.dart';
import 'package:pot_g/app/modules/core/domain/entities/route_entity.dart';

abstract class PotDetailEntity {
  const PotDetailEntity({
    required this.id,
    required this.name,
    required this.route,
    required this.startsAt,
    required this.endsAt,
    required this.departureTime,
    required this.current,
    required this.total,
    required this.status,
    required this.accountingRequested,
  });

  final String id;
  final String name;
  final RouteEntity route;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime departureTime;
  final int current;
  final int total;
  final PotStatus status;
  final int accountingRequested;
}
