import 'package:all_providers/providers/strean_notifier_provider/pages/ticker/ticker_page.dart';
import 'package:all_providers/widgets/custom_button.dart';
import 'package:flutter/material.dart';


class StreamNotifierProviderScreen extends StatelessWidget {
  const StreamNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamNotifierProvider'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        shrinkWrap: true,
        children: const [
          CustomButton(
            title: 'Ticker',
            child: TickerPage(),
          ),
        ],
      ),
    );
  }
}
