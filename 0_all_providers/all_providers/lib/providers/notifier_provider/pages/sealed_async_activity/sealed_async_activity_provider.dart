import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_async_activity/sealed_async_activity_state.dart';
import 'package:all_providers/providers/notifier_provider/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sealed_async_activity_provider.g.dart';

@riverpod
class SealedAsyncActivity extends _$SealedAsyncActivity {
  int _errorCounter = 0;

  SealedAsyncActivity() {
    print('[sealedAsyncActivityProvider] constructor called');
  }
  @override
  SealedAsyncActivityState build() {
    print('[sealedAsyncActivityProvider] initialized');
    ref.onDispose(() {
      print('[sealedAsyncActivityProvider] disposed');
    },);
    // enum과 달리 state를 build에서 초기화할 필요가 없음
    fetchActivity(activityTypes[0]);
    return const SealedAsyncActivityLoading();
  }

  Future<void> fetchActivity(String activityType) async {
    print("hasCode in fetchActivity:: $hashCode");
    // enum과 달리 SealedAsyncActivityLoading를 할당해서 에러가 나지 않음
    state = const SealedAsyncActivityLoading();
    try {
      print("_errorCounter:: $_errorCounter");
      if (_errorCounter++ % 2 != 1) {
        await Future.delayed(const Duration(milliseconds: 800));
        throw "Fail to fetch Activity";
      }
      final response = await ref.read(dioProvider).get('?type=$activityType');
      final activity = Activity.fromJson(response.data);

      state = SealedAsyncActivitySuccess(activity: activity);
    } catch (e) {
      state = SealedAsyncActivityFailure(error: e.toString());
    }
  }
}

