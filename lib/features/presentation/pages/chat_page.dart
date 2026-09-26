import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';

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

    // Open Messages page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MessagesPage()),
    );
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

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        title: const Text(
          'Messages',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text("Recent", style: Theme.of(context).textTheme.bodySmall),
          ),
          Container(
            height: 85,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _statusTile(name: "Berry"),
                _statusTile(name: "Verry"),
                _statusTile(name: "Gerry"),
                _statusTile(name: "Jerry"),
                _statusTile(name: "Aerry"),
                _statusTile(name: "Merry"),
                _statusTile(name: "Perry"),
                _statusTile(name: "Berry"),
                _statusTile(name: "Verry"),
                _statusTile(name: "Gerry"),
                _statusTile(name: "Jerry"),
                _statusTile(name: "Aerry"),
                _statusTile(name: "Merry"),
                _statusTile(name: "Perry"),
                _statusTile(name: "Berry"),
                _statusTile(name: "Verry"),
                _statusTile(name: "Gerry"),
                _statusTile(name: "Jerry"),
                _statusTile(name: "Aerry"),
                _statusTile(name: "Merry"),
                _statusTile(name: "Perry"),
              ],
            ),
          ),

          AppSizes.height24,

          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: DefaultColors.messageListPage,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ListView(
                children: [
                  _messageTile(
                    name: 'Danny H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Bobby H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Mike H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Fabrice H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Fabio H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),
                  _messageTile(
                    name: 'Danny H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Bobby H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Mike H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Fabrice H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),

                  _messageTile(
                    name: 'Fabio H',
                    email: 'danny@gmail.com',
                    time: '08:43',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageTile({
    required String name,
    required String email,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Avatar
          const CircleAvatar(radius: 25, backgroundColor: Color(0xFFD6E7F8)),

          const SizedBox(width: 12),

          // Name + Email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  email,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),

          // Time
          Text(
            time,
            style: const TextStyle(color: Colors.white38, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _statusTile({required String name}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      height: 80,
      decoration: BoxDecoration(),
      child: Column(
        children: [
          // Avatar
          const CircleAvatar(radius: 25, backgroundColor: Color(0xFFD6E7F8)),

          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
