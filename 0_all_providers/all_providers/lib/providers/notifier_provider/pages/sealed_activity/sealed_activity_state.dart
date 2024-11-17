import 'package:all_providers/providers/notifier_provider/models/activity.dart';

sealed class SealedActivityState {
  const SealedActivityState();
}

// final class로 만들면 library 밖에서 extends, implements 할 수 없다.
final class SealedActivityInitial extends SealedActivityState {
  const SealedActivityInitial();

  @override
  String toString() {
    return 'SealedActivityInitial{}';
  }
}

final class SealedActivityLoading extends SealedActivityState {
  const SealedActivityLoading();

  @override
  String toString() {
    return 'SealedActivityLoading{}';
  }
}

final class SealedActivitySuccess extends SealedActivityState {
  final Activity activity;
  const SealedActivitySuccess({
    required this.activity,
  });

  @override
  String toString() {
    return 'SealedActivitySuccess{activity: $activity}';
  }
}

final class SealedActivityFailure extends SealedActivityState {
  final String error;
  const SealedActivityFailure({
    required this.error,
  });

  @override
  String toString() {
    return 'SealedActivityFailure{error: $error}';
  }
}