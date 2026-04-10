import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/materials/presentation/widgets/materials_widget.dart';

final ValueNotifier<String> selectedSubject = ValueNotifier<String>(
  'Mathematics',
);

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.microtask(() {
    //   context.read<MaterialCubit>().fetchMaterials(
    //     FetchMaterialParameter(
    //       branchId: 1,
    //       accYear:AppData.accYear!.toString(),
    //       standardId: AppData.studentStdId!.toString(),
    //       divisionId: AppData.studentDivId!.toString(),
    //     ),
    //   );
    // });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Materials Name'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 208, 205, 205),
                borderRadius: BorderRadius.circular(30),
              ),

              child: PopupMenuButton(
                icon: const Icon(Icons.filter_list),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    enabled: false,
                    child: SizedBox(
                      width: 220,
                      child: ValueListenableBuilder<String>(
                        valueListenable: selectedSubject,
                        builder: (_, value, _) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              radioItem(context, 'Mathematics', value),
                              radioItem(context, 'Malayalam', value),
                              radioItem(context, 'Physics', value),
                              radioItem(context, 'Chemistry', value),
                              radioItem(context, 'Biology', value),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      body: Center(child: Text('No Materials Found..!')),
      // BlocBuilder<MaterialCubit, MaterialsState>(
      //   builder: (context, state) {
      //     if (state is MaterialLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //
      //     if (state is MaterialError) {
      //       return Center(child: Text(state.message));
      //     }
      //
      //     if (state is MaterialLoaded) {
      //       final data = state.response.data ?? [];
      //
      //       if (data.isEmpty) {
      //         return const Center(child: Text("No Materials Found"));
      //       }
      //
      //       return ListView.separated(
      //         separatorBuilder: (context, index) {
      //           return SizedBox(height: 10);
      //         },
      //         padding: const EdgeInsets.all(16),
      //         itemCount: data.length,
      //         itemBuilder: (context, index) {
      //           final item = data[index];
      //           final bool isFav = item.favorite ?? false;
      //           // final ValueNotifier<bool> isFav = ValueNotifier<bool>(
      //           //   item.favorite ?? false,
      //           // );
      //
      //           /// 🔥 PDF
      //           if (item.material != null &&
      //               item.material.toString().isNotEmpty) {
      //             return buildCard(
      //               child: ListTile(
      //                 leading: leadingIcon(item),
      //                 title: Text(item.documentName ?? "-"),
      //                 trailing: Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [favIcon(isFav), downloadIcon()],
      //                 ),
      //               ),
      //             );
      //           }
      //
      //           /// 🔥 LINK
      //           if (item.link != null && item.link.toString().isNotEmpty) {
      //             return buildCard(
      //               child: ListTile(
      //                 leading: leadingIcon(item),
      //                 title: Text(item.documentName ?? "-"),
      //                 trailing: Row(
      //                   mainAxisSize: MainAxisSize.min,
      //                   children: [
      //                     favIcon(isFav),
      //                     arrowIcon(
      //                       onTap: () {
      //                         print(item.link);
      //                       },
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           }
      //
      //           /// 🔥 NOTES
      //           if (item.notes != null && item.notes.toString().isNotEmpty) {
      //             return buildCard(
      //               child: ListTile(
      //                 onTap: () {
      //                   AppNavigator.pushSlide(
      //                     context: context,
      //                     page: const NotesExpansionScreen(),
      //                   );
      //                 },
      //                 leading: leadingIcon(item),
      //                 title: Text(item.documentName ?? "-"),
      //                 trailing: favIcon(isFav),
      //               ),
      //             );
      //           }
      //
      //           return const SizedBox();
      //         },
      //       );
      //     }
      //
      //     return const SizedBox();
      //   },
      // ),
    );
  }
}
