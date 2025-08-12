import 'package:all_providers/provider_lifecycle/models/product.dart';
import 'package:all_providers/provider_lifecycle/pages/async_keep_alive/product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './providers.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(getProductsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: productList.when(
        data: (products) {
          return ListView.separated(itemBuilder: (context, index) {
            final Product product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ProductPage(productId: product.id);
                  },)
                );
              },
              child: ListTile(
                leading: CircleAvatar(child: Text('${product.id}'),),
                title: Text(product.title ),
              ),
            );
          }, separatorBuilder: (context, index) {
            return const Divider();
          }, itemCount: products.length,);
        },
        error: (err, stack) => Center(
          child: Text(err.toString(), style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
        ),
        loading: () => const  Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
