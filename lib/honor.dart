import 'package:flutter/material.dart';
import 'bottomnavbar.dart';
import 'shared_preferences_helper.dart'; // Import SharedPreferencesHelper
import 'package:http/http.dart' as http;
import 'dart:convert';

class HonorPage extends StatefulWidget {
  @override
  State<HonorPage> createState() => _HonorPageState();
}

class _HonorPageState extends State<HonorPage> {
  String? userName;
  Map<String, dynamic> honor = {};

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadHonor();
  }

  // Function to load user name from SharedPreferences
  Future<void> _loadUserName() async {
    String? name = await SharedPreferencesHelper.getUserName();
    setState(() {
      userName = name ?? "Pengguna";
    });
  }

  Future<void> _loadHonor() async {
    int? userId = await SharedPreferencesHelper.getUserId();
    if (userId != null) {
      try {
        var response = await http.post(
          Uri.parse('http://192.168.1.11/login/api/get_honor.php'),
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
              honor = responseBody['honor']
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Text(
          'View dan Cetak Slip Honor',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Rp 0,00.00',
                              style: TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Tanggal Dikirim: ${honor['tgl_dikirim'] ?? ''}'),
                      Text('No. Rekening: ${honor['no_rek'] ?? ''}'),
                      Text('Nama: ${honor['nama'] ?? ''}'),
                      Text('Bank: ${honor['bank'] ?? ''}'),
                      Text('Jumlah hari: ${honor['jumlah_hari'] ?? ''}'),
                      Text('Jumlah Jam: ${honor['jumlah_jam'] ?? ''}'),
                      Text('Tarif Per Jam: ${honor['tarif_perjam'] ?? ''}'),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Implement submit button functionality here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30.0), // Border color
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
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
