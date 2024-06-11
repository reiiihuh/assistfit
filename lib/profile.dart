import 'package:flutter/material.dart';
import 'package:mockup_assistfit/bottomnavbar.dart';
import 'package:mockup_assistfit/edit.dart';
import 'package:mockup_assistfit/help.dart';
import 'package:mockup_assistfit/login.dart';
import 'shared_preferences_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;
  Map<String, dynamic> profil = {};

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadProfil();
  }

  // Function to load user name from SharedPreferences
  Future<void> _loadUserName() async {
    String? name = await SharedPreferencesHelper.getUserName();
    setState(() {
      userName = name ?? "Pengguna";
    });
  }

  Future<void> _loadProfil() async {
    int? userId = await SharedPreferencesHelper.getUserId();
    if (userId != null) {
      try {
        var response = await http.post(
          Uri.parse('http://192.168.1.11/login/api/get_profil.php'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, int>{
            'user_id': userId,
          }),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');

        if (response.statusCode == 200) {
          var responseBody = json.decode(response.body);

          if (responseBody['value'] == 1) {
            setState(() {
              profil = responseBody['profil']
                  [0]; // Ambil elemen pertama jika profilData adalah List
            });
          } else {
            print('Unexpected response value: ${responseBody['value']}');
          }
        } else {
          print('Failed to load profil, status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error loading profil: $e');
      }
    } else {
      print('User ID is null');
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/fotoprofile.jpeg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$userName',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ProfileDetail(
                label: 'Email SSO',
                value: profil['email'] ?? '',
              ),
              const SizedBox(height: 10),
              ProfileDetail(
                label: 'Phone Number',
                value: profil['no_telp'] ?? '',
              ),
              const SizedBox(height: 10),
              ProfileDetail(
                label: 'Account Number',
                value: profil['no_rek'] ?? '',
              ),
              const SizedBox(height: 30),
              ProfileAction(
                icon: Icons.edit,
                label: 'Edit',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditScreen()),
                  );
                },
              ),
              ProfileAction(
                icon: Icons.help,
                label: 'Help',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HelpScreen()),
                  );
                },
              ),
              ProfileAction(
                icon: Icons.logout,
                label: 'Logout',
                onTap: () {
                  _showLogoutConfirmation(context);
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetail({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: value,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ProfileAction(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
