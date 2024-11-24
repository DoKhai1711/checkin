import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/hmong_translation/view/quiz/quiz_page.dart';
import 'package:untitled/hmong_translation/view/sign_in/sign_in_page.dart';

import 'login_cubit.dart';

class LoginArguments {

  LoginArguments();
}

class LoginPage extends StatelessWidget {
  final LoginArguments arguments;

  const LoginPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: const LoginChildPage(),
    );
  }
}

class LoginChildPage extends StatefulWidget {
  const LoginChildPage({Key? key}) : super(key: key);

  @override
  State<LoginChildPage> createState() => _LoginChildPageState();
}

class _LoginChildPageState extends State<LoginChildPage> {
  late final LoginCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         decoration: const BoxDecoration(
           // color: Colors.red.withOpacity(0.1),
             image: DecorationImage(
                 image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx7IBkCtYd6ulSfLfDL-aSF3rv6UfmWYxbSE823q36sPiQNVFFLatTFdGeUSnmJ4tUzlo&usqp=CAU'),
                 fit: BoxFit.cover,
                 opacity: 0.3)),
         child: SafeArea(
           child: Center(
             child: SingleChildScrollView(
               scrollDirection: Axis.vertical,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   // Lottie.network(
                   //     'https://assets6.lottiefiles.com/packages/lf20_k9wsvzgd.json',
                   //     animate: true,
                   //     height: 120,
                   //     width: 600),
                   // logo here
                   Image.asset(
                     'assets/img/img_translation.png',
                     height: 120,
                     width: 120,
                   ),
                   Text(
                     'Hmong Translation',
                     style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 40,
                   ),
                   ),
                   Text(
                     'Vui lòng đăng nhập để sử dụng ứng dụng',
                     style: TextStyle(
                         color: Colors.black.withOpacity(0.5),
                         fontWeight: FontWeight.w300,
                         // height: 1.5,
                         fontSize: 15),
                   ),

                   const SizedBox(
                     height: 30,
                   ),
                   Container(
                     height: 280,
                     // _formKey!.currentState!.validate() ? 200 : 600,
                     // height: isEmailCorrect ? 260 : 182,
                     width: MediaQuery.of(context).size.width / 1.1,
                     decoration: BoxDecoration(
                         color: Colors.white.withOpacity(0.3),
                         borderRadius: BorderRadius.circular(20)),
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(
                               left: 20, right: 20, bottom: 20, top: 20),
                           child: TextFormField(
                             controller: _textEditingController,
                             onChanged: (val) {},
                             decoration: const InputDecoration(
                               focusedBorder: UnderlineInputBorder(
                                   borderSide: BorderSide.none,
                                   borderRadius:
                                   BorderRadius.all(Radius.circular(10))),
                               enabledBorder: UnderlineInputBorder(
                                   borderSide: BorderSide.none,
                                   borderRadius:
                                   BorderRadius.all(Radius.circular(10))),
                               prefixIcon: Icon(
                                 Icons.person,
                                 color: Colors.purple,
                               ),
                               filled: true,
                               fillColor: Colors.white,
                               labelText: "Tên đăng nhập",
                               hintText: '',
                               labelStyle: TextStyle(color: Colors.purple),
                               // suffixIcon: IconButton(
                               //     onPressed: () {},
                               //     icon: Icon(Icons.close,
                               //         color: Colors.purple))
                             ),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 20, right: 20),
                           child: Form(
                             key: _formKey,
                             child: TextFormField(
                               obscuringCharacter: '*',
                               obscureText: true,
                               decoration: const InputDecoration(
                                 focusedBorder: UnderlineInputBorder(
                                     borderSide: BorderSide.none,
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(10))),
                                 enabledBorder: UnderlineInputBorder(
                                     borderSide: BorderSide.none,
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(10))),
                                 prefixIcon: Icon(
                                   Icons.lock,
                                   color: Colors.purple,
                                 ),
                                 filled: true,
                                 fillColor: Colors.white,
                                 labelText: "Mật khẩu",
                                 hintText: '',
                                 labelStyle: TextStyle(color: Colors.purple),
                               ),
                               validator: (value) {
                                 if (value!.isEmpty && value!.length < 5) {
                                   return 'Enter a valid password';
                                   {
                                     return null;
                                   }
                                 }
                               },
                             ),
                           ),
                         ),
                         SizedBox(
                           height: 20,
                         ),
                         ElevatedButton(
                             style: ElevatedButton.styleFrom(
                                 shape: RoundedRectangleBorder(
                                     borderRadius:
                                     BorderRadius.circular(10.0)),
                                 backgroundColor: Colors.purple,
                                 padding: EdgeInsets.symmetric(horizontal: 131, vertical: 20)
                               // padding: EdgeInsets.only(
                               //     left: 120, right: 120, top: 20, bottom: 20),
                             ),
                             onPressed: () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                   builder: (_) => QuizPage(
                                     arguments: QuizArguments(),
                                   ),
                                 ),
                               );
                             },
                             child: Text(
                               'Đăng nhập',
                               style: TextStyle(fontSize: 17, color: Colors.white),
                             )),
                       ],
                     ),
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         'Bạn chưa có tài khoản?',
                         style: TextStyle(
                           color: Colors.black.withOpacity(0.6),
                         ),
                       ),
                       TextButton(
                         onPressed: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (_) => SignInPage(
                                 arguments: SignInArguments(),
                               ),
                             ),
                           );
                         },
                         child: Text(
                           'Đăng ký',
                           style: TextStyle(
                               color: Colors.purple,
                               fontWeight: FontWeight.w500),
                         ),
                       )
                     ],
                   ),
                 ],
               ),
             ),
           ),
         ),
       ),
     );
  }

  Widget _buildBodyWidget() {
    return Container();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
