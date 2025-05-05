import 'dart:math';
import 'package:flutter/material.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  _ContactSectionState createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
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
              Text(
                'Contact',
                style: textTheme.titleLarge?.copyWith(
                  color: textColor,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone, color: textColor.withOpacity(0.7), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Phone: +91 123456789',
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email, color: textColor.withOpacity(0.7), size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Email: yogeshdev@gmail.com',
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}