import 'package:all_providers/async_value/weather_app/home.dart';
import 'package:all_providers/provider_lifecycle/home.dart';
import 'package:all_providers/provider_observer/home.dart';
import 'package:all_providers/provider_observer/observeer/logger.dart';
import 'package:all_providers/providers/async_notifier_provider/home.dart';
import 'package:all_providers/providers/change_notifier_provider/home.dart';
import 'package:all_providers/providers/future_provider/home.dart';
import 'package:all_providers/providers/notifier_provider/home.dart';
import 'package:all_providers/providers/provider/home.dart';
import 'package:all_providers/providers/state_notifier_provider/home.dart';
import 'package:all_providers/providers/state_provider/state_provider_screen.dart';
import 'package:all_providers/providers/strean_notifier_provider/home.dart';
import 'package:all_providers/providers/strem_provider/home.dart';
import 'package:all_providers/riverpod_lint/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [Logger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod Essential',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Riverpod Essential"),),
      body: Center(
        child: ListView(
          children: [
            ExpansionTile(
              title: const Text("All Providers", style: TextStyle(fontSize: 24.0),),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ProviderScreen(),));
                    },
                    child: const Text("Lecture #1 Provider")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const StateProviderScreen(),));
                    },
                    child: const Text("Lecture #2 StateProvider")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const FutureProviderScreen(),));
                    },
                    child: const Text("Lecture #3 FutureProvider")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const StreamProviderScreen(),));
                    },
                    child: const Text("Lecture #4 StreamProvider")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const StateNotifierProviderScreen(),));
                    },
                    child: const Text("Lecture #5 StateNotifierProviderScreen")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ChangeNotifierProviderScreen(),));
                    },
                    child: const Text("Lecture #6 ChangeNotifierProviderScreen")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const NotifierProviderScreen(),));
                    },
                    child: const Text("Lecture #7 NotifierProviderScreen")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const AsyncNotifierProviderScreen(),));
                    },
                    child: const Text("Lecture #8 AsyncNotifierProviderScreen")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const StreamNotifierProviderScreen(),));
                    },
                    child: const Text("Lecture #9 StreamNotifierProviderScreen")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("AsyncValue Details", style: TextStyle(fontSize: 24.0),),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ProviderScreen(),));
                    },
                    child: const Text("Lecture #1 Provider")
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const WeatherScreen(),));
                    },
                    child: const Text("Lecture #2 AsyncValue")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Provider Lifecycles", style: TextStyle(fontSize: 24.0),),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ProviderLifecycleScreen(),));
                    },
                    child: const Text("Lecture #1 Provider Lifecycles")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Riverpod Lint", style: TextStyle(fontSize: 24.0),),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const RiverpodLintScreen(),));
                    },
                    child: const Text("Lecture #1 RiverpodLint")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Provider Observer", style: TextStyle(fontSize: 24.0),),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ProviderObserverScreen(),));
                    },
                    child: const Text("Lecture #1 Provider Observer")
                ),
              ],
            ),
            ExpansionTile(
              title: const Text("Pagination With Provider", style: TextStyle(fontSize: 24.0),),
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ProviderObserverScreen(),));
                    },
                    child: const Text("Lecture #1 Pagination With Provider")
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
