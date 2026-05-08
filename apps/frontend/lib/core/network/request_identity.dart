import 'dart:math';

final Random _requestIdentityRandom = Random.secure();

String createRequestId() {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  final suffix = _requestIdentityRandom.nextInt(1 << 32).toRadixString(16);
  return 'req_$timestamp$suffix';
}

String createDeviceId() {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final suffix = _requestIdentityRandom.nextInt(1 << 32).toRadixString(16);
  return 'subflix_device_$timestamp$suffix';
}
