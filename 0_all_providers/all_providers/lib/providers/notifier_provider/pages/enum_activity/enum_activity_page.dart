import 'dart:math';

import 'package:all_providers/providers/notifier_provider/models/activity.dart';
import 'package:all_providers/providers/notifier_provider/pages/enum_activity/enum_activity_provider.dart';
import 'package:all_providers/providers/notifier_provider/pages/enum_activity/enum_activity_state.dart';
import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnumActivityPage extends ConsumerStatefulWidget {
  const EnumActivityPage({super.key});

  @override
  ConsumerState<EnumActivityPage> createState() => _EnumActivityPageState();
}

class _EnumActivityPageState extends ConsumerState<EnumActivityPage> {
  @override
  void initState() {
    super.initState();
    // Tried to modify a provider while the widget tree was building. 발생
    // ref.read(enumActivityProvider.notifier).fetchActivity(activityTypes[0]);
    // Future.delayed(Duration.zero, () {
    //   ref.read(enumActivityProvider.notifier).fetchActivity(activityTypes[0]);
    // });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(enumActivityProvider.notifier).fetchActivity(activityTypes[0]);
    });
  }
  @override
  Widget build(BuildContext context) {
    final activityState = ref.watch(enumActivityProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('EnumActivityNotifier'),
      ),
      // switch expression
      body: switch(activityState.status) {
        ActivityStatus.initial => const Center(
          child: Text(
              'Get some activity',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ActivityStatus.loading => const Center(child: CircularProgressIndicator(),),
        ActivityStatus.failure => Center(
          child: Text(
              activityState.error,
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          ),
        ActivityStatus.success => ActivityWidget(activity: activityState.activity),
      },
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final randomNumber = Random().nextInt(activityTypes.length);
          ref.read(enumActivityProvider.notifier).fetchActivity(activityTypes[randomNumber]);
        },
        label: Text('New Activity', style: Theme.of(context).textTheme.titleLarge,),
      ),
    );
  }
}

class ActivityWidget extends StatelessWidget {
  final Activity activity;
  const ActivityWidget({required this.activity, super.key});

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
