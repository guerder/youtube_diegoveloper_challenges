import 'package:flutter/material.dart';

import 'travel_photos/main_travel_photos.dart';
import 'vinyl_disc/main_vinyl_disc.dart';

void main(List<String> args) {
  runApp(const ChallengesApp());
}

class ChallengesApp extends StatelessWidget {
  const ChallengesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Youtube Diegoveloper Challenges',
      debugShowCheckedModeBanner: false,
      home: ChallengesPage(),
    );
  }
}

class ChallengesPage extends StatelessWidget {
  const ChallengesPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 48,
          ),
          children: [
            ElevatedButton(
              onPressed: () => context.push(const MainVinylDiscApp()),
              child: const Text('Vinyl Disc Concept'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push(const MainTravelPhotosApp()),
              child: const Text('Travel Photos'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

extension PushExtension on BuildContext {
  void push(Widget page) {
    Navigator.of(this).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
