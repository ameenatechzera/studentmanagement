import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentmanagement/core/appdata/appdata.dart';
import 'package:studentmanagement/fetaures/authentication/presentation/screens/loginScreen.dart';
import 'package:studentmanagement/services/shared_preference_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

  static BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, dynamic>? branchData;

  @override
  void initState() {
    super.initState();
    loadBranchData();
  }

  Future<void> loadBranchData() async {
    final data = await SharedPreferenceHelper().getBranchData();

    setState(() {
      branchData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (branchData == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/Rectangle 113.png",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade300,
                        child: const Center(child: Icon(Icons.image, size: 40)),
                      );
                    },
                  ),
                ),

                /// BACK BUTTON
                Positioned(
                  top: 50,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),

                Positioned(
                  bottom: -42,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,

                      /// APP LOGO
                      child: ClipOval(
                        child: Image.network(
                          branchData!["logo"] ?? "",
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 55),

            Text(
              AppData.branchName!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xffEAF4FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InfoColumn(
                        title: "Affiliate",
                        value: branchData?["Sector"]?.toString() ?? "--",
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      child: VerticalDivider(
                        color: Color(0xff8B9BAD),
                        thickness: 1,
                      ),
                    ),
                    Expanded(
                      child: InfoColumn(title: "Affiliate Number", value: "--"),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: SettingsScreen.boxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: Color(0xffE8F6EA),
                      child: Icon(
                        Icons.location_on,
                        color: Color(0xff24A05A),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            branchData!["post_Pin"] ?? "No Postpin",
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525),
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            branchData!["District"] ?? "No District",
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525),
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            branchData!["State"] ?? "No State",

                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525),
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            AppData.place!,
                            style: TextStyle(
                              fontSize: 12.5,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff252525),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      // width: 75,
                      // height: 75,
                      child: Image.asset(
                        "assets/images/ChatGPT Image May 11, 2026, 09_40_13 AM 1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: SettingsScreen.boxDecoration(),
                child: Column(
                  children: [
                    ContactTile(
                      icon: Icons.phone,
                      iconColor: Color(0xff3C82FF),
                      bgColor: Color(0xffEEF4FF),
                      text: branchData?["Phone1"]?.toString() ?? "aaaaa",
                    ),
                    Divider(height: 1, indent: 55),
                    ContactTile(
                      icon: Icons.email,
                      iconColor: Color(0xffFF8A3D),
                      bgColor: Color(0xffFFF1E8),
                      text: branchData?["Email"]?.toString() ?? "aaaaa",
                    ),
                    Divider(height: 1, indent: 55),
                    if (branchData?["Website"] != null)
                      ContactTile(
                        icon: Icons.language,
                        iconColor: Color(0xffFF4DA6),
                        bgColor: Color(0xffFFEAF4),
                        text: branchData?["Website"].toString() ?? "",
                        isLink: true,
                      ),
                    // ContactTile(
                    //   icon: Icons.language,
                    //   iconColor: Color(0xffFF4DA6),
                    //   bgColor: Color(0xffFFEAF4),
                    //   text: branchData?["Website"]?.toString() ?? "aaaaa.com",
                    //   isLink: true,
                    // ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Container(
            //     height: 150,
            //     padding: const EdgeInsets.all(18),
            //     decoration: BoxDecoration(
            //       color: const Color(0xff202020),
            //       borderRadius: BorderRadius.circular(18),
            //     ),

            //     child: Stack(
            //       children: [
            //         /// BACKGROUND IMAGE
            //         Positioned(
            //           right: -35,
            //           top: -5,
            //           bottom: -5,
            //           child: Image.asset(
            //             "assets/images/mask_bg.png",
            //             height: 100,
            //             fit: BoxFit.contain,
            //             color: Colors.white,
            //           ),
            //         ),

            //         /// CONTENT
            //         Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Row(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const CircleAvatar(
            //                   radius: 24,
            //                   backgroundImage: AssetImage(
            //                     "assets/images/man.png",
            //                   ),
            //                 ),

            //                 const SizedBox(width: 12),

            //                 Expanded(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Text(
            //                         AppData.studentName!,
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w700,
            //                         ),
            //                       ),

            //                       SizedBox(height: 4),

            //                       Text(
            //                         "Principle",
            //                         style: TextStyle(
            //                           color: Color(0xffCFCFCF),
            //                           fontSize: 11,
            //                         ),
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),

            //             Padding(
            //               padding: const EdgeInsets.all(8.0),
            //               child: Row(
            //                 children: [
            //                   CircleAvatar(
            //                     radius: 15,
            //                     backgroundColor: const Color(0xff7B6DFF),
            //                     child: const Icon(
            //                       Icons.phone,
            //                       color: Colors.white,
            //                       size: 15,
            //                     ),
            //                   ),

            //                   const SizedBox(width: 10),

            //                   const Text(
            //                     "+932 2228392",
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 13,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 28),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () async {
                    final helper = SharedPreferenceHelper();

                    /// 🔥 CLEAR SESSION
                    await helper.clearLoginData();
                    final prefs = await SharedPreferences.getInstance();

                    await SharedPreferenceHelper.clearAccounts();

                    /// ❗ DO NOT clear accounts (for switch account feature)
                    /// await SharedPreferenceHelper.clearAccounts(); ❌ optional

                    /// 🔥 Clear AppData (VERY IMPORTANT)
                    AppData.admissionNo = null;
                    AppData.studentName = null;
                    AppData.studentStdId = null;
                    AppData.studentDivId = null;
                    AppData.accYear = null;
                    AppData.dob = null;
                    AppData.profileUrl = null;
                    // AppData.gender = null;

                    /// 🔥 Navigate and remove all routes
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const Login_Screen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Color(0xff7F7BFF),
                    size: 18,
                  ),
                  label: const Text(
                    "Logout",
                    style: TextStyle(color: Color(0xff7F7BFF), fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String value;

  const InfoColumn({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xff333333),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xff222222),
          ),
        ),
      ],
    );
  }
}

class ContactTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String text;
  final bool isLink;

  const ContactTile({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.text,
    this.isLink = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: CircleAvatar(
        radius: 16,
        backgroundColor: bgColor,
        child: Icon(icon, color: iconColor, size: 17),
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          color: isLink ? Colors.blue : const Color(0xff303030),
          decoration: isLink ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Color(0xffC7C7C7),
      ),
    );
  }
}
