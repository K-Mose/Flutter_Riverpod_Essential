import 'package:all_providers/providers/notifier_provider/pages/enum_async_activity/enum_async_activity_state.dart';
import 'package:all_providers/providers/notifier_provider/providers/dio_provider.dart';
import 'package:all_providers/providers/notifier_provider/models/activity.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enum_async_activity_provider.g.dart';

@riverpod
class MyCounter extends _$MyCounter {
  @override
  int build() {
    return 0;
  }

  void increment() => state++;
}

@riverpod
class EnumAsyncActivity extends _$EnumAsyncActivity {
  int _errorCounter = 0;

  EnumAsyncActivity() {
    // state는 constructor에서 사용할 수 없음
    // state = EnumAsyncActivityState.initial();

    // Provider가 invalidate된 후 dispose 되어도 새로 initialized 할 때 constructor를 부르지 않는다.
    // provider가 다시 build 되어도 notifier instance 자체는 dispose 되지 않음
    print('[enumAsyncActivityProvider] constructor called');
  }

  @override
  EnumAsyncActivityState build() {
    print('[enumAsyncActivityProvider] initialized');
    ref.onDispose(() {
      print('[enumAsyncActivityProvider] disposed');
    },);

    // ref.watch에 의해 provider가 rebuild 되어도 constructor를 부르지 않고 초기화 한다.
    ref.watch(myCounterProvider);

    print("hasCode:: $hashCode");
    // Bad state: Tried to read the state of an uninitialized provider
    // state를 초기화 하기 전에 fetch 하면 error 발생, state 초기화 후 fetch 실행
    state = EnumAsyncActivityState.initial();
    fetchActivity(activityTypes[0]);

    // provider가 외부에 노출하는 최초의 state는 build에서 return하는 state
    // build에서 state에 어떤 값을 넣든 return하지 않으면 외부에 노출되지 않음
    return EnumAsyncActivityState.initial();
  }

  Future<void> fetchActivity(String activityType) async {
    print("hasCode in fetchActivity:: $hashCode");
    state = state.copyWith(
      status: ActivityStatus.loading,
    );

    try {
      print("_errorCounter:: $_errorCounter");
      if (_errorCounter++ % 2 != 1) {
        await Future.delayed(const Duration(milliseconds: 800));
        throw "Fail to fetch Activity";
      }
      final response = await ref.read(dioProvider).get('?type=$activityType');
      final activity = Activity.fromJson(response.data);

      state = state.copyWith(
        status: ActivityStatus.success,
        activity: activity,
      );
    } catch (e) {
      state = state.copyWith(
        status: ActivityStatus.failure,
        error: e.toString(),
      );
    }
  }
}
