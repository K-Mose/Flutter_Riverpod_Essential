import 'package:all_providers/providers/strean_notifier_provider/pages/ticker/ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerValue extends ConsumerWidget {
  const TimerValue({super.key});

  String zeroPaddedTwoDigit(double ticks) {
    return ticks.floor().toString().padLeft(2, '0');
  }

  String formatTimer(int ticks) {
    final minutes = zeroPaddedTwoDigit(ticks/60 % 60);
    final seconds = zeroPaddedTwoDigit(ticks%60);
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerState = ref.watch(timerProvider);
    print(timerState);

    // orElse
    return timerState.maybeWhen(
      data: (value) => Text(
        formatTimer(value.duration),
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      orElse: () => const SizedBox.shrink(),
    );
  }
}
