import 'package:flutter/material.dart';

import 'travel_photos_page.dart';

class MainTravelPhotosApp extends StatelessWidget {
  const MainTravelPhotosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const TravelPhotosPage(),
    );
  }
}
