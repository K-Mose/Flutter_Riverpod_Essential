import 'package:flutter_riverpod/flutter_riverpod.dart';

// family 생성자로 유사한 Provider를 만드는 행위를 줄일 수 있음
// Provider.family<T, R> : T return Type, R receive Type
final familyHelloProvider = Provider.family<String, String>((ref, name) {
  ref.onDispose(() {
    print('[familyHelloProvider($name)]:: disposed');
  });
  return 'Hello $name';
});