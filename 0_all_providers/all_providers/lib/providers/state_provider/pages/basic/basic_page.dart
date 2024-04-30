import 'package:all_providers/providers/state_provider/pages/basic/basic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasicPage extends ConsumerWidget {
  const BasicPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // setState() or markNeedsBuild() called during build.
    // 에러 해결책
    // 1. WidgetsBinding.instance.addPostFrameCallback((s) {});
    // 2. Future.delaye(const Duration(second: 0), () {});
    // 3. ref.listen
    ref.listen<int>(counterProvider, (previous, next) {
      if (next == 3) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Show Dialog !! $next"),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            );
          },
        );
        // });
      }
    });
    final value = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider'),
      ),
      body: Center(
        child: Text('$value', style: const TextStyle(fontSize: 22),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ref.watch: provider의 state를 관찰해서 widget을 rebuild
          // ref.read: provider가 expose한 state에 접근할 때 사용
          ref.read(counterProvider.notifier).state++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
