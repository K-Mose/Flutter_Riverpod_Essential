import 'dart:math';

import 'package:all_providers/providers/async_notifier_provider/extensions/async_vlaue_xx.dart';
import 'package:all_providers/providers/async_notifier_provider/models/activity.dart';
import 'package:all_providers/providers/async_notifier_provider/pages/async_activity/async_acyivity_provider.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncActivityPage extends ConsumerWidget {
  const AsyncActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<Activity>>(asyncActivityProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(content: Text(next.error.toString()),);
        },);
      }
    },);

    final activityState = ref.watch(asyncActivityProvider);
    print(activityState.toStr);
    print(activityState.props);

    return Scaffold(
      appBar: AppBar(
        title: const Text("AsyncActivityProvider"),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(asyncActivityProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: activityState.when(
        // previous value가 있으면 error화면 대신 이전 데이터를 화면에 표시할지 결정
        skipError: true,
        skipLoadingOnReload: true,
        skipLoadingOnRefresh: false,
        data: (activity) => _ActivityWidget(activity: activity),
        error: (error, stackTrace) =>
            Center(
              child: Text(e.toString(), style: const TextStyle(
                color: Colors.red,
                fontSize: 20,
              ), textAlign: TextAlign.center,),
            ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final randomNumber = Random().nextInt(activityTypes.length);
          ref
              .read(asyncActivityProvider.notifier)
              .fetchActivity(activityTypes[randomNumber]);
        },
        label: Text(
          'New Activity',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}

class _ActivityWidget extends StatelessWidget {
  final Activity activity;
  const _ActivityWidget({required this.activity, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(activity.type, style: Theme.of(context).textTheme.headlineMedium,),
          const Divider(),
          BulletedList(
            bullet: const Icon(Icons.check, color: Colors.green,),
            listItems: [
              'activity: ${activity.activity}',
              'accessibility: ${activity.accessibility}',
              'participants: ${activity.participants}',
              'price: ${activity.price}',
              'key: ${activity.key}',
            ],
          ),
        ],
      ),
    );
  }
}