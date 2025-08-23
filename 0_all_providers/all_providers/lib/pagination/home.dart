import 'package:all_providers/pagination/num_pagination/pages/products/products_page.dart';
import 'package:all_providers/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PaginationWithProvider extends StatelessWidget {
  const PaginationWithProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagination With Provider'),
      ),
      body: Center(
        child: ListView(
          children: const [
            CustomButton(
              title: 'NumberPagination',
              child: ProductsPage(),
            )
          ],
        ),
      ),
    );
  }
}