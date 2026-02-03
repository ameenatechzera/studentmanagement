import 'package:flutter/material.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.80,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerSection(),
            const SizedBox(height: 10),
            _accountSwitchSection(),
            const Divider(height: 30),
            _menuItem(Icons.home_rounded, "Home", () {}),
            _menuItem(Icons.person_outline, "Profile", () {}),
            _menuItem(Icons.notifications_none, "Notifications", () {}),
            _menuItem(Icons.settings_outlined, "Settings", () {}),
            const Spacer(),
            const Divider(),
            _menuItem(Icons.logout, "Logout", () {}),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // 🔷 Welcome Header
  Widget _headerSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundImage:
            NetworkImage("https://randomuser.me/api/portraits/men/32.jpg"),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome",
                  style: TextStyle(fontSize: 13, color: Colors.grey)),
              SizedBox(height: 4),
              Text("Haris Rahman",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
    );
  }

  // 🔷 Account Switch Area
  Widget _accountSwitchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Account Switch",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _accountTile(
            name: "Asim",
            imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
            isSelected: true,
          ),
          const SizedBox(height: 10),
          _accountTile(
            name: "Anna",
            imageUrl: "https://randomuser.me/api/portraits/women/44.jpg",
          ),
          const SizedBox(height: 12),
          _addAccountButton(),
        ],
      ),
    );
  }

  // 🔷 Account Card
  Widget _accountTile({
    required String name,
    required String imageUrl,
    bool isSelected = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.pinkAccent : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          const SizedBox(width: 14),
          Text(name,
              style:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // 🔷 Add Account Button
  Widget _addAccountButton() {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.black,
            child: Icon(Icons.add, color: Colors.white, size: 18),
          ),
          SizedBox(width: 12),
          Text("Add Account",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // 🔷 Menu Item
  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[800]),
      title: Text(title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
      onTap: onTap,
      horizontalTitleGap: 10,
    );
  }
}
