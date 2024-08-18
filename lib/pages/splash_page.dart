// import 'package:flutter/material.dart';
//
// import 'home_page.dart';
//
// class SplashPage extends StatefulWidget {
//   const SplashPage({super.key});
//
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     if(mounted == true){
//       Future.delayed(const Duration(seconds: 3)).then((value) {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const HomePage()));
//       });
//     }
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/images/logo.png',width: 100,height: 100,fit: BoxFit.cover,),
//             const Text('Music App'),
//           ],
//         ),
//       ),
//     );
//   }
// }
