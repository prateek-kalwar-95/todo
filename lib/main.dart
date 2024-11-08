import 'package:flutter/material.dart';
import 'package:todo/screen/home.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
  // );
  runApp(MainClass());
}


class MainClass extends StatelessWidget {
  const MainClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}