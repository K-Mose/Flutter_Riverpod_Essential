import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers.dart';

class AutoDisposePage extends ConsumerWidget {
  const AutoDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('[AutoDisposePage] build');
    // ref.listen<int>(autoDisposeCounterProvider, (previous, next) {
    //   if (next % 3 == 0) {
    //     showDialog(context: context, builder: (context) {
    //       return AlertDialog(content: Text('counter: $next'));
    //     },);
    //   }
    // },);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AutoDispose'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          // Consumer를 통해서 rebuild 범위를 줄임
          print('[AutoDisposePage] Consumer builder');
          // final counter = ref.watch(autoDisposeCounterProvider);
          // final anotherCounter = ref.watch(anotherCounterProvider);
          return Center(
            child: Text('counter / anotherCounter'),
          );
        }
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            heroTag: 'counter',
            onPressed: () {
              ref.read(autoDisposeCounterProvider.notifier).increment();
              print(ref.read(autoDisposeCounterProvider.notifier).state);
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: 'anotherCounter',
            onPressed: () {
              ref.read(anotherCounterProvider.notifier).increment();
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
