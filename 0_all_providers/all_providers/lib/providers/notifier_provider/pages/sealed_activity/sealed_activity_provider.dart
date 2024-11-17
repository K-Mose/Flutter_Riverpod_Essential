import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:all_providers/providers/notifier_provider/pages/enum_activity/enum_activity_state.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_activity/sealed_activity_state.dart';
import 'package:all_providers/providers/notifier_provider/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sealed_activity_provider.g.dart';

@riverpod
class SealedActivity extends _$SealedActivity {
  int _errorCounter = 0;
  @override
  SealedActivityState build() {
    ref.onDispose(() {
      print('[sealedActivityProvider] disposed');
    },);
    return const SealedActivityInitial();
  }
  Future<void> fetchActivity(String activityType) async {
    print("hasCode in fetchActivity:: $hashCode");
    state = const SealedActivityLoading();
    try {
      print("_errorCounter:: $_errorCounter");
      if (_errorCounter++ % 2 != 1) {
        await Future.delayed(const Duration(milliseconds: 800));
        throw "Fail to fetch Activity";
      }
      final response = await ref.read(dioProvider).get('?type=$activityType');
      final activity = Activity.fromJson(response.data);

      state = SealedActivitySuccess(activity: activity);
    } catch (e) {
      state = SealedActivityFailure(error: e.toString());
    }
  }
}

