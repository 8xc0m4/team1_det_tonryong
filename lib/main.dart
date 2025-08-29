import 'package:flutter/material.dart';
import 'package:team1_det_tonryong/write/write_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WritePage(),
    );
  }
}
