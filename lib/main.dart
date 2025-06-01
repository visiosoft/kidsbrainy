import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const KidsLearningApp());
}

class KidsLearningApp extends StatelessWidget {
  const KidsLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}