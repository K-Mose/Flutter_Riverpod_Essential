import 'dart:math';

import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:all_providers/providers/notifier_provider/pages/enum_activity/enum_activity_state.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_activity/sealed_activity_provider.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_activity/sealed_activity_state.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SealedActivityPage extends ConsumerStatefulWidget {
  const SealedActivityPage({super.key});

  @override
  ConsumerState createState() => _SealedActivityPageState();
}

class _SealedActivityPageState extends ConsumerState<SealedActivityPage> {
  // 이전 성공한 화면 저장, 통신 실패인 경우에도 성공 화면 표시
  Widget? prevWidget;
  
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(sealedActivityProvider.notifier).fetchActivity(activityTypes[0]);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    ref.listen<SealedActivityState>(sealedActivityProvider, (previous, next) {
      switch (next) {
        case SealedActivityFailure(error: String error):
          showDialog(context: context, builder: (context) {
            return AlertDialog(content: Text(next.error),);
          },);
        case _:
      }
    },);

    final activityState = ref.watch(sealedActivityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SealedActivityNotifier'),
        actions: [
          IconButton(
            onPressed: () {
              ref.invalidate(sealedActivityProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: switch (activityState) {
        SealedActivityInitial() => const Center(
          child: Text(
            "Get Some Activity",
            style: TextStyle(fontSize: 20),
          ),
        ),
        SealedActivityLoading() => const Center(child: CircularProgressIndicator(),),
        SealedActivityFailure() => prevWidget == null ? const Center(
          child: Text(
            "Get Some Activity",
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
        ) : prevWidget!,
        SealedActivitySuccess(activity: Activity activity) => prevWidget = _ActivityWidget(activity: activityState.activity),
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final randomNumber = Random().nextInt(activityTypes.length);
          ref.read(sealedActivityProvider.notifier).fetchActivity(activityTypes[randomNumber]);
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