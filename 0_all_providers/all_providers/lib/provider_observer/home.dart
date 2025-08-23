import 'package:flutter/material.dart';
import 'pages/provider/provider_page.dart';
import 'pages/state_provider/state_provider_page.dart';
import 'widgets/custom_button.dart';

import 'pages/async_notifier/async_notifier_page.dart';
import 'pages/change_notifier/change_notifier_page.dart';
import 'pages/notifier/notifier_page.dart';
import 'pages/future_provider/futuer_provider_page.dart';
import 'pages/state_notifier/state_notifier_page.dart';
import 'pages/stream_provider/stream_provider_page.dart';

class ProviderObserverScreen extends StatelessWidget {
  const ProviderObserverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: const [
            CustomButton(
              title: 'Provider',
              child: ProviderPage(),
            ),
            CustomButton(
              title: 'NotifierProvider',
              child: NotifierPage(),
            ),
            CustomButton(
              title: 'FutureProvider',
              child: FutureProviderPage(),
            ),
            CustomButton(
              title: 'StreamProvider',
              child: StreamProviderPage(),
            ),
            CustomButton(
              title: 'AsyncNotifierProvider',
              child: AsyncNotifierPage(),
            ),
            CustomButton(
              title: 'StateProvider',
              child: StateProviderPage(),
            ),
            CustomButton(
              title: 'StateNotifierProvider',
              child: StateNotifierPage(),
            ),
            CustomButton(
              title: 'ChangeNotifierProvider',
              child: ChangeNotifierPage(),
            ),
          ],
        ),
      ),
    );
  }
}
