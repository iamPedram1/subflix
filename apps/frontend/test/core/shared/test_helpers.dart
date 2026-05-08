import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> createMockSharedPreferences([
  Map<String, Object> initialValues = const <String, Object>{},
]) async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(initialValues);
  return SharedPreferences.getInstance();
}
