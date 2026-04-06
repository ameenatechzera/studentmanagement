import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              AppData.profileUrl!,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome", style: TextStyle(fontSize: 14)),
                SizedBox(height: 2),
                Text(
                  AppData.studentName!,
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
}
