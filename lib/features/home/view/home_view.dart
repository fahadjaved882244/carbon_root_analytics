import 'package:carbon_root_analytics/features/home/view/widgets/home_about_section.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_app_bar.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_footer.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_hero_section.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_manchester_section.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_service_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f172a), Color(0xFF1e293b), Color(0xFF334155)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            HomeAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                HomeHeroSection(),
                HomeServiceSection(),
                HomeAboutSection(),
                HomeManchesterSection(),
                HomeFooter(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
