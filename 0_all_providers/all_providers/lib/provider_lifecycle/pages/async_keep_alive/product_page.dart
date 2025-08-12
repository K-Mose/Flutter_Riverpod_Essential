import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './providers.dart';

class ProductPage extends ConsumerWidget {
  final int productId;
  const ProductPage({required this.productId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singleProduct = ref.watch(getProductProvider(productId: productId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: singleProduct.when(
        data: (product) {
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(
                      productId.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(product.title, style: Theme.of(context).textTheme.headlineMedium,)),
                ],
              ),
              BulletedList(
                bullet: const Icon(Icons.check),
                listItems: [
                  'brand: ${product.brand}',
                  'price: \$${product.price}',
                  'discount(%): ${product.discountPercentage}'
              ],),
              const Divider(),
              SizedBox(
                width: double.infinity,

                child: Image.network(product.thumbnail, fit: BoxFit.cover),
              )
            ],
          );
        },
        error: (err, stack) => Center(
          child: Text(err.toString(), style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
        ),
        loading: () => const  Center(child: CircularProgressIndicator()),
      ),
    );
  }
  }