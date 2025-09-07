import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/mood_tracker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://djvgjmduiitpjufnkjvy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRqdmdqbWR1aWl0cGp1Zm5ranZ5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTcxNjk5MjAsImV4cCI6MjA3Mjc0NTkyMH0.W3pzESXmLhVeTQc5FnTtaaoyh-cw70bBIPSp1YNFMP4', // anon key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WithYou',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF7F9F8),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2EC4B6),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge:
              TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontFamily: 'Inter'),
        ),
      ),
      home: const MoodTracker(),
    );
  }
}
