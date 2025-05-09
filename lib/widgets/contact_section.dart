import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactSection extends StatelessWidget {
  final Contact? contact;
  final Function(Contact) onContactSelected;

  const ContactSection({super.key, this.contact, required this.onContactSelected});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final displayContact = contact ?? Contact(
      name: 'Yogesh Summan',
      phone: '+91 123456789',
      designation: 'Software Developer',
      imageUrl: 'assets/profile.jpg',
      aboutMe: 'Enthusiastic developer eager to learn and build impactful apps.',
      email: 'yogesh.summan@example.com',
    );

    final textTheme = Theme.of(context).textTheme;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.phone, color: textColor.withOpacity(0.7), size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Phone: ${displayContact.phone}',
                    style: TextStyle(fontSize: 16, color: textColor),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.email, color: textColor.withOpacity(0.7), size: 20),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Email: ${displayContact.email}',
                    style: TextStyle(fontSize: 16, color: textColor),
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}