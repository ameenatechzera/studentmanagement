// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class PostCard extends StatelessWidget {
//   const PostCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Top row
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 16,
//                   backgroundImage: NetworkImage(
//                     "https://i.pravatar.cc/150?img=5",
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 const Expanded(
//                   child: Text(
//                     "Anna T",
//                     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//                   ),
//                 ),
//                 Text(
//                   "12 Minutes Ago",
//                   style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
//                 ),
//               ],
//             ),
//           ),

//           // Image
//           ClipRRect(
//             borderRadius: BorderRadius.circular(12),
//             child: Image.network(
//               "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b",
//               height: 200,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),

//           // Title + Like
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               children: const [
//                 Expanded(
//                   child: Text(
//                     "Annual Cultural Program",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//                 Icon(Icons.favorite_border),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/home_screen/domain/entities/fetchfeed_entity.dart';

class PostCard extends StatelessWidget {
  final FeedDetails feed;

  const PostCard({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final imageUrl = feed.files != null && feed.files!.isNotEmpty
        ? feed.files!.first.image
        : null;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top Row
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    "https://i.pravatar.cc/150?img=5",
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    feed.createdUser ?? "Admin",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  feed.createdTime ?? "",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          /// 🔹 Image (only if exists)
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

          /// 🔹 Text
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    feed.feedText ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(Icons.favorite_border),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
