import 'dart:math';

import 'package:flutter/material.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  _ProfileSectionState createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  final List<Color> _colors = [
    Colors.black.withOpacity(0.7),
    Colors.blue.withOpacity(0.7),
    Colors.green.withOpacity(0.7),
    Colors.red.withOpacity(0.7),
    Colors.purple.withOpacity(0.7),
  ];
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = _colors[0];
  }

  void _changeColor() {
    setState(() {
      Color newColor;
      do {
        newColor = _colors[Random().nextInt(_colors.length)];
      } while (newColor == _currentColor);
      _currentColor = newColor;
    });
  }

  bool _isDarkBackground(Color color) {
    final luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance < 0.5;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor = _isDarkBackground(_currentColor) ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: _changeColor,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: _currentColor,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              const SizedBox(height: 20),
              Text(
                'Yogesh Summan',
                style: textTheme.headlineLarge?.copyWith(color: textColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Software Engineer',
                style: textTheme.headlineMedium?.copyWith(color: textColor.withOpacity(0.7)),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'I am a passionate software engineer who loves building amazing apps and solving real-world problems with code.',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(color: textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}