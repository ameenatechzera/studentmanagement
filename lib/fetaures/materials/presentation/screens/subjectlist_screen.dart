import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/navigation/app_navigator.dart';
import 'package:studentmanagement/fetaures/materials/domain/entities/subjects_entity.dart';
import 'package:studentmanagement/fetaures/materials/presentation/cubit/material_cubit.dart';

import 'materialListScreen.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  List<SubjectList> subjectList = [];

  @override
  void initState() {
    super.initState();
    context.read<MaterialCubit>().fetchSubjects();
  }

  // 🎨 Assign icon + color based on subject name
  Map<String, dynamic> getSubjectStyle(String name) {
    switch (name.toLowerCase()) {
      case "maths":
        return {
          "icon": Image.asset('assets/icons/mathsicon.png', height: 24, width: 24),
          "color": const Color(0xFFFFF3C4),
        };
      case "physics":
        return {
          "icon": Image.asset('assets/icons/physics_icon.png', height: 24, width: 24),
          "color": const Color(0xFFDDF5C9),
        };
      case "chemistry":
        return {
          "icon": Image.asset('assets/icons/chemistry_icon.png', height: 24, width: 24),
          "color": const Color(0xFFD4F5D0),
        };
      case "english":
        return {
          "icon": Image.asset('assets/icons/english_icon.png', height: 24, width: 24),
          "color": const Color(0xFFD6EAF8),
        };
      case "gk":
        return {
          "icon": Image.asset('assets/icons/chemistry_icon.png', height: 24, width: 24),
          "color": const Color(0xFFCFEEFF),
        };
      case "arabic":
        return {
          "icon": Image.asset('assets/icons/chemistry_icon.png', height: 24, width: 24),
          "color": const Color(0xFFCFEEFF),
        };
      default:
        return {
          "icon": Image.asset('assets/icons/physics_icon.png', height: 24, width: 24),
          "color": const Color(0xFFF8D7EC),
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDEDED),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFEDEDED),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Subject",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<MaterialCubit, MaterialsState>(
        builder: (context, state) {
          if (state is SubjectsLoaded) {
            subjectList = state.response.data;
          }

          if (subjectList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: subjectList.length,
            itemBuilder: (context, index) {
              final item = subjectList[index];
              final subjectName = item.subjectName ?? "";
              final style = getSubjectStyle(subjectName);

              return InkWell(
                onTap: (){
                  AppNavigator.pushSlide(context: context, page: MaterialListPage(subjectName: item.subjectName, subjectId: item.subjectId,));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: style["color"] as Color,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // ✅ Fixed: use Widget directly instead of Icon()
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: style["icon"] as Widget,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        subjectName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}