import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@Riverpod(keepAlive: true)
class KeepAliveCounter extends _$KeepAliveCounter {
  @override
  int build() {
    ref.onDispose(() {
      print('[KeepAliveCounterProvider] disposed');
    });
    ref.onCancel(() {
      print('[KeepAliveCounterProvider] cancelled');
    });
    ref.onResume(() {
      print('[KeepAliveCounterProvider] resumed');
    });
    ref.onAddListener(() {
      print('[KeepAliveCounterProvider] listener added');
    });
    ref.onRemoveListener(() {
      print('[KeepAliveCounterProvider] listener removed');
    });
    print('[KeepAliveCounterProvider] initialized');
    return 0;
  }

  void increment() => state++;
}