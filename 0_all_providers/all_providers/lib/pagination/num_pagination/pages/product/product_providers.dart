import 'package:all_providers/pagination/num_pagination/repositories/product_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_providers.g.dart';

@riverpod
Future<Product> getProduct(GetProductRef ref, int id) async {
  ref.onDispose(() {
    print('[getProductProvider] disposed');
  });

  final product = ref.watch(productRepositoryProvider).getProduct(id);
  return product;
}