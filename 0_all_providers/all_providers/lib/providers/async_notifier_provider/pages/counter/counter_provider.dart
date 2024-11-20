import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
AsyncNotifier에서 modifier 적용
autoDispose를 사용하기 위해서는 AutoDisposeAsyncNotifier를 extends 해야함
family를 사용하기 위해서는 FamilyAsyncNotifier를 extends 하고 추가 argument가 필요함
그리고 build에도 해당 타입의 값을 넘겨줘야 함
autoDispose.family를 둘 다 사용하기 위해서는 AutoDisposeFamilyAsyncNotifier를 사용해야 함
 */
class Counter extends AutoDisposeFamilyAsyncNotifier<int, int> {
  // FutureOr<T> return T or Future<T>
  @override
  FutureOr<int> build(int arg) async {
    ref.onDispose(() {
      print('[counterProvider] disposed');
    },);
    await waitSecond();

    // AsyncValue의 값을 0으로 emit
    return arg;
  }
/*  @override
  FutureOr<int> build() {
    ref.onDispose(() {
      print('[counterProvider] disposed');
    },);

    // 값을 return하면 지연 없이 AsyncData가 호출된다.
    // return 0;
    // Future를 return 하면 지연이 없어도
    // 초기 값을 동기적으로 할당하기 위해 AsyncLoading이 발생 후 AsyncData가 호출된다.
    return Future.value(0);
  }*/

  Future<void> waitSecond() async => await Future.delayed(const Duration(seconds: 1));

  /// Business Logic
  Future<void> increment() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await waitSecond();
        if (state.value! > 2) {
          throw "fail to increment";
        }
      return state.value! + 1;
    },);
    // try {
    //   await waitSecond();
    //   if (state.value! > 2) {
    //     throw "fail to increment";
    //   }
    //   state = AsyncData(state.value! + 1);
    // } catch (error, stackTrace) {
    //   // stackTrace를 사용 불가능할 때 StackTrace.current를 넘겨주면 된다.
    //   state = AsyncError(error, stackTrace);
    // }
  }

  Future<void> decrement() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await waitSecond();
      return state.value! - 1;
    },);
    // try {
    //   await waitSecond();
    //   state = AsyncData(state.value! - 1);
    // } catch (error, stackTrace) {
    //   state = AsyncError(error, stackTrace);
    // }
  }
}

final counterProvider = AsyncNotifierProvider.autoDispose.family<Counter, int, int>(Counter.new);