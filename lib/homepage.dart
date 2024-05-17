import 'package:flutter/material.dart';
import 'package:mockup_assistfit/bottomnavbar.dart';
import 'package:mockup_assistfit/download.dart';
import 'package:table_calendar/table_calendar.dart';
import 'upload.dart'; // Import the upload.dart file
import 'honor.dart';

class HomePage extends StatelessWidget {
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
      body: Stack(
        children: [
          // Background layer (white)
          Container(
            color: Colors.white,
          ),
          // Red layer (second bottom layer)
          Positioned.fill(
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          // Content layer (red)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              color: Color.fromARGB(
                  255, 226, 51, 51), // Red background for the content layer
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // Top section with title
                  Text(
                    'Selamat Datang, Ahra!',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Card with calendar and course details
                  Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          TableCalendar(
                            focusedDay: DateTime(2024, 5, 16),
                            firstDay: DateTime(2020),
                            lastDay: DateTime(2030),
                            selectedDayPredicate: (day) =>
                                isSameDay(day, DateTime(2024, 5, 16)),
                            calendarFormat: CalendarFormat.week,
                            headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              titleCentered: true,
                              leftChevronVisible: false,
                              rightChevronVisible: false,
                            ),
                            daysOfWeekStyle: DaysOfWeekStyle(
                              weekendStyle: TextStyle(color: Colors.red),
                            ),
                            calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'Arsitektur dan Jaringan Komputer',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Kelas: D3-SI 47-04',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Ruangan: B1',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Jam Mulai: 12:30',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Jam Selesai: 16:30',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Feature layer with action buttons in a card
          Positioned(
            left: 0,
            right: 0,
            bottom: 200,
            child: Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 202, 202, 202), // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context: context,
                        icon: Icons.file_download,
                        label: 'Download',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DownloadPage(),
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context: context,
                        icon: Icons.upload_file_rounded,
                        label: 'Upload',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadPage(),
                            ),
                          );
                        },
                      ),
                      _buildActionButton(
                        context: context,
                        icon: Icons.list_alt,
                        label: 'View',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HonorPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }

  // Function to build action button widgets
  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white, // White background for buttons
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: Color.fromARGB(255, 202, 202, 202)), // Border color
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.green, // green icon color
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 0, 0, 0), // Text color
            ),
          ),
        ],
      ),
    );
  }
}
