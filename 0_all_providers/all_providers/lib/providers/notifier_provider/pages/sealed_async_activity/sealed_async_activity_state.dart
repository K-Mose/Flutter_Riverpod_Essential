import 'package:all_providers/providers/notifier_provider/models/activity.dart';

sealed class SealedAsyncActivityState {
  const SealedAsyncActivityState();
}

final class SealedAsyncActivityLoading extends SealedAsyncActivityState {
  const SealedAsyncActivityLoading();

  @override
  String toString() {
    return 'SealedAsyncActivityLoading{}';
  }
}

final class SealedAsyncActivitySuccess extends SealedAsyncActivityState {
  final Activity activity;
  const SealedAsyncActivitySuccess({
    required this.activity,
  });

  @override
  String toString() {
    return 'SealedAsyncActivitySuccess{activity: $activity}';
  }
}

final class SealedAsyncActivityFailure extends SealedAsyncActivityState {
  final String error;
  const SealedAsyncActivityFailure({
    required this.error,
  });

  @override
  String toString() {
    return 'SealedAsyncActivityFailure{error: $error}';
  }
}