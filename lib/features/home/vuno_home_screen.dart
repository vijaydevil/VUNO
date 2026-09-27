import 'package:flutter/material.dart';

import '../eat/eat_discovery_screen.dart';
import 'home_content.dart';

class VunoHomeScreen extends StatefulWidget {
  const VunoHomeScreen({super.key});
  @override
  State<VunoHomeScreen> createState() => _VunoHomeScreenState();
}

class _VunoHomeScreenState extends State<VunoHomeScreen> {
  int _tab = 0;
  void _soon(String label) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$label is coming soon.')));

  void _openCategory(String label) {
    if (label == 'Eat') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const EatDiscoveryScreen()));
      return;
    }
    _soon(label);
  }

  void _showBrief(String query) {
    final prompt = query.trim().isEmpty
        ? 'Plan something nearby'
        : query.trim();
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (context) => _VunoBrief(prompt: prompt),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: NavigationBar(
      height: 72,
      selectedIndex: _tab,
      onDestinationSelected: (index) {
        setState(() => _tab = index);
        if (index > 0) {
          _soon(['Discover', 'Trips', 'Saved', 'Profile'][index - 1]);
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded),
          label: 'Discover',
        ),
        NavigationDestination(
          icon: Icon(Icons.route_outlined),
          selectedIcon: Icon(Icons.route_rounded),
          label: 'Trips',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline_rounded),
          selectedIcon: Icon(Icons.bookmark_rounded),
          label: 'Saved',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    ),
    body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 32),
        children: [
          _Header(onProfile: () => _soon('Profile')),
          const SizedBox(height: 24),
          InkWell(
            onTap: () => _soon('Location selection'),
            borderRadius: BorderRadius.circular(12),
            child: const Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: Color(0xFF2667FF),
                  size: 19,
                ),
                SizedBox(width: 5),
                Text(
                  'Indiranagar, Bengaluru',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF344054),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF667085),
                  size: 19,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Good afternoon, Vijay',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w800,
              color: Color(0xFF121826),
              height: 1.12,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Everything you need, wherever you go.',
            style: TextStyle(fontSize: 15, color: Color(0xFF667085)),
          ),
          const SizedBox(height: 22),
          _Concierge(onAsk: _showBrief),
          const SizedBox(height: 28),
          const _Heading('What are you looking for?'),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 105,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = categories[index];
              return InkWell(
                onTap: () => _openCategory(item.label),
                borderRadius: BorderRadius.circular(17),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: item.color.withValues(alpha: .13),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Icon(item.icon, color: item.color, size: 22),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.label,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          const _Heading('Trending near you', action: 'See all'),
          const SizedBox(height: 16),
          SizedBox(
            height: 205,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: trending.length,
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemBuilder: (context, index) => _Trending(
                data: trending[index],
                onTap: () => _soon('Place details'),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const _Heading('Picked for you', action: 'Refresh'),
          const SizedBox(height: 16),
          ...recommended.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _Recommendation(
                data: item,
                onTap: () => _soon(item.title),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.onProfile});
  final VoidCallback onProfile;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF2667FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.vibration_rounded,
          color: Colors.white,
          size: 23,
        ),
      ),
      const SizedBox(width: 10),
      const Text(
        'VUNO',
        style: TextStyle(
          fontSize: 23,
          letterSpacing: 2.4,
          fontWeight: FontWeight.w900,
          color: Color(0xFF121826),
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_none_rounded),
        tooltip: 'Notifications',
      ),
      const SizedBox(width: 4),
      InkWell(
        onTap: onProfile,
        borderRadius: BorderRadius.circular(18),
        child: const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFDCE7FF),
          child: Text(
            'V',
            style: TextStyle(
              color: Color(0xFF2667FF),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    ],
  );
}

class _Concierge extends StatelessWidget {
  const _Concierge({required this.onAsk});
  final ValueChanged<String> onAsk;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x120B1020),
          blurRadius: 18,
          offset: Offset(0, 7),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFE8EEFF),
          child: Icon(
            Icons.auto_awesome_rounded,
            color: Color(0xFF2667FF),
            size: 19,
          ),
        ),
        SizedBox(width: 11),
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.search,
            onSubmitted: onAsk,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText: 'Ask VUNO anything...',
              hintStyle: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF667085),
              ),
            ),
          ),
        ),
        const Icon(Icons.arrow_forward_rounded, color: Color(0xFF2667FF)),
      ],
    ),
  );
}

class _VunoBrief extends StatelessWidget {
  const _VunoBrief({required this.prompt});
  final String prompt;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFFE8EEFF),
              child: Icon(Icons.auto_awesome_rounded, color: Color(0xFF2667FF)),
            ),
            SizedBox(width: 10),
            Text(
              'Your VUNO brief',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'For “$prompt”',
          style: const TextStyle(
            color: Color(0xFF667085),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F5FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'Start with Naru Noodle Bar for a relaxed meal, then take a short walk through the neighbourhood. I can refine this around your budget or time.',
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.check_rounded),
            label: const Text('Sounds good'),
          ),
        ),
      ],
    ),
  );
}

class _Heading extends StatelessWidget {
  const _Heading(this.title, {this.action});
  final String title;
  final String? action;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w800,
          color: Color(0xFF121826),
        ),
      ),
      const Spacer(),
      if (action != null)
        Text(
          action!,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF2667FF),
            fontSize: 13,
          ),
        ),
    ],
  );
}

class _Trending extends StatelessWidget {
  const _Trending({required this.data, required this.onTap});
  final DiscoveryCardData data;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 170,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 106,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: data.colors),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(18),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 13,
                    bottom: 10,
                    child: Icon(
                      data.icon,
                      color: Colors.white.withValues(alpha: .86),
                      size: 48,
                    ),
                  ),
                  if (data.badge != null)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          data.badge!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 11, 12, 5),
              child: Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                data.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF667085),
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _Recommendation extends StatelessWidget {
  const _Recommendation({required this.data, required this.onTap});
  final DiscoveryCardData data;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(18),
    child: Ink(
      height: 104,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: data.colors),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 14,
            bottom: 9,
            child: Icon(
              data.icon,
              size: 62,
              color: Colors.white.withValues(alpha: .78),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: SizedBox(
              width: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: .88),
                      fontSize: 11.5,
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
