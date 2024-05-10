import 'package:all_providers/providers/future_provider/pages/users/user_detail_page.dart';
import 'package:all_providers/providers/future_provider/pages/users/users_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListPage extends ConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // userList는 asyncValue 타입
    final userList = ref.watch(userListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      // switch 사용
      // body: switch (userList) {
      //   AsyncData(value: final users) => ListView.separated(
      //     itemCount: users.length,
      //     separatorBuilder: (context, index) {
      //       return const Divider();
      //     },
      //     itemBuilder: (context, index) {
      //       final user = users[index];
      //       return ListTile(
      //         leading: CircleAvatar(
      //           child: Text(user.id.toString()),
      //         ),
      //         title: Text(user.name),
      //       );
      //     },
      //   ),
      //   AsyncError(error: final error, stackTrace: final _) => Center(
      //           child: Text(
      //             error.toString(),
      //             style: const TextStyle(fontSize: 20, color: Colors.red),
      //           ),
      //         ),
      //   // AsyncLoading() => const Center(
      //   // switch case에서 default와 동일
      //   _ => const Center(
      //           child: CircularProgressIndicator(),
      //         ),
      // },
      // when 사용
      body: userList.when(
        data: (users) {
          return ListView.separated(
            itemCount: users.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              final user = users[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return UserDetailPage(user.id);
                    },),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(user.id.toString()),
                  ),
                  title: Text(user.name),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text(
              error.toString(),
              style: const TextStyle(fontSize: 20, color: Colors.red),
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
