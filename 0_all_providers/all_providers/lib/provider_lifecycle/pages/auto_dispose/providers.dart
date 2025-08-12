import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class AnotherCounter extends _$AnotherCounter {
  @override
  int build() {
    print('[AnotherCounter] initialized');
    ref.onDispose(() {
      print('[AnotherCounter] disposed');
    });
    ref.onCancel(() {
      print('[AnotherCounter] cancelled');
    });
    ref.onResume(() {
      print('[AnotherCounter] resumed');
    });
    ref.onAddListener(() {
      print('[AnotherCounter] listener added');
    });
    ref.onRemoveListener(() {
      print('[AnotherCounter] listener removed');
    });
    return 10;
  }

  void increment() => state += 10;
}

@riverpod
class AutoDisposeCounter extends _$AutoDisposeCounter {
  @override
  int build() {
    ref.onDispose(() {
      print('[AutoDisposeCounter] disposed');
    });
    ref.onCancel(() {
      print('[AutoDisposeCounter] cancelled');
    });
    ref.onResume(() {
      print('[AutoDisposeCounter] resumed');
    });
    ref.onAddListener(() {
      print('[AutoDisposeCounter] listener added');
    });
    ref.onRemoveListener(() {
      print('[AutoDisposeCounter] listener removed');
    });
    print('[AutoDisposeCounter] initialized');
    return 0;
  }

  void increment() => state++;
}