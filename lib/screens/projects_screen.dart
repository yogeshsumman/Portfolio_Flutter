import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import '../widgets/contact_details_dialog.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    final List<Map<String, String>> contacts = List.generate(100, (index) {
      final random = Random();
      final firstNames = ['John', 'Jane', 'Alex', 'Emily', 'Chris', 'Katie', 'Michael', 'Sarah', 'David', 'Laura'];
      final lastNames = ['Smith', 'Johnson', 'Brown', 'Williams', 'Jones', 'Garcia', 'Miller', 'Davis', 'Martinez', 'Hernandez'];

      // Generate a random first and last name
      final firstName = firstNames[random.nextInt(firstNames.length)];
      final lastName = lastNames[random.nextInt(lastNames.length)];

      // Generate a random 10-digit phone number
      final phoneNumber = '+91 ${random.nextInt(900000000) + 100000000}';

      return {
        'name': '$firstName $lastName',
        'phone': phoneNumber,
        'description': 'Contact for collaboration or inquiries.',
      };
    });

    return Container(
      color: isDarkMode ? Colors.black : Colors.white,
      child: ListView.builder(
        cacheExtent: 1000,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final imageUrl = 'https://picsum.photos/200/200?random=$index';

          return Column(
            children: [
              if (index == 0)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(
                        contacts[index]['name']![0].toUpperCase(),
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.black54,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ListTile(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) => ContactDetailsDialog(
                      isDarkMode: isDarkMode,
                      name: contacts[index]['name']!,
                      phone: contacts[index]['phone']!,
                      description: contacts[index]['description']!,
                      imageUrl: imageUrl,
                    ),
                  );
                },
                leading: CachedNetworkImage(
                  imageUrl: imageUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 25,
                    backgroundColor: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                    child: Icon(Icons.person, color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 25,
                    backgroundColor: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                    child: const Icon(Icons.error, color: Colors.red),
                  ),
                ),
                title: Text(
                  contacts[index]['name']!,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  contacts[index]['phone']!,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ),
              Divider(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
                height: 0,
                indent: 72,
                endIndent: 16,
              ),
            ],
          );
        },
      ),
    );
  }
}