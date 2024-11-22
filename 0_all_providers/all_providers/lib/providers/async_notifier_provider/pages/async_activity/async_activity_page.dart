import 'dart:math';

import 'package:all_providers/providers/async_notifier_provider/models/activity.dart';
import 'package:all_providers/providers/async_notifier_provider/pages/async_activity/async_acyivity_provider.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncActivityPage extends ConsumerWidget {
  const AsyncActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(asyncActivityProvider);
    print(activityState);
    print('isLoading: ${activityState.isLoading}, isRefreshing: ${activityState.isRefreshing}, isReloading: ${activityState.isReloading}');
    print('hasValue: ${activityState.hasValue}, hasError: ${activityState.hasError}');
    return Scaffold(
      appBar: AppBar(title: const Text("AsyncActivityProvider"),),
      body: activityState.when(
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
              .getActivity(activityTypes[randomNumber]);
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