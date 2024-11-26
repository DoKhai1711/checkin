import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'quiz_cubit.dart';

class QuizArguments {

  QuizArguments();
}

class QuizPage extends StatelessWidget {
  final QuizArguments arguments;

  const QuizPage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return QuizCubit();
      },
      child: const QuizChildPage(),
    );
  }
}

class QuizChildPage extends StatefulWidget {
  const QuizChildPage({Key? key}) : super(key: key);

  @override
  State<QuizChildPage> createState() => _QuizChildPageState();
}

class _QuizChildPageState extends State<QuizChildPage> {
  late final QuizCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
     return Stack(
       children: [
         Container(
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             decoration: const BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topRight,
                 end: Alignment.bottomLeft,
                 colors: [
                   Color(0xFFbdc3c7),
                   Color(0xFF2c3e50),
                 ],
               ),
             ),
             child: SizedBox()
         ),
         SingleChildScrollView(
           child: Column(
             children: [

             ],
           ),
         )
       ],
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
