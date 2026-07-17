// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:studentmanagement/fetaures/materials/domain/entities/materialsBySubject_entity.dart';
// import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_materialsbysubjectId.dart';
// import 'package:studentmanagement/fetaures/materials/presentation/widgets/materialNotes.dart';
// import 'package:studentmanagement/fetaures/materials/presentation/widgets/pdfViewer_screen.dart';
// import 'package:studentmanagement/services/shared_preference_helper.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:studentmanagement/core/appdata/appdata.dart';
// import 'package:studentmanagement/fetaures/materials/domain/entities/fetch_material_entity.dart';
// import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_material_parameter.dart';
// import 'package:studentmanagement/fetaures/materials/presentation/cubit/material_cubit.dart';

// // ---------- Main Page ----------
// class MaterialListPage extends StatefulWidget {
//   final String subjectName;
//   final String subjectId;

//   const MaterialListPage({
//     super.key,
//     required this.subjectName,
//     required this.subjectId,
//   });

//   @override
//   State<MaterialListPage> createState() => _MaterialListPageState();
// }

// class _MaterialListPageState extends State<MaterialListPage>
//     with SingleTickerProviderStateMixin {
//   final List<String> tabs = ["Files", "Links", "Notes"];
//   final TextEditingController searchController = TextEditingController();
//   String searchQuery = "";

//   late TabController _tabController;

//   List<MaterialList> allMaterials = [];
//   final Set<int> bookmarkedIds = {};

//   @override
//   void initState() {
//     super.initState();
//     print('SubjectIdFromSubjectList ${widget.subjectId}');
//     _tabController = TabController(length: tabs.length, vsync: this);
//     _tabController.addListener(() => setState(() {}));

//     context.read<MaterialCubit>().fetchMaterialsBySubjectId(
//       FetchMaterialBySubjectIdParameter(
//         branchId: 1,
//         userId: '1',
//         subjectId: widget.subjectId,
//         standardId: AppData.studentStdId!,
//         divisionId: AppData.studentDivId!,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     searchController.dispose();
//     super.dispose();
//   }

//   // ---------- Open URL in browser ----------
//   Future<void> _openUrl(String? url) async {
//     if (url == null || url.isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("No URL available")));
//       return;
//     }

//     final uri = Uri.tryParse(url);
//     if (uri == null) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Invalid URL")));
//       return;
//     }

//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Could not open the URL")));
//     }
//   }

//   // ----r by tab + search ----------
//   List<MaterialList> getFilteredList(String tab) {
//     return allMaterials.where((item) {
//       //final matchesSubject = item.subjectId == widget.subjectId;
//       print('item.subjectId ${item.subjectId}');
//       print('widget.subjectId ${widget.subjectId}');
//       final matchesSubject = true;
//       bool matchesTab = false;
//       if (tab == "PDF") {
//         matchesTab =
//             item.material?.toLowerCase() == "pdf" ||
//             (item.material != null && item.material!.isNotEmpty);
//       } else if (tab == "Links") {
//         matchesTab =
//             item.material?.toLowerCase() == "link" ||
//             (item.link != null && item.link!.isNotEmpty);
//       } else if (tab == "Notes") {
//         matchesTab =
//             item.material?.toLowerCase() == "notes" ||
//             (item.notes != null && item.notes!.isNotEmpty);
//       }

//       final displayName = _getDisplayName(item, tab);
//       final matchesSearch =
//           searchQuery.isEmpty ||
//           displayName.toLowerCase().contains(searchQuery.toLowerCase());

//       return matchesSubject && matchesTab && matchesSearch;
//     }).toList();
//   }

//   String _getDisplayName(MaterialList item, String tab) {
//     if (tab == "PDF") return item.material ?? "Unnamed Document";
//     if (tab == "Links") return item.link ?? "No Link";
//     if (tab == "Notes") return item.notes ?? "No Notes";
//     return item.material ?? "";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF4F6FB),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF4F6FB),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           "${widget.subjectName} Material",
//           style: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//       ),
//       body: BlocBuilder<MaterialCubit, MaterialsState>(
//         builder: (context, state) {
//           if (state is MaterialBySubjectLoaded) {
//             allMaterials = state.response;
//             for (final item in allMaterials) {
//               if (item.favorite == true && item.materialId != null) {
//                 bookmarkedIds.add(item.materialId!);
//               }
//             }
//           }

//           if (state is MaterialLoading && allMaterials.isEmpty) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (state is MaterialError && allMaterials.isEmpty) {
//             return const Center(child: Text("Failed to load materials"));
//           }

//           return Column(
//             children: [
//               const SizedBox(height: 8),

//               // ---------- Tab Switcher ----------
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Container(
//                   height: 48,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF1E1E2E),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: TabBar(
//                     controller: _tabController,
//                     indicator: BoxDecoration(
//                       color: const Color(0xFF7C6FCD),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     dividerColor: Colors.transparent,
//                     labelColor: Colors.white,
//                     unselectedLabelColor: Colors.white54,
//                     labelStyle: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 14,
//                     ),
//                     tabs: tabs.map((t) => Tab(text: t)).toList(),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // ---------- Search Bar ----------
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: TextField(
//                   controller: searchController,
//                   onChanged: (val) => setState(() => searchQuery = val),
//                   decoration: InputDecoration(
//                     hintText: "Search",
//                     hintStyle: TextStyle(color: Colors.grey.shade400),
//                     prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
//                     filled: true,
//                     fillColor: Colors.white,
//                     contentPadding: const EdgeInsets.symmetric(
//                       vertical: 12,
//                       horizontal: 16,
//                     ),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(14),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // ---------- List ----------
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: tabs.map((tab) {
//                     final list = getFilteredList(tab);
//                     return _buildList(list, tab);
//                   }).toList(),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildList(List<MaterialList> list, String tab) {
//     if (list.isEmpty) {
//       return Center(
//         child: Text(
//           "No $tab available",
//           style: TextStyle(color: Colors.grey.shade500),
//         ),
//       );
//     }

//     return ListView.separated(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       itemCount: list.length,
//       separatorBuilder: (_, __) => const SizedBox(height: 12),
//       itemBuilder: (context, index) {
//         final item = list[index];
//         final isBookmarked = bookmarkedIds.contains(item.materialId);
//         final displayName = _getDisplayName(item, tab);

//         return _MaterialCard(
//           title: displayName,
//           tab: tab,
//           isBookmarked: isBookmarked,
//           onBookmarkTap: () {
//             setState(() {
//               if (item.materialId != null) {
//                 if (isBookmarked) {
//                   bookmarkedIds.remove(item.materialId);
//                 } else {
//                   bookmarkedIds.add(item.materialId!);
//                 }
//               }
//             });
//           },
//           // ✅ Opens in browser based on tab type
//           onTap: () async {
//             if (tab == "PDF") {
//               // _openUrl(item.material);
//               final baseUrl = await SharedPreferenceHelper().getBaseUrl();
//               String? updatedUrl = baseUrl?.replaceAll("api/", "");
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) =>
//                       PdfViewerScreen(pdfUrl: updatedUrl! + item.material!),
//                 ),
//               );
//             } else if (tab == "Links") {
//               _openUrl(item.link);
//             } else if (tab == "Notes") {
//               // _openUrl(item.notes);
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => MaterialNotesScreen(noteData: item.notes),
//                 ),
//               );
//             }
//           },
//         );
//       },
//     );
//   }
// }

// // ---------- Material Card ----------
// class _MaterialCard extends StatelessWidget {
//   final String title;
//   final String tab;
//   final bool isBookmarked;
//   final VoidCallback onBookmarkTap;
//   final VoidCallback onTap;

//   const _MaterialCard({
//     required this.title,
//     required this.tab,
//     required this.isBookmarked,
//     required this.onBookmarkTap,
//     required this.onTap,
//   });

//   IconData get _tabIcon {
//     switch (tab) {
//       case "Links":
//         return Icons.link_rounded;
//       case "Notes":
//         return Icons.note_rounded;
//       default:
//         return Icons.picture_as_pdf_rounded;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap, // ✅ triggers browser open
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             // Icon
//             Container(
//               height: 44,
//               width: 44,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFECEBF8),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(_tabIcon, color: const Color(0xFF7C6FCD), size: 24),
//             ),
//             const SizedBox(width: 14),

//             // Title
//             Expanded(
//               child: Html(
//                 data: title.isEmpty ? 'No Description' : title,
//                 style: {
//                   "body": Style(
//                     margin: Margins.zero,
//                     padding: HtmlPaddings.zero,
//                     fontSize: FontSize(12),
//                     lineHeight: const LineHeight(1.7),
//                     color: Colors.black,
//                   ),
//                 },
//               ),
//               // Text(
//               //   title,
//               //   style: const TextStyle(
//               //     fontSize: 15,
//               //     fontWeight: FontWeight.w600,
//               //     color: Color(0xFF1E1E2E),
//               //   ),
//               //   maxLines: 2,
//               //   overflow: TextOverflow.ellipsis,
//               // ),
//             ),

//             // Bookmark
//             GestureDetector(
//               onTap: onBookmarkTap,
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 250),
//                 transitionBuilder: (child, animation) =>
//                     ScaleTransition(scale: animation, child: child),
//                 child: Icon(
//                   isBookmarked ? Icons.star_rounded : Icons.star_border_rounded,
//                   key: ValueKey(isBookmarked),
//                   color: isBookmarked
//                       ? const Color(0xFFFFC107)
//                       : Colors.grey.shade400,
//                   size: 26,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/materials/domain/entities/materialsBySubject_entity.dart';
import 'package:studentmanagement/fetaures/materials/domain/parameters/fetch_materialsbysubjectId.dart';
import 'package:studentmanagement/fetaures/materials/presentation/cubit/material_cubit.dart';
import 'package:studentmanagement/fetaures/materials/presentation/widgets/materialNotes.dart';
import 'package:studentmanagement/fetaures/materials/presentation/widgets/pdfViewer_screen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class MaterialListPage extends StatefulWidget {
  final String subjectName;
  final String subjectId;

  const MaterialListPage({
    super.key,
    required this.subjectName,
    required this.subjectId,
  });

  @override
  State<MaterialListPage> createState() => _MaterialListPageState();
}

class _MaterialListPageState extends State<MaterialListPage>
    with SingleTickerProviderStateMixin {
  final List<String> tabs = ["Files", "Links", "Notes"];
  final TextEditingController searchController = TextEditingController();

  String searchQuery = "";

  late TabController _tabController;

  List<MaterialList> allMaterials = [];
  final Set<int> bookmarkedIds = {};

  @override
  void initState() {
    super.initState();

    debugPrint('SubjectIdFromSubjectList ${widget.subjectId}');

    _tabController = TabController(length: tabs.length, vsync: this);

    _tabController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    context.read<MaterialCubit>().fetchMaterialsBySubjectId(
      FetchMaterialBySubjectIdParameter(
        branchId: 1,
        userId: '1',
        subjectId: widget.subjectId,
        standardId: AppData.studentStdId!,
        divisionId: AppData.studentDivId!,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> _openUrl(String? url) async {
    if (url == null || url.trim().isEmpty) {
      _showMessage("No URL available");
      return;
    }

    final Uri? uri = Uri.tryParse(url.trim());

    if (uri == null) {
      _showMessage("Invalid URL");
      return;
    }

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showMessage("Could not open the URL");
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  List<MaterialList> getFilteredList(String tab) {
    return allMaterials.where((item) {
      final bool matchesSubject = true;

      bool matchesTab = false;

      if (tab == "Files") {
        // final String filePath = item.material?.trim() ?? '';

        // matchesTab = filePath.isNotEmpty && _isSupportedFile(filePath);
        final String filePath = item.material.isNotEmpty
            ? item.material.first.trim()
            : '';

        matchesTab = filePath.isNotEmpty && _isSupportedFile(filePath);
      } else if (tab == "Links") {
        final String link = item.link?.trim() ?? '';

        matchesTab = link.isNotEmpty;
      } else if (tab == "Notes") {
        final String notes = item.notes?.trim() ?? '';

        matchesTab = notes.isNotEmpty;
      }

      final String displayName = _getDisplayName(item, tab);

      final bool matchesSearch =
          searchQuery.isEmpty ||
          displayName.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesSubject && matchesTab && matchesSearch;
    }).toList();
  }

  String _getDisplayName(MaterialList item, String tab) {
    if (tab == "Files") {
      return _fileNameOnly(
        item.material.isNotEmpty ? item.material.first : "Unnamed File",
      );
    }

    if (tab == "Links") {
      return item.link ?? "No Link";
    }

    if (tab == "Notes") {
      return item.notes ?? "No Notes";
    }

    return item.material.isNotEmpty ? item.material.first : "";
  }

  bool _isSupportedFile(String path) {
    return _isPdf(path) || _isImage(path);
  }

  bool _isPdf(String path) {
    final String cleanPath = _cleanPath(path);
    return cleanPath.endsWith('.pdf');
  }

  bool _isImage(String path) {
    final String cleanPath = _cleanPath(path);

    return cleanPath.endsWith('.png') ||
        cleanPath.endsWith('.jpg') ||
        cleanPath.endsWith('.jpeg') ||
        cleanPath.endsWith('.webp');
  }

  // String _cleanPath(String path) {
  //   return path.toLowerCase().split('?').first.trim();
  // }
  String _cleanPath(String path) {
    return path
        .replaceAll('"', '')
        .replaceAll('\\', '')
        .toLowerCase()
        .split('?')
        .first
        .trim();
  }

  String _fileNameOnly(String path) {
    final String cleanPath = path.split('?').first.trim();

    if (cleanPath.isEmpty) {
      return 'Unnamed File';
    }

    final List<String> parts = cleanPath.split('/');

    if (parts.isEmpty) {
      return cleanPath;
    }

    final String fileName = parts.last.trim();

    if (fileName.isEmpty) {
      return cleanPath;
    }

    try {
      return Uri.decodeComponent(fileName);
    } catch (_) {
      return fileName;
    }
  }

  // Future<String?> _makeFullFileUrl(String? filePath) async {
  //   if (filePath == null || filePath.trim().isEmpty) {
  //     return null;
  //   }

  //   final String trimmedFilePath = filePath.trim();

  //   if (trimmedFilePath.startsWith('http://') ||
  //       trimmedFilePath.startsWith('https://')) {
  //     return Uri.encodeFull(trimmedFilePath);
  //   }

  //   final String? baseUrl = await SharedPreferenceHelper().getBaseUrl();

  //   if (baseUrl == null || baseUrl.trim().isEmpty) {
  //     return null;
  //   }

  //   String updatedBaseUrl = baseUrl.trim().replaceAll("api/", "");

  //   if (!updatedBaseUrl.endsWith('/')) {
  //     updatedBaseUrl = '$updatedBaseUrl/';
  //   }

  //   final String cleanedFilePath = trimmedFilePath.startsWith('/')
  //       ? trimmedFilePath.substring(1)
  //       : trimmedFilePath;

  //   return Uri.encodeFull(updatedBaseUrl + cleanedFilePath);
  // }
  Future<String?> _makeFullFileUrl(String? filePath) async {
    if (filePath == null || filePath.trim().isEmpty) {
      return null;
    }

    // Remove unwanted quotes and backslashes
    String cleanedFilePath = filePath
        .trim()
        .replaceAll('"', '')
        .replaceAll('\\', '');

    // Already a full URL
    if (cleanedFilePath.startsWith('http://') ||
        cleanedFilePath.startsWith('https://')) {
      return Uri.encodeFull(cleanedFilePath);
    }

    final String? baseUrl = await SharedPreferenceHelper().getBaseUrl();

    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return null;
    }

    String updatedBaseUrl = baseUrl.trim().replaceAll("api/", "");

    if (!updatedBaseUrl.endsWith('/')) {
      updatedBaseUrl = '$updatedBaseUrl/';
    }

    if (cleanedFilePath.startsWith('/')) {
      cleanedFilePath = cleanedFilePath.substring(1);
    }

    return Uri.encodeFull(updatedBaseUrl + cleanedFilePath);
  }

  Future<void> _openFile(MaterialList item) async {
    final String? fileUrl = await _makeFullFileUrl(
      item.material.isNotEmpty ? item.material.first : null,
    );
    if (!mounted) return;

    if (fileUrl == null || fileUrl.trim().isEmpty) {
      _showMessage('File not available');
      return;
    }

    if (_isPdf(fileUrl)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PdfViewerScreen(pdfUrl: fileUrl)),
      );
      return;
    }

    if (_isImage(fileUrl)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MaterialImageViewerScreen(
            imageUrl: fileUrl,
            title: _fileNameOnly(
              item.material.isNotEmpty ? item.material.first : 'Image',
            ),
          ),
        ),
      );
      return;
    }

    _showMessage('Unsupported file type');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F6FB),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${widget.subjectName} Material",
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocBuilder<MaterialCubit, MaterialsState>(
        builder: (context, state) {
          if (state is MaterialBySubjectLoaded) {
            allMaterials = state.response;

            for (final item in allMaterials) {
              if (item.favorite == true && item.materialId != null) {
                bookmarkedIds.add(item.materialId!);
              }
            }
          }

          if (state is MaterialLoading && allMaterials.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MaterialError && allMaterials.isEmpty) {
            return const Center(child: Text("Failed to load materials"));
          }

          return Column(
            children: [
              const SizedBox(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E2E),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: const Color(0xFF7C6FCD),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white54,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    tabs: tabs.map((tab) {
                      return Tab(text: tab);
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: tabs.map((tab) {
                    final List<MaterialList> list = getFilteredList(tab);

                    return _buildList(list, tab);
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(List<MaterialList> list, String tab) {
    if (list.isEmpty) {
      return Center(
        child: Text(
          "No $tab available",
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: list.length,
      separatorBuilder: (_, __) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        final MaterialList item = list[index];

        final bool isBookmarked = bookmarkedIds.contains(item.materialId);
        final String displayName = _getDisplayName(item, tab);

        return _MaterialCard(
          title: displayName,
          tab: tab,
          filePath: item.material.isNotEmpty ? item.material.first : null,
          isBookmarked: isBookmarked,
          onBookmarkTap: () {
            setState(() {
              if (item.materialId != null) {
                if (isBookmarked) {
                  bookmarkedIds.remove(item.materialId);
                } else {
                  bookmarkedIds.add(item.materialId!);
                }
              }
            });
          },
          onTap: () async {
            if (tab == "Files") {
              await _openFile(item);
            } else if (tab == "Links") {
              await _openUrl(item.link);
            } else if (tab == "Notes") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MaterialNotesScreen(noteData: item.notes),
                ),
              );
            }
          },
        );
      },
    );
  }
}

class _MaterialCard extends StatelessWidget {
  final String title;
  final String tab;
  final String? filePath;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final VoidCallback onTap;

  const _MaterialCard({
    required this.title,
    required this.tab,
    required this.filePath,
    required this.isBookmarked,
    required this.onBookmarkTap,
    required this.onTap,
  });

  bool get _isPdf {
    final String cleanPath = (filePath ?? title).toLowerCase().split('?').first;

    return cleanPath.endsWith('.pdf');
  }

  bool get _isImage {
    final String cleanPath = (filePath ?? title).toLowerCase().split('?').first;

    return cleanPath.endsWith('.png') ||
        cleanPath.endsWith('.jpg') ||
        cleanPath.endsWith('.jpeg') ||
        cleanPath.endsWith('.webp');
  }

  IconData get _tabIcon {
    if (tab == "Links") {
      return Icons.link_rounded;
    }

    if (tab == "Notes") {
      return Icons.note_rounded;
    }

    if (_isPdf) {
      return Icons.picture_as_pdf_rounded;
    }

    if (_isImage) {
      return Icons.image_rounded;
    }

    return Icons.insert_drive_file_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFECEBF8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(_tabIcon, color: const Color(0xFF7C6FCD), size: 24),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Html(
                data: title.isEmpty ? 'No Description' : title,
                style: {
                  "body": Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                    fontSize: FontSize(12),
                    lineHeight: const LineHeight(1.7),
                    color: Colors.black,
                  ),
                },
              ),
            ),

            GestureDetector(
              onTap: onBookmarkTap,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  isBookmarked ? Icons.star_rounded : Icons.star_border_rounded,
                  key: ValueKey(isBookmarked),
                  color: isBookmarked
                      ? const Color(0xFFFFC107)
                      : Colors.grey.shade400,
                  size: 26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  final String title;

  const MaterialImageViewerScreen({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, color: Colors.white),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Unable to load image',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
