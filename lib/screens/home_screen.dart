import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'alphabet_screen.dart';
import 'number_screen.dart';
import 'color_screen.dart';
import 'animal_screen.dart';
import 'country_screen.dart';
import 'body_part_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade100, Colors.purple.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Title with Animation
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Text(
                    'Kids Learning',
                    style: GoogleFonts.fredoka(
                      fontSize: 40,
                      color: Colors.indigo.shade800,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.15),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Welcome Message
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.school,
                      color: Colors.indigo.shade600,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Welcome to your learning adventure!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.comfortaa(
                        fontSize: 16,
                        color: Colors.indigo.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Learn alphabets, numbers and more in a fun way!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                    fontSize: 18,
                    color: Colors.indigo.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Learning Options
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    children: [
                      // Alphabets Card
                      _buildCategoryCard(
                        context,
                        title: 'Alphabets',
                        icon: Icons.text_fields,
                        color: Colors.indigo.shade300,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AlphabetScreen(),
                            ),
                          );
                        },
                      ),
                      // Numbers Card
                      _buildCategoryCard(
                        context,
                        title: 'Numbers',
                        icon: Icons.pin,
                        color: Colors.teal.shade300,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const NumberScreen(),
                            ),
                          );
                        },
                      ),
                      // Colors Card
                      _buildCategoryCard(
                        context,
                        title: 'Colors',
                        icon: Icons.color_lens,
                        color: Colors.orange.shade300,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ColorScreen(),
                            ),
                          );
                        },
                      ),
                      // Animals Card
                      _buildCategoryCard(
                        context,
                        title: 'Animals',
                        icon: Icons.pets,
                        color: Colors.pink.shade300,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AnimalScreen(),
                            ),
                          );
                        },
                      ),
                      // Countries Card
                      _buildCategoryCard(
                        context,
                        title: 'Countries',
                        icon: Icons.public,
                        color: Colors.blue.shade300,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CountryScreen(),
                            ),
                          );
                        },
                      ),
                      // Body Parts Card
                      _buildCategoryCard(
                        context,
                        title: 'Body Parts',
                        icon: Icons.accessibility_new,
                        color: Colors.green.shade300,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const BodyPartScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Footer with animated emoji
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Made with ',
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        color: Colors.indigo.shade400,
                      ),
                    ),
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0.8, end: 1.2),
                      duration: const Duration(milliseconds: 1000),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: const Text(
                            '❤️',
                            style: TextStyle(fontSize: 12),
                          ),
                        );
                      },
                    ),
                    Text(
                      ' for kids',
                      style: GoogleFonts.comfortaa(
                        fontSize: 12,
                        color: Colors.indigo.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Hero(
      tag: title,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 32,
                    color: color,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.comfortaa(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Tap to learn',
                    style: GoogleFonts.comfortaa(
                      fontSize: 12,
                      color: color,
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