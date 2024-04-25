import 'package:flutter_riverpod/flutter_riverpod.dart';

final helloProvider = Provider<String>((ref) {
  // Provider가 dispose될 때 실행
  ref.onDispose(() {
    // 해당 Provider를 필요로하는 Provider나 Widget이 없을 때 Dispose 될 수 있음
    print('[helloProvider]:: disposed');
  });
  return "Hello";
});

final worldProvider = Provider<String>((ref) {
  ref.onDispose(() {
    print('[worldProvider]:: disposed');
  });
  return "World";
});