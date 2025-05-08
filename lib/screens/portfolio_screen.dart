import 'package:flutter/material.dart';
import '../models/contact.dart';
import '../widgets/profile_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/custom_bottom_nav.dart';
import 'contact_screen.dart';
import 'skills_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  bool _isVisible = false;
  bool _isDarkMode = true;
  int _currentIndex = 0;
  Contact? _currentContact;

  late List<Widget> _otherScreens;

  @override
  void initState() {
    super.initState();
    _otherScreens = [
      ContactsScreen(onContactSelected: _selectContact),
      SkillsScreen(isDarkMode: _isDarkMode),
      const Center(child: Text('More', style: TextStyle(fontSize: 24))),
    ];

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  void _selectContact(Contact contact) {
    print('Selecting contact: ${contact.name}, ${contact.phone}, ${contact.designation}, ${contact.imageUrl}, ${contact.email}');
    setState(() {
      _currentContact = contact;
      _currentIndex = 0; // Switch to Profile tab
    });
  }

  Widget _buildMainContent() {
    print('Building main content with contact: ${_currentContact?.name ?? 'null'}');
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _isDarkMode
              ? [const Color(0xFF1E1E2E), const Color(0xFF2A2A3E)]
              : [const Color(0xFFD6D6FF), const Color(0xFFB3E5FC)],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: AnimatedOpacity(
            opacity: _isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileSection(contact: _currentContact),
                const SizedBox(height: 32),
                ContactSection(
                  contact: _currentContact,
                  onContactSelected: _selectContact,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
      _otherScreens[1] = SkillsScreen(isDarkMode: _isDarkMode);
    });
  }

  void _onNavTap(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        _currentContact = null; // Reset to default profile
        print('Resetting to default profile');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          headlineMedium: TextStyle(fontSize: 20, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          headlineMedium: TextStyle(fontSize: 20, color: Colors.white70),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('My Portfolio'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: _toggleTheme,
              tooltip: _isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
          ],
        ),
        body: _currentIndex == 0 ? _buildMainContent() : _otherScreens[_currentIndex - 1],
        bottomNavigationBar: CustomBottomNav(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          isDarkMode: _isDarkMode,
        ),
      ),
    );
  }
}