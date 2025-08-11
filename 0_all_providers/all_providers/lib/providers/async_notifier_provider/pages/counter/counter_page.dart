import 'package:all_providers/providers/async_notifier_provider/pages/counter/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider(10));
    print(counter);
    print('isLoading: ${counter.isLoading}, isRefreshing: ${counter.isRefreshing}, isReloading: ${counter.isReloading}');
    print('hasValue: ${counter.hasValue}, hasError: ${counter.hasError}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: counter.when(
          skipLoadingOnRefresh: false,
          data: (count) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$count', style: Theme.of(context).textTheme.headlineLarge,),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: 'decrement',
                      onPressed: ref
                          .read(counterProvider(10).notifier)
                          .decrement,
                      child: const Icon(Icons.remove),
                    ),
                    FloatingActionButton(
                      heroTag: 'increment',
                      onPressed: ref
                          .read(counterProvider(10).notifier)
                          .increment,
                      child: const Icon(Icons.add),
                    ),
                  ],
                )
              ],
            );
          },
          error: (error, stackTrace) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error.toString(), style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              OutlinedButton(
                onPressed: () => ref.invalidate(counterProvider),
                child: Text('Refresh', style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge, textAlign: TextAlign.center,),
              ),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
