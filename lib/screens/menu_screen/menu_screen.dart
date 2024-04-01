// import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// // import 'package:threed_sidebar_menu/Screens/Payment_Screen.dart';
//
// class MenuScreen extends StatelessWidget {
//   const MenuScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo,
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             const Spacer(),
//             ListTile(
//               minLeadingWidth: 20,
//               leading: const Icon(
//                 Icons.payment,
//                 color: Colors.white,
//               ),
//               title: const Text(
//                 'Payment',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onTap: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (builder) => PaymentScreen(),
//                 //   ),
//                 // );
//                 // ZoomDrawer.of(context)!.toggle();
//               },
//             ),
//             ListTile(
//               minLeadingWidth: 20,
//               leading: const Icon(
//                 Icons.card_giftcard,
//                 color: Colors.white,
//               ),
//               title: const Text(
//                 'Promo',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onTap: () {
//                 ZoomDrawer.of(context)!.toggle();
//               },
//             ),
//             ListTile(
//               minLeadingWidth: 20,
//               leading: const Icon(
//                 Icons.notifications,
//                 color: Colors.white,
//               ),
//               title: const Text(
//                 'Notifications',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onTap: () {
//                 ZoomDrawer.of(context)!.toggle();
//               },
//             ),
//             ListTile(
//               minLeadingWidth: 20,
//               leading: const Icon(
//                 Icons.help,
//                 color: Colors.white,
//               ),
//               title: const Text(
//                 'Help',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onTap: () {
//                 ZoomDrawer.of(context)!.toggle();
//               },
//             ),
//             ListTile(
//               minLeadingWidth: 20,
//               leading: const Icon(
//                 Icons.info_outline,
//                 color: Colors.white,
//               ),
//               title: const Text(
//                 'About Us',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onTap: () {
//                 ZoomDrawer.of(context)!.toggle();
//               },
//             ),
//             ListTile(
//               minLeadingWidth: 20,
//               leading: const Icon(
//                 Icons.star_border,
//                 color: Colors.white,
//               ),
//               title: const Text(
//                 'Rate Us',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               onTap: () {
//                 ZoomDrawer.of(context)!.toggle();
//               },
//             ),
//             const Spacer(
//               flex: 2,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }