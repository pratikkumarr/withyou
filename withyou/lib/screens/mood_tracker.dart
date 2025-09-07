import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});
  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> {
  final supabase = Supabase.instance.client;
  final moods = ['😊', '😐', '😔', '😡', '😭'];
  String? selected;

  Future<void> saveMood(String mood) async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login or continue as guest.')),
      );
      return;
    }

    try {
      await supabase.from('moods').insert({
        'user_id': user.id,
        'mood': mood,
        'created_at': DateTime.now().toUtc().toIso8601String(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mood saved ✅')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving mood: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'How do you feel today?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: moods.map((m) {
                final isSelected = selected == m;
                return GestureDetector(
                  onTap: () => setState(() => selected = m),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal.shade50 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected ? Colors.teal : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      m,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: selected == null ? null : () => saveMood(selected!),
              icon: const Icon(Icons.save),
              label: const Text('Save Mood'),
            ),
            const SizedBox(height: 24),
            const Text('Recent moods (coming soon)'),
          ],
        ),
      ),
    );
  }
}
