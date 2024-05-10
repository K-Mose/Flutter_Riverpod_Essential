import 'package:all_providers/providers/future_provider/model/user.dart';
import 'package:all_providers/providers/future_provider/provider/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'users_providers.g.dart';

@riverpod
FutureOr<List<User>> userList(UserListRef ref) async {
  ref.onDispose(() {
    print('[userListProvider]:: disposed');
  });
  final response = await ref.watch(dioProvider).get('/users');
  final List userList = response.data;
  final users = [for (final user in userList) User.fromJson(user)];
  return users;
}

// argument만 주면 family로 만들어줌
@riverpod
FutureOr<User> userDetail(UserDetailRef ref,int id) async {
  ref.onDispose(() {
    print('[userDetailProvider($id)]:: disposed');
  });
  // ref.keepAlive(); 호출 이후의 데이터를 keepAlive 시킴
  final response = await ref.watch(dioProvider).get('/users/$id');
  ref.keepAlive();
  final user = User.fromJson(response.data);
  return user;
}

// final userListProvider = FutureProvider.autoDispose<List<User>>((ref) async {
//   ref.onDispose(() {
//     print('[userListProvider]:: disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users');
//   final List userList = response.data;
//   final users = [for (final user in userList) User.fromJson(user)];
//   return users;
// });
//
// final userDetailProvider = FutureProvider.autoDispose.family<User, int>((ref, id) async {
//   ref.onDispose(() {
//     print('[userDetailProvider($id)]:: disposed');
//   });
//   final response = await ref.watch(dioProvider).get('/users/$id');
//   final user = User.fromJson(response.data);
//   return user;
// });