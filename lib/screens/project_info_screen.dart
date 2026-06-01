import 'package:flutter/material.dart';

class ProjectInfoScreen extends StatelessWidget {
  const ProjectInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Information ℹ️'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero section with App Logo placeholder
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD35400).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront,
                      size: 64,
                      color: Color(0xFFD35400),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Smart Idly Kadai App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const Text(
                    'Version 1.0.0 (Prototype)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Tech Stack Section
            const Text(
              'Tech Stack & Design Patterns 🛠️',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 12),
            _buildTechRow(Icons.phone_android, 'Flutter SDK', 'Clean, responsive UI with custom South Indian color theme.'),
            _buildTechRow(Icons.layers, 'Provider Pattern', 'Decoupled state management (MenuProvider) handling search and updates.'),
            _buildTechRow(Icons.sync_alt, 'Mock Firebase Streams', 'StreamController.broadcast() simulating Firestore real-time sync.'),
            _buildTechRow(Icons.font_download, 'Google Fonts', 'Modern Outfit typography to give a highly premium appearance.'),

            const SizedBox(height: 32),

            // Features Checklist
            const Text(
              'Implemented App Features 🚀',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 12),
            _buildFeatureTile('Real-time Shop Toggle', 'Owner switches shop status and customers see the OPEN/CLOSED pulsing badge change instantly.', true),
            _buildFeatureTile('Instant Search & Filter', 'Customers search dishes by name or description. Filter by breakfast/lunch/dinner category.', true),
            _buildFeatureTile('Interactive Details Page', 'Visual presentation of the dish price, description, and list of side dishes.', true),
            _buildFeatureTile('Live Admin CRUD Dashboard', 'Admins can dynamically add new items, update prices/details, toggle item availability, or delete items.', true),
            _buildFeatureTile('Clean Responsive Design', 'Adapts nicely to different mobile aspect ratios with modern rounded cards and shadows.', true),

            const SizedBox(height: 32),

            // Tips section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEAFAF1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF27AE60).withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.tips_and_updates, color: Color(0xFF27AE60)),
                      SizedBox(width: 8),
                      Text(
                        'Production Ready Tips',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E8449),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'To hook up real Firebase, you can replace the StreamControllers in firebase_service.dart with your live cloud_firestore streams. The entire provider UI is built to react to streams, so the frontend UI does not need to be changed at all!',
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.green[900],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTechRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F4F4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFFD35400), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(String title, String desc, bool done) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? const Color(0xFF27AE60) : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  desc,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
