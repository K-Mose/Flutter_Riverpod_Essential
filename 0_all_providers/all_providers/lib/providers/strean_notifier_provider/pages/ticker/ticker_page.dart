import 'package:all_providers/providers/strean_notifier_provider/pages/ticker/ticker_provider.dart';
import 'package:all_providers/providers/strean_notifier_provider/pages/ticker/timer_value.dart';
import 'package:all_providers/providers/strean_notifier_provider/timer/action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickerValue = ref.watch(timerProvider);
    print("tickerValue:: $tickerValue");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Ticker'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerValue(),
            SizedBox(height: 20,),
            ActionButtons(),
          ],
        )
      ),
    );
  }
}
