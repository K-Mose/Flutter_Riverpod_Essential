import 'package:all_providers/providers/future_provider/pages/users/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyDisposePage extends ConsumerWidget {
  const FamilyDisposePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(userDetailProvider(1));
    ref.watch(userDetailProvider(2));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Dispose'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            OutlinedButton(
              onPressed: () {
                // 모든 userDetailProvider를 invalidate 시킴
                ref.invalidate(userDetailProvider);
                // 1을 받는 family provider만 invalidate 시킴
                // ref.invalidate(userDetailProvider(1));
              },
              child: Text('Invalidate', style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              onPressed: () {
                // family provider 자체를 argument로 줄 수 없음
                ref.refresh(userDetailProvider(1));
              },
              child: Text('refresh', style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge
              ),
            ),
          ],
        ),
      ),
    );
  }
}
