// import 'package:al_baseet/src/screens/shared_widgets/app_common_widets.dart';
// import 'package:flutter/material.dart';
//
// class AreYouSureDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return  showCustomDialog(
//       title: S.of(context).delete_product_qu,
//       info: S.of(context).delete_product_info,
//       actions: Row(
//         children: [
//           Expanded(
//             child: AppBtn(
//               text: S.of(context).cancel,
//               backgroundColor: Colors.black54,
//               isPlane: true,
//               onPress: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//           SizedBox(width: 10),
//           Expanded(
//             child: AppBtn(
//                 text: S.of(context).ok,
//                 backgroundColor: Colors.redAccent,
//                 onPress: () {
//                   Navigator.pop(context);
//                   context.read<WarehouseProvider>().removeItem(product);
//                 }),
//           ),
//         ],
//       ),
//     );
//   }
// }
