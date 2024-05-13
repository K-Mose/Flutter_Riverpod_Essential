import 'package:all_providers/providers/strem_provider/pages/ticker/ticker_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TickerPage extends ConsumerWidget {
  const TickerPage({super.key});

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
    final tickerValue = ref.watch(tickerProvider);
    print("tickerValue:: $tickerValue");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticker'),
      ),
      body: Center(
        child: tickerValue.when(
          data: (data) {
            return Text(
              formatTimer(data),
              style: Theme.of(context).textTheme.headlineLarge,
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                error.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.red),
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
