import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class CascadeCounter extends _$CascadeCounter {
  @override
  int build() {
    ref.onDispose(() {
      print('[CascadeCounterProvider] disposed');
    });
    ref.onCancel(() {
      print('[CascadeCounterProvider] cancelled');
    });
    ref.onResume(() {
      print('[CascadeCounterProvider] resumed');
    });
    ref.onAddListener(() {
      print('[CascadeCounterProvider] listener added');
    });
    ref.onRemoveListener(() {
      print('[CascadeCounterProvider] listener removed');
    });
    print('[CascadeCounterProvider] initialized');
    return 0;
  }

  void increment() => state++;
}


@riverpod
String Age(AgeRef ref) {
  ref.onDispose(() {
    print('[AgeProvider] disposed');
  });
  ref.onCancel(() {
    print('[AgeProvider] cancelled');
  });
  ref.onResume(() {
    print('[AgeProvider] resumed');
  });
  ref.onAddListener(() {
    print('[AgeProvider] listener added');
  });
  ref.onRemoveListener(() {
    print('[AgeProvider] listener removed');
  });
  print('[AgeProvider] initialized');
  final age = ref.watch(cascadeCounterProvider);
  return 'I am $age years old';
}