import 'dart:math';

import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_activity/sealed_activity_provider.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_activity/sealed_activity_state.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_async_activity/sealed_async_activity_provider.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_async_activity/sealed_async_activity_state.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SealedAsyncActivityPage extends ConsumerStatefulWidget {
  const SealedAsyncActivityPage({super.key});

  @override
  ConsumerState createState() => _SealedAsyncActivityPageState();
}

class _SealedAsyncActivityPageState extends ConsumerState<SealedAsyncActivityPage> {
  // 이전 성공한 화면 저장, 통신 실패인 경우에도 성공 화면 표시
  Widget? prevWidget;
  
  @override
  Widget build(BuildContext context) {
    ref.listen<SealedAsyncActivityState>(sealedAsyncActivityProvider, (previous, next) {
      switch (next) {
        case SealedAsyncActivityFailure(error: String error):
          showDialog(context: context, builder: (context) {
            return AlertDialog(content: Text(next.error),);
          },);
        case _:
      }
    },);

    final activityState = ref.watch(sealedAsyncActivityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SealedAsyncActivityNotifier'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(sealedAsyncActivityProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: switch (activityState) {
        SealedAsyncActivityLoading() => const Center(child: CircularProgressIndicator(),),
        SealedAsyncActivityFailure() => prevWidget == null ? const Center(
          child: Text(
            "Get Some Activity",
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ) : prevWidget!,
        SealedAsyncActivitySuccess(activity: Activity activity) => prevWidget = _ActivityWidget(activity: activityState.activity),
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final randomNumber = Random().nextInt(activityTypes.length);
          ref.read(sealedAsyncActivityProvider.notifier).fetchActivity(activityTypes[randomNumber]);
        },
        label: Text('New Activity', style: Theme.of(context).textTheme.titleLarge,),
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