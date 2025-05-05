import 'package:flutter/material.dart';
import 'screens/portfolio_screen.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const PortfolioScreen();
  }
}