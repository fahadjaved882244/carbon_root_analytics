import 'package:carbon_root_analytics/features/navigation_console/view/widgets/responsive_padding.dart';
import 'package:flutter/material.dart';

class HomeHeroSection extends StatefulWidget {
  final VoidCallback scrollToServices;
  const HomeHeroSection({super.key, required this.scrollToServices});

  @override
  State<HomeHeroSection> createState() => _HomeHeroSectionState();
}

class _HomeHeroSectionState extends State<HomeHeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _floatController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _floatAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ResponsivePadding(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Floating elements
            _buildFloatingElements(),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFF10b981),
                                Color(0xFF3b82f6),
                                Color(0xFF8b5cf6),
                              ],
                            ).createShader(bounds),
                            child: const Text(
                              'Carbon Root\nAnalytics',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.1,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Empowering Manchester SMEs to achieve net-zero\ncarbon emissions through cutting-edge analytics\nand sustainable solutions for the office and service sector.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),
                          _buildGradientButton('Discover Our Services', () {
                            // Uncomment the next line to enable scrolling to a specific section
                            widget.scrollToServices.call();
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingElements() {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Positioned(
              top: 100 + (_floatAnimation.value * 20),
              right: 50,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF10b981).withOpacity(0.1),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Positioned(
              top: 300 + (_floatAnimation.value * -15),
              right: 100,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF3b82f6).withOpacity(0.1),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Positioned(
              bottom: 150 + (_floatAnimation.value * 25),
              right: 80,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF8b5cf6).withOpacity(0.1),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF10b981), Color(0xFF3b82f6)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10b981).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
