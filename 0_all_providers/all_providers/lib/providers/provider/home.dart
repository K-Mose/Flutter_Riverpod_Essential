import 'package:flutter/material.dart';

import 'package:all_providers/providers/provider/pages/auto_dispose/auto_dispose_page.dart';
import 'package:all_providers/providers/provider/pages/auto_dispose_family/auto_dispose_family_page.dart';
import 'package:all_providers/providers/provider/pages/basic/basic_page.dart';
import 'package:all_providers/providers/provider/pages/family/family_page.dart';
import 'package:all_providers/providers/provider/widgets/custom_button.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: const [
            CustomButton(
              title: 'Provider',
              child: BasicPage(),
            ),
            CustomButton(
              title: 'AutoDisposeProvider',
              child: AutoDisposePage(),
            ),
            CustomButton(
              title: 'FamilyProvider',
              child: FamilyPage(),
            ),
            CustomButton(
              title: 'AutoDisposeFamilyProvider',
              child: AutoDisposeFamilyPage(),
            ),
          ],
        ),
      ),
    );
  }
}
