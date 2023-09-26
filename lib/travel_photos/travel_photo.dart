class TravelPhoto {
  final String backImage;
  final String frontImage;
  final String name;
  final int photos;

  const TravelPhoto({
    required this.backImage,
    required this.frontImage,
    required this.name,
    required this.photos,
  });
}

final travelPhotos = <TravelPhoto>[
  const TravelPhoto(
    backImage: 'assets/travel_photos/kuala_lumpur_backImage.png',
    frontImage: 'assets/travel_photos/kuala_lumpur_frontImage.png',
    name: 'Kuala Lumpur',
    photos: 258,
  ),
  const TravelPhoto(
    backImage: 'assets/travel_photos/singapore_backImage.png',
    frontImage: 'assets/travel_photos/singapore_frontImage.png',
    name: 'Singapore',
    photos: 768,
  ),
  const TravelPhoto(
    backImage: 'assets/travel_photos/japan_backImage.png',
    frontImage: 'assets/travel_photos/japan_frontImage.png',
    name: 'Japan',
    photos: 1928,
  ),
  const TravelPhoto(
    backImage: 'assets/travel_photos/south_korea_backImage.png',
    frontImage: 'assets/travel_photos/south_korea_frontImage.png',
    name: 'South Korea',
    photos: 258,
  ),
  const TravelPhoto(
    backImage: 'assets/travel_photos/thailand_backImage.png',
    frontImage: 'assets/travel_photos/thailand_frontImage.png',
    name: 'Thailand',
    photos: 638,
  ),
  const TravelPhoto(
    backImage: 'assets/travel_photos/paris_backImage.png',
    frontImage: 'assets/travel_photos/paris_frontImage.png',
    name: 'Paris',
    photos: 845,
  ),
  const TravelPhoto(
    backImage: 'assets/travel_photos/rome_backImage.png',
    frontImage: 'assets/travel_photos/rome_frontImage.png',
    name: 'Rome',
    photos: 231,
  ),
  const TravelPhoto(
    backImage: 'assets/travel_photos/sydney_backImage.png',
    frontImage: 'assets/travel_photos/sydney_frontImage.png',
    name: 'Sydney',
    photos: 258,
  ),
];
