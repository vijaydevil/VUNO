import 'package:flutter/material.dart';

class EatDiscoveryScreen extends StatefulWidget {
  const EatDiscoveryScreen({super.key});
  @override
  State<EatDiscoveryScreen> createState() => _EatDiscoveryScreenState();
}

class _EatDiscoveryScreenState extends State<EatDiscoveryScreen> {
  static const _filters = ['For you', 'Fast delivery', 'Top rated', 'Offers'];
  static const _restaurants = [
    (
      'Naru Noodle Bar',
      'Korean · ₹₹ · 1.2 km',
      '4.8',
      Icons.ramen_dining_rounded,
      Color(0xFFFF9368),
    ),
    (
      'Soka',
      'Modern Indian · ₹₹₹ · 1.8 km',
      '4.7',
      Icons.restaurant_rounded,
      Color(0xFFC07755),
    ),
    (
      'Third Wave Coffee',
      'Coffee & bakery · 800 m',
      '4.6',
      Icons.coffee_rounded,
      Color(0xFFB77841),
    ),
    (
      'The Fatty Bao',
      'Asian · ₹₹₹ · 2.1 km',
      '4.5',
      Icons.lunch_dining_rounded,
      Color(0xFF8A6BE5),
    ),
  ];
  String _filter = 'For you';
  String _query = '';
  final Set<String> _saved = {};

  @override
  Widget build(BuildContext context) {
    final results = _restaurants
        .where(
          (item) => '${item.$1} ${item.$2}'.toLowerCase().contains(
            _query.toLowerCase(),
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Eat nearby',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            onPressed: () => _showMoodPicker(context),
            icon: const Icon(Icons.tune_rounded),
            tooltip: 'Tune picks',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        children: [
          const Text(
            'Good food, right around you.',
            style: TextStyle(fontSize: 16, color: Color(0xFF667085)),
          ),
          const SizedBox(height: 18),
          TextField(
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              hintText: 'Search restaurants or cuisines',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: _query.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => setState(() => _query = ''),
                      icon: const Icon(Icons.close_rounded),
                    ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 38,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _filters
                  .map(
                    (filter) => Padding(
                      padding: const EdgeInsets.only(right: 9),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: _filter == filter,
                        onSelected: (_) => setState(() => _filter = filter),
                        selectedColor: const Color(0xFFE8EEFF),
                        labelStyle: TextStyle(
                          color: _filter == filter
                              ? const Color(0xFF2667FF)
                              : const Color(0xFF475467),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Text(
                _query.isEmpty
                    ? 'Popular in Indiranagar'
                    : '${results.length} matches for “$_query”',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              if (_saved.isNotEmpty)
                Text(
                  '${_saved.length} saved',
                  style: const TextStyle(
                    color: Color(0xFF2667FF),
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (results.isEmpty)
            const _EmptyResults()
          else
            ...results.map(
              (restaurant) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _RestaurantCard(
                  restaurant: restaurant,
                  saved: _saved.contains(restaurant.$1),
                  onSave: () => setState(() {
                    if (_saved.contains(restaurant.$1)) {
                      _saved.remove(restaurant.$1);
                    } else {
                      _saved.add(restaurant.$1);
                    }
                  }),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showMoodPicker(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set the mood',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                ['Quick bite', 'Date night', 'Comfort food', 'Great coffee']
                    .map(
                      (mood) => ActionChip(
                        label: Text(mood),
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            SnackBar(content: Text('$mood picks are ready.')),
                          );
                        },
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    ),
  );
}

class _RestaurantCard extends StatelessWidget {
  const _RestaurantCard({
    required this.restaurant,
    required this.saved,
    required this.onSave,
  });
  final (String, String, String, IconData, Color) restaurant;
  final bool saved;
  final VoidCallback onSave;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${restaurant.$1} details are coming soon.')),
    ),
    borderRadius: BorderRadius.circular(18),
    child: Ink(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: restaurant.$5,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              restaurant.$4,
              color: Colors.white.withValues(alpha: .9),
              size: 40,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.$1,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  restaurant.$2,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: Color(0xFFF5A623),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      restaurant.$3,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      '25–35 min',
                      style: TextStyle(color: Color(0xFF667085), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onSave,
            icon: Icon(
              saved ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
              color: saved ? const Color(0xFF2667FF) : const Color(0xFF98A2B3),
            ),
            tooltip: saved ? 'Remove saved place' : 'Save place',
          ),
        ],
      ),
    ),
  );
}

class _EmptyResults extends StatelessWidget {
  const _EmptyResults();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 48),
    child: Column(
      children: [
        Icon(Icons.search_off_rounded, size: 44, color: Color(0xFF98A2B3)),
        SizedBox(height: 12),
        Text(
          'No places found',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 5),
        Text(
          'Try a cuisine, café, or neighbourhood.',
          style: TextStyle(color: Color(0xFF667085)),
        ),
      ],
    ),
  );
}
