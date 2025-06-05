import 'package:flutter/material.dart';
import 'dart:math' as math;

class PageNotFoundView extends StatefulWidget {
  const PageNotFoundView({super.key});

  @override
  State<PageNotFoundView> createState() => _PageNotFoundViewState();
}

class _PageNotFoundViewState extends State<PageNotFoundView>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  late AnimationController _slideController;

  late Animation<double> _floatAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Float animation for floating elements
    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Rotation animation for planets/asteroids
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    // Pulse animation for glow effects
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Slide animation for content
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _floatAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
        );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeIn));

    // Start animations
    _floatController.repeat(reverse: true);
    _rotationController.repeat();
    _pulseController.repeat(reverse: true);
    _slideController.forward();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _rotationController.dispose();
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e), Color(0xFF0f0f23)],
          ),
        ),
        child: Stack(
          children: [
            // Animated background elements
            _buildBackgroundElements(),

            // Stars
            _buildStars(),

            // Main content
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated 404 with astronaut
                      _buildAnimated404(),

                      const SizedBox(height: 40),

                      // Content
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            children: [
                              // Title
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      colors: [
                                        Color(0xFF00f5ff),
                                        Color(0xFF7b68ee),
                                        Color(0xFFff6b9d),
                                      ],
                                    ).createShader(bounds),
                                child: const Text(
                                  'Lost in Space',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Subtitle
                              const Text(
                                'Oops! It looks like you\'ve drifted into the cosmic void.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white70,
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                'The page you\'re looking for has been consumed by a black hole.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                  height: 1.5,
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Action buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildGlowButton(
                                    'Return to Earth',
                                    const Color(0xFF00f5ff),
                                    () => Navigator.of(
                                      context,
                                    ).pushReplacementNamed('/'),
                                  ),
                                  const SizedBox(width: 20),
                                  _buildGlowButton(
                                    'Send SOS',
                                    const Color(0xFFff6b9d),
                                    () => _showSosDialog(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimated404() {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatAnimation, _pulseAnimation]),
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -20 + (_floatAnimation.value * 40)),
          child: Transform.scale(
            scale: _pulseAnimation.value,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glow effect
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00f5ff).withOpacity(0.3),
                        blurRadius: 60,
                        spreadRadius: 20,
                      ),
                    ],
                  ),
                ),

                // 404 Text
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00f5ff), Color(0xFF7b68ee)],
                  ).createShader(bounds),
                  child: const Text(
                    '404',
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Color(0xFF00f5ff),
                          blurRadius: 20,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),

                // Astronaut emoji floating around
                Positioned(
                  top: -10,
                  right: -20,
                  child: Transform.rotate(
                    angle: _floatAnimation.value * 0.5,
                    child: const Text('🚀', style: TextStyle(fontSize: 40)),
                  ),
                ),

                Positioned(
                  bottom: -20,
                  left: -30,
                  child: Transform.rotate(
                    angle: -_floatAnimation.value * 0.3,
                    child: const Text('👨‍🚀', style: TextStyle(fontSize: 50)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBackgroundElements() {
    return Stack(
      children: [
        // Floating planets
        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Positioned(
              top: 100 + (_floatAnimation.value * 30),
              left: 50,
              child: _buildPlanet(80, const Color(0xFF7b68ee)),
            );
          },
        ),

        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Positioned(
              top: 200 + (_floatAnimation.value * -25),
              right: 80,
              child: _buildPlanet(60, const Color(0xFFff6b9d)),
            );
          },
        ),

        AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Positioned(
              bottom: 150 + (_floatAnimation.value * 20),
              left: 100,
              child: _buildPlanet(100, const Color(0xFF00f5ff)),
            );
          },
        ),

        // Rotating asteroids
        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Positioned(
              top: 300,
              right: 200,
              child: Transform.rotate(
                angle: _rotationAnimation.value,
                child: _buildAsteroid(40),
              ),
            );
          },
        ),

        AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Positioned(
              bottom: 300,
              right: 50,
              child: Transform.rotate(
                angle: -_rotationAnimation.value * 0.5,
                child: _buildAsteroid(25),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPlanet(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.8),
            color.withOpacity(0.4),
            color.withOpacity(0.1),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildAsteroid(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey.withOpacity(0.3),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
    );
  }

  Widget _buildStars() {
    return Stack(
      children: List.generate(50, (index) {
        final random = math.Random(index);
        return AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Positioned(
              top: random.nextDouble() * 800,
              left: random.nextDouble() * 400,
              child: Container(
                width: 2 + (random.nextDouble() * 3),
                height: 2 + (random.nextDouble() * 3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(
                    0.3 + (random.nextDouble() * 0.7) * _pulseAnimation.value,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildGlowButton(String text, Color color, VoidCallback onPressed) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4 * _pulseAnimation.value),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withOpacity(0.2),
              foregroundColor: color,
              side: BorderSide(color: color, width: 1),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  void _showSosDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1a1a2e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF00f5ff), width: 1),
          ),
          title: const Text(
            '🚨 SOS Signal Sent',
            style: TextStyle(color: Color(0xFF00f5ff)),
          ),
          content: const Text(
            'Houston, we have a problem! 📡\n\nOur space engineers have been notified and are working to rescue you from this digital void.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Roger that! 👨‍🚀',
                style: TextStyle(color: Color(0xFF00f5ff)),
              ),
            ),
          ],
        );
      },
    );
  }
}
