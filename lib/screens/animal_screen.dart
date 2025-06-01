import 'package:flutter/material.dart';
import '../data/animal_data.dart';
import '../widgets/animal_card.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({super.key});

  @override
  _AnimalScreenState createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Learn Animals',
          style: GoogleFonts.comfortaa(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pink.shade300,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          Container(
            height: 10,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / animalData.length,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade300),
              ),
            ),
          ),
          // Page number indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Animal ${_currentPage + 1} of ${animalData.length}',
                  style: GoogleFonts.comfortaa(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    animalData[_currentPage].category,
                    style: GoogleFonts.comfortaa(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: animalData.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimalCard(item: animalData[index]),
                );
              },
            ),
          ),
          // Navigation buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentPage == 0
                      ? null
                      : () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _currentPage == animalData.length - 1
                      ? null
                      : () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade300,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 