import 'package:flutter/material.dart';

class DestinationCategory {
  final String id;
  final String name;
  final IconData icon;

  const DestinationCategory({
    required this.id,
    required this.name,
    required this.icon,
  });

  static const List<DestinationCategory> categories = [
    DestinationCategory(
      id: 'parks',
      name: 'National Parks',
      icon: Icons.park_outlined,
    ),
    DestinationCategory(
      id: 'waterfalls',
      name: 'Waterfalls',
      icon: Icons.water_drop_outlined,
    ),
    DestinationCategory(
      id: 'lakes',
      name: 'Lakes',
      icon: Icons.waves_outlined,
    ),
    DestinationCategory(
      id: 'mountains',
      name: 'Mountains',
      icon: Icons.terrain_outlined,
    ),
    DestinationCategory(
      id: 'culture',
      name: 'Cultural Sites',
      icon: Icons.museum_outlined,
    ),
    DestinationCategory(
      id: 'wildlife',
      name: 'Wildlife',
      icon: Icons.pets_outlined,
    ),
  ];
}
