import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity.g.dart';

part 'activity.freezed.dart';

@freezed
class Activity with _$Activity {
  const factory Activity({
    @Default('') String activity,
    @Default(0.0) double accessibility,
    @Default(0.0) double availability,
    @Default(0.0) double price,
    @Default(0) int participants,
    @Default('') String type,
    @Default('') String key,
  }) = _Activity;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
}

final activityTypes = [
  "education",
  "recreational",
  "social",
  "diy",
  "charity",
  "cooking",
  "relaxation",
  "music",
  "busywork",
];

