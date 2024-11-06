import 'package:flutter_riverpod/flutter_riverpod.dart';

// 일만적인 Notifier
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

// AutoDispose
// autoDispose modifier를 적용하기 위해서는 Notifier가 아닌 AutoDisposeNotifier를 extends 해야 함
class AutoDisposeCounter extends AutoDisposeNotifier<int> {

  @override
  int build() {
    ref.onDispose(() {
      print("[autoDisposeCounterProvider]:: disposed");
    });
    return 0;
  }

  void increment() {
    state++;
  }
}

final autoDisposeCounterProvider = NotifierProvider.autoDispose<AutoDisposeCounter, int>(AutoDisposeCounter.new);

// Family
// family modifier를 적용하기 위해서는 Notifier가 아닌 FamilyNotifier를 extends 해야 함
// FamilyNotifier<상태 타입, 입력 타입>
class FamilyCounter extends FamilyNotifier<int, int> {
  // family의 경우에는 builder에 초기값을 보내줘야 하고, parameter 이름은 arg로 하는 것이 좋음
  @override
  int build(int arg) {
    ref.onDispose(() {
      print("[familyCounterProvider]:: disposed");
    });
    return arg;
  }

  void increment() {
    state++;
  }
}
// family modifier에는 추가적으로 받는 파라미터 타입을 넣어줌
final familyCounterProvider = NotifierProvider.family<FamilyCounter, int, int> (FamilyCounter.new);

// AutoDispose + Family
// extends만 바뀌고 이하는 family와 같음
class AutoDisposeFamilyCounter extends AutoDisposeFamilyNotifier<int, int> {

  @override
  int build(int arg) {
    ref.onDispose(() {
      print("[familyCounterProvider]:: disposed");
    });
    return arg;
  }

  void increment() {
    state++;
  }
}

final autoDisposeFamilyCounterProvider = NotifierProvider.family<AutoDisposeFamilyCounter, int, int> (AutoDisposeFamilyCounter.new);