import 'package:all_providers/providers/future_provider/model/user.dart';
import 'package:all_providers/providers/future_provider/provider/dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
  ref.onDispose(() {
    print('[userListProvider]:: disposed');
  });
  final response = await ref.watch(dioProvider).get('/users');
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
});