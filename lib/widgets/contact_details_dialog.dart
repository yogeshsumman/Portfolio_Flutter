import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ContactDetailsDialog extends StatefulWidget {
  final bool isDarkMode;
  final String name;
  final String phone;
  final String description;
  final String imageUrl;

  const ContactDetailsDialog({
    Key? key,
    required this.isDarkMode,
    required this.name,
    required this.phone,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  _ContactDetailsDialogState createState() => _ContactDetailsDialogState();
}

class _ContactDetailsDialogState extends State<ContactDetailsDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: widget.isDarkMode
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
                CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.transparent,
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => CircleAvatar(
                    radius: 50,
                    backgroundColor: widget.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                    child: Icon(Icons.person, size: 60, color: widget.isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: 50,
                    backgroundColor: widget.isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
                    child: const Icon(Icons.error, size: 60, color: Colors.red),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.phone,
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 16,
                    color: widget.isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.isDarkMode ? Colors.blueAccent : Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}