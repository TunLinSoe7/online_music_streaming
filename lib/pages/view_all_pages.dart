// import 'package:flutter/material.dart';
// import 'package:music_app/pages/home_page.dart';
//
// class ViewAllPage extends StatelessWidget {
//   const ViewAllPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         surfaceTintColor: Colors.white,
//         title: const Text('Recently View',style: TextStyle(
//           fontWeight: FontWeight.bold
//         ),),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         child: Column(
//           children: [
//             Expanded(child: GridView.builder(
//               itemCount: 10,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//
//                     mainAxisSpacing: 30,
//                     crossAxisCount: 2), itemBuilder: (_,index){
//               return const SongItemViews(
//                 imageUrl: 'https://firebasestorage.googleapis.com/v0/b/music-app-f8062.appspot.com/o/covers%2Fall_the_girl_same.jpg?alt=media&token=5229410c-6d6b-4e3a-b954-8d9192b7d33d',
//                 imageWidth: 170,
//               );
//             })),
//           ],
//         ),
//       ),
//     );
//   }
// }
