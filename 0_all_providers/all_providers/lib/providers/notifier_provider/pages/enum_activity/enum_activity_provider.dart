import 'package:all_providers/providers/future_provider/provider/dio_provider.dart';
import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:all_providers/providers/notifier_provider/pages/enum_activity/enum_activity_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'enum_activity_provider.g.dart';

@riverpod
class EnumActivity extends _$EnumActivity {
  @override
  EnumActivityState build() {
    ref.onDispose(() {
      print('[enumActivityProvider] disposed');
    },);
    return EnumActivityState.initial();
  }

  //
  Future<void> fetchActivity(String activityType) async {
    state = state.copyWith(
      status: ActivityStatus.loading,
    );

    try {
      final response = await ref.read(dioProvider).get('?type=$activityType');
      final activity = Activity.fromJson(response.data);

      state = state.copyWith(
        status: ActivityStatus.success,
        activity: activity,
      );
    } catch (e) {
      state.copyWith(
        status: ActivityStatus.failure,
        error: e.toString(),
      );
    }
  }
}
