import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
class SyncKeepAliveCounter extends _$SyncKeepAliveCounter {
  @override
  int build() {
    // keepAlvie 메소드는 KeepAliveLink 객체를 반환한다.
    final keepAliveLink = ref.keepAlive();
    Timer? timer;
    Timer? timer2;
    ref.onDispose(() {
      print('[SyncKeepAliveCounterProvider] disposed, timer canceled');
      // Provider가 close되면 dispose 되므로 timer를 취소시킨다.
      timer?.cancel();
      timer2?.cancel();
      timer = null;
    });
    ref.onCancel(() {
      print('[SyncKeepAliveCounterProvider] cancelled, timer started');
      // Provier의 listener가 사라진 경우 cancel이 호출되므로
      // cancel이 호출된 시점 이후에 타이머를 실행시켜 Provider를 close할 수 있다.
      timer2 = Timer.periodic(const Duration(seconds: 1), (time) {
        print(time.tick);
      },);
      timer = Timer(const Duration(seconds: 10), () {
        keepAliveLink.close();
      });
    });
    ref.onResume(() {
      print('[SyncKeepAliveCounterProvider] resumed, timer canceled');
      // cancel에서 resume으로 돌아가기 때문에 resume에서 timer를 취소시킨다.
      timer?.cancel();
      timer2?.cancel();
      timer = null;
    });
    ref.onAddListener(() {
      print('[SyncKeepAliveCounterProvider] listener added');
    });
    ref.onRemoveListener(() {
      print('[SyncKeepAliveCounterProvider] listener removed');
    });
    print('[SyncKeepAliveCounterProvider] initialized');
    return 0;
  }

  void increment() => state++;
}