import 'package:flutter/material.dart';
import 'home_page.dart';
import 'theme.dart';

void main() {
  runApp(const WindowsApp());
}

class WindowsApp extends StatelessWidget {
  const WindowsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Windows 桌面应用',
      theme: windowsTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
