import 'package:all_providers/providers/notifier_provider/pages/enum_activity/enum_activity_page.dart';
import 'package:all_providers/providers/notifier_provider/pages/enum_async_activity/enum_async_activity_page.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_activity/sealed_activity_page.dart';
import 'package:all_providers/providers/notifier_provider/pages/sealed_async_activity/sealed_async_activity_page.dart';
import 'package:flutter/material.dart';

import 'package:all_providers/widgets/custom_button.dart';

import 'pages/counter/counter_page.dart';

class NotifierProviderScreen extends StatelessWidget {
  const NotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotifierProvider'),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: const [
            CustomButton(
              title: 'Counter',
              child: CounterPage(),
            ),
            CustomButton(
              title: 'EnumActivity',
              child: EnumActivityPage(),
            ),
            CustomButton(
              title: 'SealedActivity',
              child: SealedActivityPage(),
            ),
            CustomButton(
              title: 'EnumAsyncActivity',
              child: EnumAsyncActivityPage(),
            ),
            CustomButton(
              title: 'SealedAsyncActivity',
              child: SealedAsyncActivityPage(),
            ),
          ],
        ),
      ),
    );
  }
}
