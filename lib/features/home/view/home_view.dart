import 'package:carbon_root_analytics/features/home/view/widgets/home_about_section.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_app_bar.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_footer.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_hero_section.dart';
import 'package:carbon_root_analytics/features/home/view/widgets/home_service_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final Map<String, GlobalKey> _sectionKeys = {
    'services': GlobalKey(),
    'about': GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: HomeAppBar(scrollToSection: _scrollToSection),
      ),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f172a), Color(0xFF1e293b), Color(0xFF334155)],
          ),
        ),
        child: ListView(
          children: [
            HomeHeroSection(
              scrollToServices: () => _scrollToSection('services'),
            ),
            HomeServiceSection(key: _sectionKeys['services']),
            HomeAboutSection(key: _sectionKeys['about']),
            HomeFooter(),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(String section) {
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
}
