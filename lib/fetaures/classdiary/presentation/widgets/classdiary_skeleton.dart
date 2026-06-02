import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

class AllClassDiarySkeleton extends StatelessWidget {
  const AllClassDiarySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(26),
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F9),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔹 LEFT SIDE (Title + Subtitle)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.white,
                        ),

                        const SizedBox(height: 8),

                        /// Subtitle (short preview)
                        Container(height: 14, width: 120, color: Colors.white),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                /// 🔹 RIGHT SIDE (Date + Arrow)
                Column(
                  children: [
                    Container(height: 14, width: 60, color: Colors.white),
                    const SizedBox(height: 10),
                    Container(
                      height: 18,
                      width: 18,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> downloadFile(BuildContext context, String url) async {
    try {
      /// STORAGE PERMISSION
      await Permission.storage.request();

      final dio = Dio();

      /// FILE NAME
      final fileName = url.split('/').last;

      /// SAVE DIRECTORY
      Directory? directory;

      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      final filePath = "${directory!.path}/$fileName";

      /// DOWNLOAD
      await dio.download(url, filePath);

      /// SUCCESS MESSAGE
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$fileName downloaded successfully")),
      );

      /// OPEN FILE
      await OpenFilex.open(filePath);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Download failed: $e")));
    }
  }
}
