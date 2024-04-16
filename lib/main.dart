import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:infinite_page_view_demo/starter/starter_pageview.dart';

import 'final/final_pageview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text("Infinite Pageview"),
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: StarterPageView(),
        ),
      ),
    );
  }
}
