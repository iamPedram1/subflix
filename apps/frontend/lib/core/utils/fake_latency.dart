import 'dart:async';

Future<void> fakeDelay([
  Duration duration = const Duration(milliseconds: 750),
]) {
  return Future<void>.delayed(duration);
}
