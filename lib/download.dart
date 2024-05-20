import 'package:flutter/material.dart';
import 'package:mockup_assistfit/bottomnavbar.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: const Text(
          'Download BAP dan BAPP',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'images/logo1.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            DownloadCard(
              title: 'BAP',
              description: 'Silahkan Mengunduh File Template Dibawah Ini.',
              onPressed: () {
                // Handle download action
              },
            ),
            const SizedBox(height: 16),
            DownloadCard(
              title: 'BAPP',
              description: 'Silahkan Mengunduh File Template Dibawah Ini.',
              onPressed: () {
                // Handle download action
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class DownloadCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;

  const DownloadCard({
    super.key,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      shadowColor: Colors.green,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.insert_drive_file,
                    size: 40, color: Colors.black54),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Download',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
