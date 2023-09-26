import 'package:flutter/material.dart';

import 'vinyl_disc_page.dart';

class MainVinylDiscApp extends StatelessWidget {
  const MainVinylDiscApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VinylDiscPage(),
    );
  }
}
