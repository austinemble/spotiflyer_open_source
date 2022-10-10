import 'package:flutter/material.dart';
import 'package:spotiflyer_open_source/pages/features_tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Spotiflyer 2.0"),
        ),
        body: const Align(
          alignment: Alignment.bottomCenter,
          child: Features(),
        ),
      ),
    );
  }
}
