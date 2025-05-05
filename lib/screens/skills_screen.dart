import 'package:flutter/material.dart';
import '../widgets/skills_section.dart';

class SkillsScreen extends StatelessWidget {
  final bool isDarkMode;

  const SkillsScreen({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDarkMode
                ? [Color(0xFF1E1E2E), Color(0xFF2A2A3E)]
                : [Color(0xFFD6D6FF), Color(0xFFB3E5FC)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 800),
              builder: (context, double opacity, child) {
                return Opacity(
                  opacity: opacity,
                  child: child,
                );
              },
              child: Text(
                'Technical Expertise',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: SkillsSection(isDarkMode: isDarkMode),
            ),
          ],
        ),
      ),
    );
  }
}