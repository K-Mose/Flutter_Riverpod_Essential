import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter extends AsyncNotifier<int> {
  // FutureOr<T> return T or Future<T>
  @override
  FutureOr<int> build() async {
    ref.onDispose(() {
      print('[counterProvider] disposed');
    },);
    await waitSecond();

    // AsyncValue의 값을 0으로 emit
    return 0;
  }

  Future<void> waitSecond() async => await Future.delayed(const Duration(seconds: 1));

  /// Business Logic
  Future<void> increment() async {
    state = const AsyncLoading();
    try {
      await waitSecond();
      if (state.value! > 2) {
        throw "fail to increment";
      }
      state = AsyncData(state.value! + 1);
    } catch (error, stackTrace) {
      // stackTrace를 사용 불가능할 때 StackTrace.current를 넘겨주면 된다.
      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> decrement() async {
    state = const AsyncLoading();

    try {
      await waitSecond();
      state = AsyncData(state.value! - 1);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final counterProvider = AsyncNotifierProvider<Counter, int>(Counter.new);