import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/contact.dart';

class ProfileSection extends StatelessWidget {
  final Contact? contact;

  const ProfileSection({super.key, this.contact});

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

    Widget profileImage;
    if (displayContact.imageUrl.startsWith('assets/')) {
      profileImage = CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(displayContact.imageUrl),
        child: null,
      );
    } else {
      profileImage = CachedNetworkImage(
        imageUrl: displayContact.imageUrl,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 50,
          backgroundColor: Colors.transparent,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => CircleAvatar(
          radius: 50,
          backgroundColor: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          child: Icon(Icons.person, size: 60, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          radius: 50,
          backgroundColor: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
          child: const Icon(Icons.error, size: 60, color: Colors.red),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.grey[900]!.withOpacity(0.9)
            : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          profileImage,
          const SizedBox(height: 15),
          Text(
            displayContact.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            displayContact.designation,
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'About Me: ${displayContact.aboutMe}',
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white70 : Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}