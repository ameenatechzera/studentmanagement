import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/chat/presentation/screens/chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final List<Map<String, dynamic>> chats = [
    {
      "name": "Sandra p",
      "message": "i will talk later",
      "time": "03:10 Pm",
      "count": 5,
      "image": "assets/images/profile_photo_sample_3.webp",
    },
    {
      "name": "Sandra p",
      "message": "i will talk later",
      "time": "03:10 Pm",
      "count": 8,
      "image": "assets/images/profile_photo_sample_3.webp",
    },
    {
      "name": "Sandra p",
      "message": "i will talk later",
      "time": "03:10 Pm",
      "count": 3,
      "image": "assets/images/profile_photo_sample_3.webp",
    },
    {
      "name": "Sandra p",
      "message": "i will talk later",
      "time": "03:10 Pm",
      "count": 1,
      "image": "assets/images/profile_photo_sample_3.webp",
    },
    {
      "name": "Sandra p",
      "message": "i will talk later",
      "time": "03:10 Pm",
      "count": 5,
      "image": "assets/images/profile_photo_sample_3.webp",
    },
    {
      "name": "Sandra p",
      "message": "i will talk later",
      "time": "03:10 Pm",
      "count": 5,
      "image": "assets/images/profile_photo_sample_3.webp",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,

        title: Text(
          'Chat',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child:
            /// Chat List
            Expanded(
              child: ListView.separated(
                itemCount: chats.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final chat = chats[index];

                  return ListTile(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) {
                      //       return ChatDetailScreen();
                      //     },
                      //   ),
                      // );
                    },
                    contentPadding: EdgeInsets.zero,

                    /// Profile Image
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(chat["image"]),
                    ),

                    /// Name & Message
                    title: Row(
                      children: [
                        Text(
                          chat["name"],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          "(class teacher)",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),

                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Text(
                            chat["message"],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(width: 10),
                          const Icon(
                            Icons.done_all,
                            size: 16,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ),

                    /// Time & Count
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chat["time"],
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Color(0xff7B61FF),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${chat["count"]}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
      ),
    );
  }
}
