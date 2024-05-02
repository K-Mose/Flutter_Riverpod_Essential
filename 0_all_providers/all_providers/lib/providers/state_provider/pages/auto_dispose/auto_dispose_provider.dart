import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auto_dispose_provider.g.dart';

final autoDisposeCounterProvider = StateProvider.autoDispose<int>((ref) {
  ref.onDispose(() {
    print('[autoDisposeCounterProvider] disposed');
  });
  return 0;
});

@Riverpod(keepAlive: false)
String autoDisposeAge(AutoDisposeAgeRef ref) {
  // The argument type 'AutoDisposeStateProvider<int>' can't be assigned
  // to the parameter type 'AlwaysAliveProviderListenable<dynamic>'.
  // 의존하는 Provider에서는 autoDispose가 적용되고 여기서 적용이 안되면 에러가 발생.
  // ageProvider는 autoDispose가 되지 않을 수 있음
  final autoDisposeAge = ref.watch(autoDisposeCounterProvider);
  ref.onDispose(() {
    print("[autoDisposeAgeProvider] disposed");
  });
  return "Hi! I'm $autoDisposeAge years old";
}