import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'enum_async_activity_state.freezed.dart';

enum ActivityStatus {
  loading,
  success,
  failure,
}

@freezed
class EnumAsyncActivityState with _$EnumAsyncActivityState {
  const factory EnumAsyncActivityState({
    required ActivityStatus status,
    required Activity activity,
    required String error,
  }) = _EnumActivityState;

  factory EnumAsyncActivityState.initial() {
    return const EnumAsyncActivityState(
      status: ActivityStatus.loading,
      activity: Activity(),
      error: '',
    );
  }
}
