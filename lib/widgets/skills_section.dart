import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final bool isDarkMode;

  const SkillsSection({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final skills = [
      {'name': 'Flutter', 'icon': Icons.flutter_dash},
      {'name': 'Dart', 'icon': Icons.code},
      {'name': 'Firebase', 'icon': Icons.cloud},
      {'name': 'REST APIs', 'icon': Icons.api},
      {'name': 'Git', 'icon': Icons.account_tree},
      {'name': 'UI/UX Design', 'icon': Icons.design_services},
      {'name': 'React', 'icon': Icons.web},
      {'name': 'Node.js', 'icon': Icons.memory},
      {'name': 'TypeScript', 'icon': Icons.code_off},
      {'name': 'SQL & MongoDB', 'icon': Icons.storage},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: const Text(
              'My Skills',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 3.75, // Matches width:height ratio (150/40)
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 500 + (index * 100)),
                builder: (context, double scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Container(
                  width: 150, // Fixed width for uniformity
                  height: 40, // Fixed height for uniformity
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? Colors.blueAccent.withOpacity(0.2)
                        : Colors.blue[100]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          skills[index]['icon'] as IconData,
                          size: 20,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            skills[index]['name'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}