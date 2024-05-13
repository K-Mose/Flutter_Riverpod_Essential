import 'package:all_providers/providers/future_provider/home.dart';
import 'package:all_providers/providers/provider/home.dart';
import 'package:all_providers/providers/state_provider/state_provider_screen.dart';
import 'package:all_providers/providers/strem_provider/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
