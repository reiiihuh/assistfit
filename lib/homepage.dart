import 'package:flutter/material.dart';
import 'package:mockup_assistfit/bottomnavbar.dart';
import 'package:mockup_assistfit/download.dart';
import 'package:table_calendar/table_calendar.dart';
import 'upload.dart'; // Import the upload.dart file
import 'honor.dart';
import 'shared_preferences_helper.dart'; // Import SharedPreferencesHelper
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? userName;
  List<dynamic> jadwalList = [];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadJadwal();
  }

  // Function to load user name from SharedPreferences
  Future<void> _loadUserName() async {
    String? name = await SharedPreferencesHelper.getUserName();
    setState(() {
      userName = name ?? "Pengguna";
    });
  }

  // Function to load jadwal from API
  Future<void> _loadJadwal() async {
    int? userId = await SharedPreferencesHelper.getUserId();
    if (userId != null) {
      try {
        var response = await http.post(
          Uri.parse('http://10.60.40.211/login/api/get_jadwal.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, int>{
            'user_id': userId,
          }),
        );

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);

          if (responseBody['value'] == 1) {
            setState(() {
              jadwalList = responseBody['jadwal'];
            });
          } else {
            print('Unexpected response value: ${responseBody['value']}');
          }
        } else {
          print('Failed to load jadwal, status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error loading jadwal: $e');
      }
    } else {
      print('User ID is null');
    }
  }

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
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Color.fromARGB(
                      255, 226, 51, 51), // Red background for the content layer
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      // Top section with title
                      Text(
                        'Selamat Datang, $userName!',
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
                                focusedDay: DateTime.now(),
                                firstDay: DateTime(2020),
                                lastDay: DateTime(2030),
                                selectedDayPredicate: (day) =>
                                    isSameDay(day, DateTime.now()),
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
                              if (jadwalList.isNotEmpty)
                                ...jadwalList.map((jadwal) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jadwal['mata_kuliah'] ?? '',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Kelas: ${jadwal['kelas'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Ruangan: ${jadwal['ruangan'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Jam Mulai: ${jadwal['jam_mulai'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        'Jam Selesai: ${jadwal['jam_selesai'] ?? ''}',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                    ],
                                  );
                                }).toList()
                              else
                                Text(
                                  'Tidak ada jadwal tersedia.',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Feature layer with action buttons in a card
                Container(
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
                            label: 'Download BAP dan BAPP',
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
                            label: 'Upload BAP dan BAPP',
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
                            label: 'View Honor',
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
              ],
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
          Container(
            width: 85, // Set a fixed width
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 0, 0, 0), // Text color
              ),
            ),
          ),
        ],
      ),
    );
  }
}
