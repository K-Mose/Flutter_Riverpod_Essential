import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends Notifier<int> {
  // 상태의 초기값
  @override
  int build() {
    ref.onDispose(() {
      print("[counterProvider]:: disposed");
    });
    return 0;
  }

  void increment() {
    state++;
  }
}

final counterProvider = NotifierProvider<Counter, int> (Counter.new);