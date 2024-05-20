import 'package:flutter/material.dart';
import 'package:mockup_assistfit/bottomnavbar.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'images/edit.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Perhatian!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Pengeditan profil saat ini tidak dapat dilakukan secara online. Untuk melakukan perubahan pada profil Anda, silakan hubungi Lab FIT. Tim kami siap membantu Anda. Terima kasih atas pengertiannya.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Kode untuk menghubungi WhatsApp Lab
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Hubungi Lab',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
