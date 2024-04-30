import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_provider.g.dart';

final counterProvider = StateProvider<int>((ref) {
  ref.onDispose(() {
    print('[counterProvider] disposed');
  });
  return 0;
});

@Riverpod(keepAlive: true)
String age(Ref ref) {
  // code generation을 사용해 만든 provider는 code generation으로 생성한 provider여야 함. provider dependency rule
  // ProviderA에서 ProviderB를 watch하고 있으면 B의 상태가 변할 때 A는 rebuild 된다.
  final age = ref.watch(counterProvider);
  ref.onDispose(() {
    print("[ageProvider] disposed");
  });
  return "Hi! I'm $age years old";
}