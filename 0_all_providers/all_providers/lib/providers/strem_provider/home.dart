import 'package:all_providers/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'pages/ticker/ticker_page.dart';

class StreamProviderScreen extends StatelessWidget {
  const StreamProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
