import 'package:flutter/material.dart';

class VunoCategory {
  const VunoCategory(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class DiscoveryCardData {
  const DiscoveryCardData(
    this.title,
    this.subtitle,
    this.icon,
    this.colors, {
    this.badge,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> colors;
  final String? badge;
}

const categories = [
  VunoCategory('Eat', Icons.restaurant_rounded, Color(0xFFFF6B57)),
  VunoCategory('Explore', Icons.explore_rounded, Color(0xFF7B61FF)),
  VunoCategory('Stay', Icons.hotel_rounded, Color(0xFF00A389)),
  VunoCategory('Move', Icons.directions_car_filled_rounded, Color(0xFFF5A623)),
  VunoCategory('Shop', Icons.shopping_bag_rounded, Color(0xFFE9508A)),
  VunoCategory('Events', Icons.confirmation_number_rounded, Color(0xFF2588E4)),
];

const trending = [
  DiscoveryCardData(
    'Brunch at Naru',
    'Korean comfort food · 1.2 km',
    Icons.ramen_dining_rounded,
    [Color(0xFFFF9A6A), Color(0xFFFFD2A5)],
    badge: '4.8 ★',
  ),
  DiscoveryCardData(
    'Cubbon Park',
    'A peaceful city escape · 2.4 km',
    Icons.park_rounded,
    [Color(0xFF3EBC90), Color(0xFFB9E8B9)],
    badge: 'Open now',
  ),
  DiscoveryCardData(
    'Live at Humming Tree',
    'Indie night · Starts at 8:00 PM',
    Icons.music_note_rounded,
    [Color(0xFF6A55D9), Color(0xFFC5B9FF)],
    badge: 'Tonight',
  ),
];

const recommended = [
  DiscoveryCardData(
    'A slow Sunday in Indiranagar',
    'Coffee, design stores and a golden-hour walk',
    Icons.auto_awesome_rounded,
    [Color(0xFF254BA0), Color(0xFF8EBAF7)],
  ),
  DiscoveryCardData(
    'Dinner for two under ₹1,500',
    'Curated for your evening nearby',
    Icons.favorite_rounded,
    [Color(0xFFE85D75), Color(0xFFFFB7A5)],
  ),
];
