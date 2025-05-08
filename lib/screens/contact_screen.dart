import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../models/contacts_data.dart';

class ContactsScreen extends StatelessWidget {
  final Function(Contact) onContactSelected;

  const ContactsScreen({super.key, required this.onContactSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: ContactsData.contacts.asMap().entries.map((entry) {
          final contact = entry.value;
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(contact.imageUrl),
              ),
              title: Text(contact.name),
              subtitle: Text(contact.designation),
              onTap: () => onContactSelected(contact),
            ),
          );
        }).toList(),
      ),
    );
  }
}