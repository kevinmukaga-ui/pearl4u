class Destination {
  final String id;
  final String name;
  final String region;
  final String category;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewsCount;
  final bool isFeatured;
  final bool isSaved;
  final List<String> activities;
  final double latitude;
  final double longitude;

  const Destination({
    required this.id,
    required this.name,
    required this.region,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.rating = 4.9,
    this.reviewsCount = 142,
    this.isFeatured = false,
    this.isSaved = false,
    this.activities = const [],
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  static const List<Destination> sampleDestinations = [
    Destination(
      id: 'murchison',
      name: 'Murchison Falls National Park',
      region: 'Northern Uganda',
      category: 'National Parks',
      description: 'Where the Nile meets wild savannah. Discover the thunderous falls, river boat safaris, and legendary wildlife.',
      imageUrl: 'https://images.unsplash.com/photo-1516426122078-c23e76319801?auto=format&fit=crop&w=800&q=80',
      rating: 4.9,
      reviewsCount: 310,
      isFeatured: true,
      isSaved: true,
      activities: ['Boat Cruise', 'Game Drive', 'Top of Falls Hike', 'Birding'],
      latitude: 2.2472,
      longitude: 31.7856,
    ),
    Destination(
      id: 'bwindi',
      name: 'Bwindi Impenetrable Forest',
      region: 'Western Uganda',
      category: 'National Parks',
      description: 'Home to nearly half of the world\'s endangered mountain gorillas within ancient mist-covered rainforest canopy.',
      imageUrl: 'https://images.unsplash.com/photo-1547970810-dc1eac8161a7?auto=format&fit=crop&w=800&q=80',
      rating: 5.0,
      reviewsCount: 480,
      isSaved: true,
      activities: ['Gorilla Trekking', 'Batwa Cultural Tour', 'Forest Walks'],
      latitude: -1.0500,
      longitude: 29.6500,
    ),
    Destination(
      id: 'queen_elizabeth',
      name: 'Queen Elizabeth National Park',
      region: 'Western Uganda',
      category: 'Wildlife',
      description: 'Famous for tree-climbing lions in Ishasha and abundant hippos along the scenic Kazinga Channel.',
      imageUrl: 'https://images.unsplash.com/photo-1534177616072-ef7dc120449d?auto=format&fit=crop&w=800&q=80',
      rating: 4.8,
      reviewsCount: 220,
      activities: ['Kazinga Channel Cruise', 'Lion Tracking', 'Crater Lakes Drive'],
      latitude: -0.2000,
      longitude: 30.0000,
    ),
    Destination(
      id: 'rwenzori',
      name: 'Rwenzori Mountains',
      region: 'Western Uganda',
      category: 'Mountains',
      description: 'The fabled "Mountains of the Moon", offering glaciers, equatorial snowpeaks, and otherworldly alpine flora.',
      imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=800&q=80',
      rating: 4.9,
      reviewsCount: 95,
      activities: ['Multi-day Trekking', 'Peak Climbing', 'Nature Photography'],
      latitude: 0.3833,
      longitude: 29.8667,
    ),
    Destination(
      id: 'bunyonyi',
      name: 'Lake Bunyonyi',
      region: 'Southwestern Uganda',
      category: 'Lakes',
      description: 'A serene highland lake dotted with 29 lush islands, terraced green hills, and peaceful dugout canoe journeys.',
      imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=800&q=80',
      rating: 4.7,
      reviewsCount: 165,
      activities: ['Canoeing', 'Island Hopping', 'Bird Watching', 'Swimming'],
      latitude: -1.2833,
      longitude: 29.9167,
    ),
  ];
}
