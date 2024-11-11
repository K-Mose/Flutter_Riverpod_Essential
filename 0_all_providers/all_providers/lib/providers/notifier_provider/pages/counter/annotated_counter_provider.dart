import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'annotated_counter_provider.g.dart';

@riverpod
class AnnotatedCounter extends _$AnnotatedCounter {

  // initialValue를 추가했기 때문에 family로 생성됨
  @override
  int build(int initialValue) {
    ref.onDispose(() {
      print("[annotatedCounterProvider]:: disposed");
    });
    return initialValue;
  }

  void increment() {
    state++;
  }
}