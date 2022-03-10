// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// import '../manager/latest_provider.dart';
//
// class ProductScreen extends HookConsumerWidget {
//   const ProductScreen({
//     Key? key,
//   }) : super(key: key);
//
//   // final AutoDisposeFutureProvider<List<LayestModel>> provider =
//   //     FutureProvider.autoDispose<List<LayestModel>>((ref) async {
//   //   return await ref
//   //       .watch(getArchiveNotifier.notifier)
//   //       .getArchives(); // may cause `provider` to rebuild
//   // });
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final GetArchiveNotifier archive = ref.read(getArchiveNotifier.notifier);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body:
//             // ref.watch(provider).when(
//             //       loading: () => const CircularProgressIndicator(),
//             //       error: (e, o) {
//             //         debugPrint(e.toString());
//             //         debugPrint(o.toString());
//             //         return const Center(child: Text('error'));
//             //       },
//             //       data: (e) =>
//             Padding(
//                 padding: const EdgeInsets.all(25),
//                 child: ListView.separated(
//                   separatorBuilder: (context, index) => const Divider(
//                     color: Colors.grey,
//                   ),
//                   itemCount: archive.orders.length,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       children: [
//                         Text(archive.orders[index].id.toString()),
//                         Text(archive.orders[index].title.toString()),
//                         Image.network(archive.orders[index].photo.toString())
//                       ],
//                     );
//                   },
//                 )),
//       ),
//     );
//   }
// }
