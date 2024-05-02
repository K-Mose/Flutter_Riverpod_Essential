import 'package:all_providers/providers/state_provider/pages/auto_dispose/auto_dispose_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutoDisposePage extends ConsumerWidget {
  const AutoDisposePage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(autoDisposeAgeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider'),
      ),
      body: Center(
        child: Text('$value', style: const TextStyle(fontSize: 22),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // update: 현재 state를 argument로 받는 callback을 argument로 받음.
          // callback에서 새 state를 return
          ref.read(autoDisposeCounterProvider.notifier).update((state) =>  state + 10);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
