import 'package:all_providers/providers/strean_notifier_provider/pages/ticker/ticker_provider.dart';
import 'package:all_providers/providers/strean_notifier_provider/timer/timer_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';

class ActionButtons extends ConsumerWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(timerProvider);
    if (state is! AsyncData) {
      return const SizedBox.shrink();
    }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...switch (state.value!) {
            TimerInitial() => [
              FloatingActionButton(
                heroTag: 'start',
                onPressed: () {
                  ref.read(timerProvider.notifier).startTimer();
                },
                child: const Icon(Icons.play_arrow),
              ),
            ],
            TimerRunning() => [
              FloatingActionButton(
                heroTag: 'pause',
                onPressed: () {
                  ref.read(timerProvider.notifier).pauseTimer();
                },
                child: const Icon(Icons.pause),
              ),
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: () {
                  ref.read(timerProvider.notifier).resetTimer();
                },
                child: const Icon(Icons.refresh),
              ),
            ],
            TimerPaused() => [
              FloatingActionButton(
                heroTag: 'resume',
                onPressed: () {
                  ref.read(timerProvider.notifier).resumeTime();
                },
                child: const Icon(Icons.play_arrow),
              ),
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: () {
                  ref.read(timerProvider.notifier).resetTimer();
                },
                child: const Icon(Icons.refresh),
              ),
            ],
            TimerFinished() => [
              FloatingActionButton(
                heroTag: 'reset',
                onPressed: () {
                  ref.read(timerProvider.notifier).resetTimer();
                },
                child: const Icon(Icons.refresh),
              ),
            ],
          }
        ],
    );
  }
}
