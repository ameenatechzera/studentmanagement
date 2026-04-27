import 'package:flutter/material.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    print("PROFILE URL 👉 ${AppData.profileUrl}");
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage:
                (AppData.profileUrl != null && AppData.profileUrl!.isNotEmpty)
                ? NetworkImage(AppData.profileUrl!)
                : null,
            child: (AppData.profileUrl == null || AppData.profileUrl!.isEmpty)
                ? ClipOval(
                    child: Image.asset(
                      getGenderImage(),
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  )
                : null,
            // child: (AppData.profileUrl == null || AppData.profileUrl!.isEmpty)
            //     ? const Icon(Icons.person)
            //     : null,
            //backgroundImage: NetworkImage(AppData.profileUrl ?? ''),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome", style: TextStyle(fontSize: 14)),
                SizedBox(height: 2),
                Text(
                  AppData.studentName ?? 'No Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    //color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              const Icon(
                Icons.notifications_none,
                size: 28,
                // color: Colors.white,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getGenderImage() {
    final g = (AppData.gender ?? '').toLowerCase().trim();

    if (g == 'male') {
      return "assets/icons/c0d90970-7626-47b6-a097-ca0834c7a05f_removalai_preview.png";
    } else if (g == 'female') {
      return "assets/icons/1f5debb8-6e36-4d25-bde8-526f4dd89820_removalai_preview.png";
    } else {
      return "assets/icons/c0d90970-7626-47b6-a097-ca0834c7a05f_removalai_preview.png";
    }
  }
}
