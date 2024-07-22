
// import 'package:fastfood/utils/local_images.dart';
// import 'package:fastfood/views/HomeView.dart';
// import 'package:fastfood/views/user/signupView.dart';
// import 'package:flutter/material.dart';
// import '../../utils/CommonColors.dart';

// // ignore: use_key_in_widget_constructors
// class LoginView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _LoginView();
// }

// class _LoginView extends State<LoginView>{

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           toolbarHeight: 80,
//           backgroundColor: Colors.white, flexibleSpace: Container(
//           padding: const EdgeInsets.only(top: 30.0, right: 20.0, left: 10.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: (){
//                   Navigator.pop(context);
//                 },
//                 child: Image.asset(LocalImages.ic_back, width: 50.0, height: 50, fit: BoxFit.fitWidth,),
//               ),
//             ],
//           ),
//         ),
//         ),
//         body: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 20.0),
//             child: ListView(
//               children: [
//                 Image.asset(LocalImages.logo1,height: 200,),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: Icon(Icons.email),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                const SizedBox(height: 20),
//                 TextFormField(
//                   decoration: const InputDecoration(
//                     labelText: 'Quên mật khẩu',
//                     prefixIcon: Icon(Icons.lock),
//                   ),
//                   obscureText: true,
//                 ),
//                const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: () {
//                         // Implement forget password functionality here
//                       },
//                       child: const Text(
//                         'Forget Password?',
//                         style: TextStyle(
//                           color: Colors.blue,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => HomeView()),);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.white, backgroundColor: CommonColors.primaryColor.withOpacity(0.7), // Text color
//                       ),
//                       child:const Text('Login'),
//                     ),
//                   ],
//                 ),
//                const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()),);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.white, backgroundColor: CommonColors.primaryColor.withOpacity(0.7), // Text color
//                   ),
//                   child:const Text('Sign Up'),
//                 ),
//               ],
//             ),
//         )
//     );

//   }
// }