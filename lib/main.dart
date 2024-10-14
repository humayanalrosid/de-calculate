import 'package:flutter/material.dart';
import 'package:simple_calculator/body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeCalculate',
      theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff013a63),
        appBar: AppBar(
          title: const Text(
            "De-Calculate",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff013a63),
        ),

        body: const SafeArea(
          child: Body(),
        ),
    );
  }
}


