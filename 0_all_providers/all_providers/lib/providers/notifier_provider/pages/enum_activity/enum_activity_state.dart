import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'enum_activity_state.freezed.dart';

enum ActivityStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class EnumActivityState with _$EnumActivityState {
  const factory EnumActivityState({
    required ActivityStatus status,
    required Activity activity,
    required String error,
  }) = _EnumActivityState;

  factory EnumActivityState.initial() {
    return const EnumActivityState(
      status: ActivityStatus.initial,
      activity: Activity(),
      error: '',
    );
  }
}
