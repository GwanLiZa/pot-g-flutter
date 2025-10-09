abstract class FcmRequestEntity {
  final String fcmToken;
  final String os;
  final String version;

  FcmRequestEntity({
    required this.fcmToken,
    required this.os,
    required this.version,
  });
}
