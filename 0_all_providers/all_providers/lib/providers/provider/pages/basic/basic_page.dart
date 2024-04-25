import 'package:all_providers/providers/provider/pages/basic/basic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ConsumerStatefulWidget 에서는 ref가 ConsumerState에서 정의되므로 어디서든 사용 가능
class BasicPage extends ConsumerStatefulWidget {
  const BasicPage({super.key});

  @override
  ConsumerState createState() => _BasicPageState();
}
class _BasicPageState extends ConsumerState<BasicPage> {

  @override
  Widget build(BuildContext context) {
    final hello = ref.watch(helloProvider);
    final world = ref.watch(worldProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Center(
        // bloc, provider와 비슷하게 child는 rebuild 되지 않을 위젯을 지정
        // Consumer로 감싼 위젯만 rebuild
        child: Consumer(builder: (context, ref, child) {
          return Text(
            "$hello $world",
            style: Theme.of(context).textTheme.headlineMedium,
          );
        },),
      ),
    );
  }
}

// // ConsumerWidget은 Consumer 위젯보다 사용하기 편하지만 rebuild 범위가 커짐
// class BasicPage extends ConsumerWidget {
//   const BasicPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final hello = ref.watch(helloProvider);
//     final world = ref.watch(worldProvider);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider'),
//       ),
//       body: Center(
//         child: Text(
//             "$hello $world",
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//       ),
//     );
//   }
// }


// class BasicPage extends StatelessWidget {
//   const BasicPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Provider'),
//       ),
//       body: Center(
//         // bloc, provider와 비슷하게 child는 rebuild 되지 않을 위젯을 지정
//         // Consumer로 감싼 위젯만 rebuild
//         child: Consumer(builder: (context, ref, child) {
//           return Text(
//             "${ref.watch(helloProvider)} ${ref.watch(worldProvider)}",
//             style: Theme.of(context).textTheme.headlineMedium,
//           );
//         },),
//       ),
//     );
//   }
// }
