import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _startLoading();
  }

  Future<void> _startLoading() async {
    // Show loading screen for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // // Open Messages page
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ChatPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF25D366),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.chat_rounded,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(height: 25),

            // App Name
            const Text(
              'Wori',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Loading...',
              style: TextStyle(color: Colors.white70, fontSize: 15),
            ),

            const SizedBox(height: 30),

            // Loading Indicator
            const SizedBox(
              width: 35,
              height: 35,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Color(0xFF25D366),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------
// MESSAGES PAGE
// ------------------------------------------------------
