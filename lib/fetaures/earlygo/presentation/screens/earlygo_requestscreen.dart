// import 'package:flutter/material.dart';

// class EarlyGoRequestScreen extends StatelessWidget {
//   const EarlyGoRequestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const Icon(Icons.arrow_back, color: Colors.black),
//         centerTitle: true,
//         title: const Text(
//           'Early Go Request',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _buildLabel("Date of Leaving School"),
//             const SizedBox(height: 8),
//             _buildTextField(
//               hintText: "06/16/2026",
//               //suffixIcon: Icons.calendar_today_outlined,
//             ),

//             const SizedBox(height: 20),

//             _buildLabel("Leave Time"),
//             const SizedBox(height: 8),
//             _buildTextField(
//               hintText: "--:-- --",
//               //suffixIcon: Icons.access_time,
//             ),

//             const SizedBox(height: 20),

//             _buildLabel("Reason for Leaving"),
//             const SizedBox(height: 8),
//             _buildTextField(hintText: "e.g., Medical appointment", maxLines: 4),

//             const SizedBox(height: 20),

//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(.08),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildLabel("Pickup By"),
//                   const SizedBox(height: 8),
//                   _buildTextField(hintText: "Full name"),

//                   const SizedBox(height: 16),

//                   _buildLabel("Relation"),
//                   const SizedBox(height: 8),
//                   _buildDropdown(),

//                   const SizedBox(height: 16),

//                   _buildLabel("Mobile No."),
//                   const SizedBox(height: 8),
//                   _buildTextField(
//                     hintText: "555-0123",
//                     keyboardType: TextInputType.phone,
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
//               decoration: BoxDecoration(
//                 color: const Color(0xffF6F1E7),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: const Color(0xffE4D8BC)),
//               ),
//               child: const Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(Icons.info, color: Color(0xffA77400), size: 18),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Text(
//                       "Requests should be submitted 2 hours in advance.",
//                       style: TextStyle(color: Color(0xff8A6A1F), fontSize: 13),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             SizedBox(
//               width: double.infinity,
//               height: 54,
//               child: ElevatedButton.icon(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xff807FD8),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 6,
//                 ),
//                 label: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Submit Request",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     Icon(Icons.send, color: Colors.white, size: 18),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   static Widget _buildLabel(String text) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         text,
//         style: const TextStyle(
//           fontWeight: FontWeight.w600,
//           color: Color(0xff56566B),
//         ),
//       ),
//     );
//   }

//   static Widget _buildTextField({
//     required String hintText,
//     int maxLines = 1,
//     IconData? suffixIcon,
//     TextInputType keyboardType = TextInputType.text,
//   }) {
//     return TextField(
//       keyboardType: keyboardType,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hintText,
//         filled: true,
//         fillColor: const Color(0xffF1F4FC),
//         suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20) : null,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   static Widget _buildDropdown() {
//     return DropdownButtonFormField<String>(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: const Color(0xffF1F4FC),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//       hint: const Text("Select relation"),
//       items: const [
//         DropdownMenuItem(value: "Father", child: Text("Father")),
//         DropdownMenuItem(value: "Mother", child: Text("Mother")),
//         DropdownMenuItem(value: "Guardian", child: Text("Guardian")),
//       ],
//       onChanged: (value) {},
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/earlygo/domain/parameters/save_earlyleave_parameter.dart';
import 'package:studentmanagement/fetaures/earlygo/presentation/cubit/earlygo_cubit.dart';

class EarlyGoRequestScreen extends StatefulWidget {
  const EarlyGoRequestScreen({super.key});

  @override
  State<EarlyGoRequestScreen> createState() => _EarlyGoRequestScreenState();
}

class _EarlyGoRequestScreenState extends State<EarlyGoRequestScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController pickupNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  String relation = "Father";

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    reasonController.dispose();
    pickupNameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  void submitRequest() {
    final params = SaveEarlyLeaveParameter(
      requestNo: "",
      accYear: AppData.accYear!,
      admno: AppData.admissionNo!,
      requestDate: DateTime.now().toString().split(' ').first,
      earlyLeaveDate: dateController.text.trim(),
      leaveTime: timeController.text.trim(),
      reason: reasonController.text.trim(),
      pickupPersonName: pickupNameController.text.trim(),
      pickupPersonMobile: mobileController.text.trim(),
      pickupPersonRelation: relation,
      teacherStatus: "Pending",
      employeeId: null,
      teacherRemarks: null,
      teacherApprovedAt: null,
      finalStatus: "Pending",
      createdUser: "1",
      branchId: 1,
    );

    context.read<EarlygoCubit>().saveEarlyLeave(params);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EarlygoCubit, EarlygoState>(
      listener: (context, state) {
        if (state is SaveEarlyLeaveSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.response.message ?? "Request Submitted Successfully",
              ),
            ),
          );

          Navigator.pop(context);
        }

        if (state is SaveEarlyLeaveError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: const Icon(Icons.arrow_back, color: Colors.black),
            centerTitle: true,
            title: const Text(
              'Early Go Request',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildLabel("Date of Leaving School"),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: dateController,
                  hintText: "2026-06-16",
                ),

                const SizedBox(height: 20),

                _buildLabel("Leave Time"),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: timeController,
                  hintText: "14:00:00",
                ),

                const SizedBox(height: 20),

                _buildLabel("Reason for Leaving"),
                const SizedBox(height: 8),
                _buildTextField(
                  controller: reasonController,
                  hintText: "e.g., Medical appointment",
                  maxLines: 4,
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildLabel("Pickup By"),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: pickupNameController,
                        hintText: "Full name",
                      ),

                      const SizedBox(height: 16),

                      _buildLabel("Relation"),
                      const SizedBox(height: 8),

                      DropdownButtonFormField<String>(
                        value: relation,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xffF1F4FC),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: "Father",
                            child: Text("Father"),
                          ),
                          DropdownMenuItem(
                            value: "Mother",
                            child: Text("Mother"),
                          ),
                          DropdownMenuItem(
                            value: "Guardian",
                            child: Text("Guardian"),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            relation = value!;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      _buildLabel("Mobile No."),
                      const SizedBox(height: 8),
                      _buildTextField(
                        controller: mobileController,
                        hintText: "555-0123",
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF6F1E7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xffE4D8BC)),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.info, color: Color(0xffA77400), size: 18),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "Requests should be submitted 2 hours in advance.",
                          style: TextStyle(
                            color: Color(0xff8A6A1F),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: state is SaveEarlyLeaveLoading
                        ? null
                        : submitRequest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff807FD8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: state is SaveEarlyLeaveLoading
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Submit Request",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.send, color: Colors.white, size: 18),
                            ],
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xff56566B),
        ),
      ),
    );
  }

  static Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
    IconData? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xffF1F4FC),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
