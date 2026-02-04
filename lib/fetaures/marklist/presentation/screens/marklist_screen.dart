import 'package:flutter/material.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/marklist/presentation/screens/marklist_expansion_screen.dart';

class MarkListScreen extends StatelessWidget {
  const MarkListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text('MarkList')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            height: 80,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,

              // LEFT ICON
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.green.shade100,
                child: Icon(
                  Icons.description, // document icon
                  color: Colors.black,
                ),
              ),

              // TITLE
              title: const Text(
                "Onam Exam",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              // RIGHT ICON
              trailing: CircleAvatar(
                radius: 12,
                backgroundColor: const Color(0xFFC4005F),
                child: Icon(Icons.download, size: 10, color: Colors.white),
              ),

              onTap: () {
                AppNavigator.pushSlide(
                  context: context,
                  page: MarklistExpansionScreen(),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: 10,
      ),
    );
  }
}
