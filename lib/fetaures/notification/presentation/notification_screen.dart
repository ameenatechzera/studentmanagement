import 'package:flutter/material.dart';



// --- Data Model ---
class NotificationItem {
  final String name;
  final String message;
  final String time;
  final String avatarUrl;
  final bool isStarred;

  const NotificationItem({
    required this.name,
    required this.message,
    required this.time,
    required this.avatarUrl,
    this.isStarred = false,
  });
}

// --- Sample Data ---
const _todayNotifications = [
  NotificationItem(
    name: 'Sandra P',
    message: 'Please Note That Today Will Be A Half-Day Of Classes.',
    time: '2h',
    avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    isStarred: true,
  ),
];

const _yesterdayNotifications = [
  NotificationItem(
    name: 'Sandra P',
    message: 'Please Note That Today Will Be A Half-Day Of Classes.',
    time: '24h',
    avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
  ),
  NotificationItem(
    name: 'Sneha P',
    message: 'Please Note That Today Will Be A Half-Day Of Classes.',
    time: '24h',
    avatarUrl: 'https://randomuser.me/api/portraits/women/65.jpg',
  ),
  NotificationItem(
    name: 'Sameera P',
    message: 'Please Note That Today Will Be A Half-Day Of Classes.',
    time: '24h',
    avatarUrl: 'https://randomuser.me/api/portraits/women/68.jpg',
  ),
  NotificationItem(
    name: 'Sandra P',
    message: 'Please Note That Today Will Be A Half-Day Of Classes.',
    time: '24h',
    avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
  ),
  NotificationItem(
    name: 'Sandra P',
    message: 'Please Note That Today Will Be A Half-Day Of Classes.',
    time: '24h',
    avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
  ),
  NotificationItem(
    name: 'Sandra P',
    message: 'Please Note That Today Will Be A Half-Day Of Classes.',
    time: '24h',
    avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
  ),
];

// --- Main Screen ---
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationsScreen> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildSectionHeader('Today'),
          ..._todayNotifications.map(_buildNotificationTile),
          const SizedBox(height: 8),
          _buildSectionHeader('Yesterday'),
          ..._yesterdayNotifications.map(_buildNotificationTile),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildNotificationTile(NotificationItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(item.avatarUrl),
          ),
          const SizedBox(width: 12),
          // Text
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 13.5,
                  color: Colors.black87,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: '${item.name} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item.message),
                  TextSpan(
                    text: '  ${item.time}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          // Star icon
          if (item.isStarred)
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.star, color: Colors.amber, size: 22),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(icon: Icons.home_outlined, index: 0),
          _navItem(icon: Icons.school_outlined, label: 'Student', index: 1),
          _navItem(icon: Icons.notifications_outlined, label: 'Notification', index: 2, isActive: true),
          _navItem(icon: Icons.settings_outlined, index: 3),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    String? label,
    required int index,
    bool isActive = false,
  }) {
    final active = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: label != null
            ? const EdgeInsets.symmetric(horizontal: 14, vertical: 8)
            : const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF6C63FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            if (label != null && active) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}