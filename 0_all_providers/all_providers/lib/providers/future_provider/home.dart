import 'package:all_providers/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'pages/users/user_list_page.dart';

class FutureProviderScreen extends StatelessWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FutureProvider'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          children: const [
            CustomButton(
              title: 'User List',
              child: UserListPage(),
            ),
          ],
        ),
      ),
    );
  }
}
