// import 'package:flutter/material.dart';
//
// Widget ticketWidget (){
//   return Column(
//     children: [
//       Stack(
//         children: [
//           /// 👇 Background image directly
//           ClipRRect(
//             borderRadius: BorderRadius.circular(15), // optional
//             child: Image.asset(
//               "assets/png/ticket_image.png",
//               width: double.infinity,
//               height: 200, // jitni height chahiye
//               fit: BoxFit.cover,
//               color: Colors.blue,
//             ),
//           ),
//
//           /// 👇 Text overlay
//           Positioned(
//             bottom: 16,
//             left: 16,
//             child: Text(
//               "Hello World",
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 shadows: [
//                   Shadow(
//                     offset: Offset(1, 1),
//                     blurRadius: 5,
//                     color: Colors.black54,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       )
//
//
//     ],
//   );
// }
