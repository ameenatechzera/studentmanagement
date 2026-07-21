// import 'dart:typed_data';
// import 'dart:io';
//
// import 'package:audioplayers/audioplayers.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:photo_manager/photo_manager.dart';
// import 'package:record/record.dart';
//
// class ChatDetailScreen extends StatefulWidget {
//   const ChatDetailScreen({super.key});
//
//   @override
//   State<ChatDetailScreen> createState() => _ChatDetailScreenState();
// }
//
// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   final TextEditingController messageController = TextEditingController();
//   final FocusNode focusNode = FocusNode();
//
//   final AudioRecorder audioRecorder = AudioRecorder();
//   final AudioPlayer audioPlayer = AudioPlayer();
//
//   bool showEmoji = false;
//   bool showGallery = false;
//   bool isGalleryLoading = false;
//   bool showImagePreview = false;
//   bool isRecording = false;
//
//   String? playingAudioPath;
//
//   List<AssetEntity> galleryAssets = [];
//   List<AssetEntity> selectedImages = [];
//
//   final List<Map<String, dynamic>> messages = [
//     {
//       "message": "Hii",
//       "isMe": false,
//       "time": "03:10 Pm",
//       "images": [],
//       "audio": null,
//     },
//     {
//       "message": "Hii",
//       "isMe": true,
//       "time": "03:10 Pm",
//       "images": [],
//       "audio": null,
//     },
//     {
//       "message": "How Are U ?",
//       "isMe": false,
//       "time": "03:10 Pm",
//       "images": [],
//       "audio": null,
//     },
//     {
//       "message": "Fine",
//       "isMe": true,
//       "time": "03:10 Pm",
//       "images": [],
//       "audio": null,
//     },
//   ];
//
//   bool get canSend =>
//       messageController.text.trim().isNotEmpty || selectedImages.isNotEmpty;
//
//   @override
//   void dispose() {
//     messageController.dispose();
//     focusNode.dispose();
//     audioRecorder.dispose();
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//   Future<void> openGalleryPanel() async {
//     FocusScope.of(context).unfocus();
//
//     setState(() {
//       showEmoji = false;
//       showGallery = true;
//       isGalleryLoading = true;
//     });
//
//     final PermissionState permission =
//         await PhotoManager.requestPermissionExtend();
//
//     if (!permission.isAuth && !permission.hasAccess) {
//       setState(() {
//         isGalleryLoading = false;
//       });
//       PhotoManager.openSetting();
//       return;
//     }
//
//     final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
//       type: RequestType.image,
//       onlyAll: true,
//     );
//
//     if (albums.isNotEmpty) {
//       final List<AssetEntity> assets = await albums.first.getAssetListPaged(
//         page: 0,
//         size: 100,
//       );
//
//       setState(() {
//         galleryAssets = assets;
//         isGalleryLoading = false;
//       });
//     } else {
//       setState(() {
//         galleryAssets = [];
//         isGalleryLoading = false;
//       });
//     }
//   }
//
//   Future<void> startRecording() async {
//     final bool hasPermission = await audioRecorder.hasPermission();
//
//     if (!hasPermission) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Microphone permission denied")),
//       );
//       return;
//     }
//
//     final Directory dir = await getTemporaryDirectory();
//
//     final String path =
//         "${dir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.m4a";
//
//     await audioRecorder.start(
//       const RecordConfig(
//         encoder: AudioEncoder.aacLc,
//         bitRate: 128000,
//         sampleRate: 44100,
//       ),
//       path: path,
//     );
//
//     setState(() {
//       isRecording = true;
//       showEmoji = false;
//       showGallery = false;
//     });
//   }
//
//   Future<void> stopRecordingAndSend() async {
//     final String? path = await audioRecorder.stop();
//
//     setState(() {
//       isRecording = false;
//     });
//
//     if (path != null && File(path).existsSync()) {
//       setState(() {
//         messages.add({
//           "message": "",
//           "isMe": true,
//           "time": "Now",
//           "images": [],
//           "audio": path,
//         });
//       });
//     }
//   }
//
//   Future<void> playAudio(String path) async {
//     if (playingAudioPath == path) {
//       await audioPlayer.stop();
//
//       setState(() {
//         playingAudioPath = null;
//       });
//
//       return;
//     }
//
//     await audioPlayer.stop();
//     await audioPlayer.play(DeviceFileSource(path));
//
//     setState(() {
//       playingAudioPath = path;
//     });
//
//     audioPlayer.onPlayerComplete.listen((event) {
//       if (mounted) {
//         setState(() {
//           playingAudioPath = null;
//         });
//       }
//     });
//   }
//
//   void sendMessage() {
//     final String text = messageController.text.trim();
//
//     if (isRecording) {
//       stopRecordingAndSend();
//       return;
//     }
//
//     if (text.isEmpty && selectedImages.isEmpty) {
//       startRecording();
//       return;
//     }
//
//     setState(() {
//       messages.add({
//         "message": text,
//         "isMe": true,
//         "time": "Now",
//         "images": List<AssetEntity>.from(selectedImages),
//         "audio": null,
//       });
//
//       messageController.clear();
//       selectedImages.clear();
//       showImagePreview = false;
//       showGallery = false;
//       showEmoji = false;
//     });
//   }
//
//   void closePanels() {
//     FocusScope.of(context).unfocus();
//     setState(() {
//       showEmoji = false;
//       showGallery = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (showImagePreview && selectedImages.isNotEmpty) {
//       return Scaffold(
//         backgroundColor: const Color(0xff1F1F1F),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               Positioned.fill(
//                 child: PageView.builder(
//                   itemCount: selectedImages.length,
//                   itemBuilder: (context, index) {
//                     return FutureBuilder<Uint8List?>(
//                       future: selectedImages[index].thumbnailDataWithSize(
//                         const ThumbnailSize(1200, 1200),
//                       ),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return const Center(
//                             child: CircularProgressIndicator(
//                               color: Color(0xff8F82FF),
//                             ),
//                           );
//                         }
//
//                         return Center(
//                           child: Image.memory(
//                             snapshot.data!,
//                             fit: BoxFit.contain,
//                             width: double.infinity,
//                             height: double.infinity,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               Positioned(
//                 top: 12,
//                 left: 12,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       showImagePreview = false;
//                     });
//                   },
//                   child: Container(
//                     height: 42,
//                     width: 42,
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(.45),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(Icons.close, color: Colors.white),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 18,
//                 right: 18,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 7,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(.45),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     "${selectedImages.length} Selected",
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: 12,
//                 right: 12,
//                 bottom: 14,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 52,
//                         padding: const EdgeInsets.symmetric(horizontal: 14),
//                         decoration: BoxDecoration(
//                           color: const Color(0xff1F1F1F),
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(
//                               Icons.sentiment_satisfied_alt,
//                               color: Colors.white70,
//                             ),
//                             const SizedBox(width: 10),
//                             Expanded(
//                               child: TextField(
//                                 controller: messageController,
//                                 style: const TextStyle(color: Colors.white),
//                                 cursorColor: Color(0xff8F82FF),
//                                 decoration: const InputDecoration(
//                                   hintText: "Add Caption",
//                                   hintStyle: TextStyle(color: Colors.white54),
//                                   border: InputBorder.none,
//                                 ),
//                                 onChanged: (_) {
//                                   setState(() {});
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Container(
//                       height: 52,
//                       width: 52,
//                       decoration: const BoxDecoration(
//                         color: Color(0xff8F82FF),
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         onPressed: sendMessage,
//                         icon: const Icon(
//                           Icons.send_rounded,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//
//     return GestureDetector(
//       onTap: closePanels,
//       child: Scaffold(
//         resizeToAvoidBottomInset: true,
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(85),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             automaticallyImplyLeading: false,
//             flexibleSpace: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Icon(
//                         Icons.arrow_back_ios,
//                         size: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     const CircleAvatar(
//                       radius: 22,
//                       backgroundImage: AssetImage(
//                         "assets/images/profile_photo_sample_3.webp",
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     const Expanded(
//                       child: Text(
//                         "Sandra p (class teacher)",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         body: Stack(
//           children: [
//             Positioned.fill(
//               child: Opacity(
//                 opacity: 0.9,
//                 child: Image.asset(
//                   "assets/images/ChatGPT Image May 19, 2026, 04_41_29 PM 1 (1).png",
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 20,
//                     ),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final message = messages[index];
//
//                       final List<AssetEntity> messageImages =
//                           List<AssetEntity>.from(message["images"] ?? []);
//
//                       final bool hasImages = messageImages.isNotEmpty;
//                       final bool hasText = message["message"]
//                           .toString()
//                           .trim()
//                           .isNotEmpty;
//
//                       final String? audioPath = message["audio"];
//                       final bool hasAudio = audioPath != null;
//
//                       return Align(
//                         alignment: message["isMe"]
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Container(
//                           margin: const EdgeInsets.only(bottom: 14),
//                           constraints: BoxConstraints(
//                             maxWidth: MediaQuery.of(context).size.width * .74,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: message["isMe"]
//                                 ? CrossAxisAlignment.end
//                                 : CrossAxisAlignment.start,
//                             children: [
//                               if (hasImages)
//                                 Wrap(
//                                   spacing: 4,
//                                   runSpacing: 4,
//                                   children: messageImages.map((image) {
//                                     return FutureBuilder<Uint8List?>(
//                                       future: image.thumbnailDataWithSize(
//                                         const ThumbnailSize(700, 700),
//                                       ),
//                                       builder: (context, snapshot) {
//                                         if (!snapshot.hasData) {
//                                           return Container(
//                                             height: 160,
//                                             width: 160,
//                                             decoration: BoxDecoration(
//                                               color: Colors.grey.shade300,
//                                               borderRadius:
//                                                   BorderRadius.circular(18),
//                                             ),
//                                           );
//                                         }
//
//                                         return ClipRRect(
//                                           borderRadius: BorderRadius.circular(
//                                             18,
//                                           ),
//                                           child: Image.memory(
//                                             snapshot.data!,
//                                             fit: BoxFit.cover,
//                                             height: messageImages.length == 1
//                                                 ? 260
//                                                 : 120,
//                                             width: messageImages.length == 1
//                                                 ? 220
//                                                 : 120,
//                                           ),
//                                         );
//                                       },
//                                     );
//                                   }).toList(),
//                                 ),
//
//                               if (hasAudio)
//                                 Container(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 12,
//                                     vertical: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: message["isMe"]
//                                         ? const Color(0xff8F82FF)
//                                         : Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: const Radius.circular(22),
//                                       topRight: const Radius.circular(22),
//                                       bottomLeft: Radius.circular(
//                                         message["isMe"] ? 22 : 5,
//                                       ),
//                                       bottomRight: Radius.circular(
//                                         message["isMe"] ? 5 : 22,
//                                       ),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(.04),
//                                         blurRadius: 10,
//                                         offset: const Offset(0, 3),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () => playAudio(audioPath),
//                                         child: Icon(
//                                           playingAudioPath == audioPath
//                                               ? Icons.stop_circle_rounded
//                                               : Icons.play_circle_fill_rounded,
//                                           color: message["isMe"]
//                                               ? Colors.white
//                                               : const Color(0xff8F82FF),
//                                           size: 34,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 8),
//                                       Text(
//                                         "Voice message",
//                                         style: TextStyle(
//                                           color: message["isMe"]
//                                               ? Colors.white
//                                               : Colors.black87,
//                                           fontSize: 13,
//                                         ),
//                                       ),
//                                       const SizedBox(width: 10),
//                                       Text(
//                                         message["time"],
//                                         style: TextStyle(
//                                           fontSize: 9,
//                                           color: message["isMe"]
//                                               ? Colors.white70
//                                               : Colors.grey,
//                                         ),
//                                       ),
//                                       if (message["isMe"]) ...[
//                                         const SizedBox(width: 4),
//                                         const Icon(
//                                           Icons.done_all,
//                                           size: 14,
//                                           color: Colors.white70,
//                                         ),
//                                       ],
//                                     ],
//                                   ),
//                                 ),
//
//                               if (hasText)
//                                 Container(
//                                   margin: EdgeInsets.only(
//                                     top: hasImages ? 8 : 0,
//                                   ),
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 14,
//                                     vertical: 10,
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: message["isMe"]
//                                         ? const Color(0xff8F82FF)
//                                         : Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: const Radius.circular(18),
//                                       topRight: const Radius.circular(18),
//                                       bottomLeft: Radius.circular(
//                                         message["isMe"] ? 18 : 5,
//                                       ),
//                                       bottomRight: Radius.circular(
//                                         message["isMe"] ? 5 : 18,
//                                       ),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black.withOpacity(.04),
//                                         blurRadius: 10,
//                                         offset: const Offset(0, 3),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         message["message"],
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           height: 1.4,
//                                           color: message["isMe"]
//                                               ? Colors.white
//                                               : Colors.black87,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 4),
//                                       Row(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Text(
//                                             message["time"],
//                                             style: TextStyle(
//                                               fontSize: 9,
//                                               color: message["isMe"]
//                                                   ? Colors.white70
//                                                   : Colors.grey,
//                                             ),
//                                           ),
//                                           if (message["isMe"]) ...[
//                                             const SizedBox(width: 4),
//                                             const Icon(
//                                               Icons.done_all,
//                                               size: 14,
//                                               color: Colors.white70,
//                                             ),
//                                           ],
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//
//                               if (hasImages && !hasText)
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                     top: 5,
//                                     left: 5,
//                                     right: 5,
//                                   ),
//                                   child: Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         message["time"],
//                                         style: TextStyle(
//                                           fontSize: 10,
//                                           color: Colors.grey.shade700,
//                                         ),
//                                       ),
//                                       if (message["isMe"]) ...[
//                                         const SizedBox(width: 4),
//                                         Icon(
//                                           Icons.done_all,
//                                           size: 15,
//                                           color: Colors.grey.shade700,
//                                         ),
//                                       ],
//                                     ],
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//                 if (isRecording)
//                   Container(
//                     margin: const EdgeInsets.only(bottom: 8),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.red.withOpacity(.12),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.fiber_manual_record,
//                           color: Colors.red,
//                           size: 14,
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           "Recording... tap stop to send",
//                           style: TextStyle(
//                             color: Colors.red,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 if (showGallery)
//                   Container(
//                     height: MediaQuery.of(context).size.height * .48,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(28),
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         const SizedBox(height: 12),
//                         Container(
//                           width: 45,
//                           height: 5,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         const SizedBox(height: 18),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               "Gallery",
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             const SizedBox(width: 5),
//                             Icon(
//                               Icons.keyboard_arrow_down_rounded,
//                               color: Colors.grey.shade700,
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 18),
//                         Expanded(
//                           child: isGalleryLoading
//                               ? const Center(
//                                   child: CircularProgressIndicator(
//                                     color: Color(0xff8F82FF),
//                                   ),
//                                 )
//                               : galleryAssets.isEmpty
//                               ? const Center(child: Text("No images found"))
//                               : GridView.builder(
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: 14,
//                                   ),
//                                   itemCount: galleryAssets.length,
//                                   gridDelegate:
//                                       const SliverGridDelegateWithFixedCrossAxisCount(
//                                         crossAxisCount: 3,
//                                         crossAxisSpacing: 3,
//                                         mainAxisSpacing: 3,
//                                       ),
//                                   itemBuilder: (context, index) {
//                                     final AssetEntity asset =
//                                         galleryAssets[index];
//
//                                     final bool isSelected = selectedImages.any(
//                                       (e) => e.id == asset.id,
//                                     );
//
//                                     final int selectedIndex = selectedImages
//                                         .indexWhere((e) => e.id == asset.id);
//
//                                     return GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           if (isSelected) {
//                                             selectedImages.removeWhere(
//                                               (e) => e.id == asset.id,
//                                             );
//                                           } else {
//                                             selectedImages.add(asset);
//                                           }
//                                         });
//                                       },
//                                       child: FutureBuilder<Uint8List?>(
//                                         future: asset.thumbnailDataWithSize(
//                                           const ThumbnailSize(300, 300),
//                                         ),
//                                         builder: (context, snapshot) {
//                                           if (!snapshot.hasData) {
//                                             return Container(
//                                               color: Colors.grey.shade200,
//                                             );
//                                           }
//
//                                           return Stack(
//                                             children: [
//                                               Positioned.fill(
//                                                 child: Image.memory(
//                                                   snapshot.data!,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                               Positioned(
//                                                 top: 6,
//                                                 right: 6,
//                                                 child: Container(
//                                                   height: 24,
//                                                   width: 24,
//                                                   decoration: BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: isSelected
//                                                         ? const Color(
//                                                             0xff8F82FF,
//                                                           )
//                                                         : Colors.black
//                                                               .withOpacity(.25),
//                                                     border: Border.all(
//                                                       color: Colors.white,
//                                                       width: 2,
//                                                     ),
//                                                   ),
//                                                   child: isSelected
//                                                       ? Center(
//                                                           child: Text(
//                                                             "${selectedIndex + 1}",
//                                                             style:
//                                                                 const TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                 ),
//                                                           ),
//                                                         )
//                                                       : null,
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   },
//                                 ),
//                         ),
//                         if (selectedImages.isNotEmpty)
//                           Padding(
//                             padding: const EdgeInsets.all(12),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xff8F82FF),
//                                 minimumSize: const Size(double.infinity, 48),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(24),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 setState(() {
//                                   showGallery = false;
//                                   showImagePreview = true;
//                                 });
//                               },
//                               child: Text(
//                                 "Next (${selectedImages.length})",
//                                 style: const TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//
//                 SafeArea(
//                   top: false,
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       left: 14,
//                       right: 14,
//                       bottom: 12,
//                       top: 5,
//                     ),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: 58,
//                             padding: const EdgeInsets.symmetric(horizontal: 14),
//                             decoration: BoxDecoration(
//                               color: const Color(0xff1F1F1F),
//                               borderRadius: BorderRadius.circular(35),
//                             ),
//                             child: Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     FocusScope.of(context).unfocus();
//                                     setState(() {
//                                       showEmoji = !showEmoji;
//                                       showGallery = false;
//                                     });
//                                   },
//                                   child: const Icon(
//                                     Icons.sentiment_satisfied_alt,
//                                     color: Colors.white70,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Expanded(
//                                   child: TextField(
//                                     controller: messageController,
//                                     focusNode: focusNode,
//                                     enabled: !isRecording,
//                                     onTap: () {
//                                       setState(() {
//                                         showEmoji = false;
//                                         showGallery = false;
//                                       });
//                                     },
//                                     onChanged: (_) {
//                                       setState(() {});
//                                     },
//                                     style: const TextStyle(color: Colors.white),
//                                     cursorColor: const Color(0xff8F82FF),
//                                     decoration: InputDecoration(
//                                       hintText: isRecording
//                                           ? "Recording..."
//                                           : "Message",
//                                       hintStyle: const TextStyle(
//                                         color: Colors.white54,
//                                       ),
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   onPressed: isRecording
//                                       ? null
//                                       : openGalleryPanel,
//                                   icon: Icon(
//                                     showGallery
//                                         ? Icons.close_rounded
//                                         : Icons.link,
//                                     color: isRecording
//                                         ? Colors.white24
//                                         : Colors.white70,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         AnimatedContainer(
//                           duration: const Duration(milliseconds: 250),
//                           height: 58,
//                           width: 58,
//                           decoration: const BoxDecoration(
//                             color: Color(0xff1F1F1F),
//                             shape: BoxShape.circle,
//                           ),
//                           child: IconButton(
//                             onPressed: sendMessage,
//                             icon: Icon(
//                               isRecording
//                                   ? Icons.stop_rounded
//                                   : canSend
//                                   ? Icons.send_rounded
//                                   : Icons.mic_none_rounded,
//                               color: isRecording || canSend
//                                   ? const Color(0xff8F82FF)
//                                   : Colors.white,
//                               size: 26,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Offstage(
//                   offstage: !showEmoji,
//                   child: SizedBox(
//                     height: 320,
//                     child: EmojiPicker(
//                       textEditingController: messageController,
//                       onEmojiSelected: (category, emoji) {
//                         setState(() {});
//                       },
//                       config: Config(
//                         height: 320,
//                         checkPlatformCompatibility: true,
//                         emojiViewConfig: const EmojiViewConfig(
//                           emojiSizeMax: 28,
//                           backgroundColor: Color(0xff121212),
//                         ),
//                         categoryViewConfig: const CategoryViewConfig(
//                           backgroundColor: Color(0xff1F1F1F),
//                           iconColor: Colors.white54,
//                           iconColorSelected: Color(0xff8F82FF),
//                           indicatorColor: Color(0xff8F82FF),
//                         ),
//                         bottomActionBarConfig: const BottomActionBarConfig(
//                           enabled: false,
//                         ),
//                         searchViewConfig: const SearchViewConfig(
//                           backgroundColor: Color(0xff121212),
//                         ),
//                         skinToneConfig: const SkinToneConfig(
//                           dialogBackgroundColor: Color(0xff1F1F1F),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
