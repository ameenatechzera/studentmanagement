import 'package:flutter/material.dart';
import 'package:studentmanagement/fetaures/authentication/domain/entities/login_entity.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/header_cristal.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/post_card_cristal.dart';
import 'package:studentmanagement/fetaures/home_screen/presentation/widgets/sidenavigation.dart';

class HomeScreen extends StatelessWidget {
  final LoginResponseResult? loginResponse;

  const HomeScreen( {super.key, this.loginResponse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavigationBar(),
      appBar: AppBar(title: const Text("Home")),
      //bottomNavigationBar: const CustomBottomBar(),
      body: SafeArea(
        child: Column(
          children: [
            const HeaderSection(),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: const [PostCard(), SizedBox(height: 16), PostCard()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
