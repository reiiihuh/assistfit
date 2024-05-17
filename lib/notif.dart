import 'package:flutter/material.dart';
//import 'homepage.dart'; // Import halaman homepage
import 'bottomnavbar.dart'; // Import the BottomNav widget

class NotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'date': 'Senin April 8, 2024',
      'title': 'Pengumpulan BAPP',
      'description': 'Jangan lupa untuk mengumpulkan BAPP minggu ini!'
    },
    {
      'date': 'Senin April 1, 2024',
      'title': 'Pengumpulan BAPP',
      'description': 'Jangan lupa untuk mengumpulkan BAPP minggu ini!'
    },
    {
      'date': 'Senin Maret 25, 2024',
      'title': 'Pengumpulan BAPP',
      'description': 'Jangan lupa untuk mengumpulkan BAPP bulan ini!'
    },
    {
      'date': 'Senin Maret 18, 2024',
      'title': 'Pengumpulan BAPP',
      'description': 'Jangan lupa untuk mengumpulkan BAPP minggu ini!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Tinggi appbar
        child: AppBar(
          automaticallyImplyLeading: false, // Remove the back arrow
          title: Image.asset(
            'images/logo1.png', // Ganti dengan path logo Anda
            fit: BoxFit.contain,
            height: 15,
          ),
          backgroundColor: Colors.white,
          elevation: 8.0, // Menambahkan shadow
          shadowColor: Colors.black.withOpacity(0.5), // Warna bayangan
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final date = notification['date'];
          final title = notification['title'];
          final description = notification['description'];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0 || notifications[index - 1]['date'] != date)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Text(
                    date!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[100],
                  child: Icon(
                    Icons.notifications,
                    color: Colors.green,
                  ),
                ),
                title: Text(
                  title!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(description!),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomNav(), // Use the BottomNav widget here
    );
  }
}
