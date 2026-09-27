import 'package:flutter/material.dart';

import 'features/home/vuno_home_screen.dart';

void main() => runApp(const VunoApp());

class VunoApp extends StatelessWidget {
  const VunoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brand = Color(0xFF2667FF);
    return MaterialApp(
      title: 'VUNO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: brand, primary: brand),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const VunoHomeScreen(),
    );
  }
}
