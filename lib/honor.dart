import 'package:flutter/material.dart';
import 'bottomnavbar.dart';

class HonorPage extends StatelessWidget {
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
                      Text('Tanggal Dikirim: DD/MM/YY'),
                      Text('No. Rekening: 000000000'),
                      Text('Nama: SSSSSSSSS'),
                      Text('Bank: ABC'),
                      Text('Jumlah hari: 0'),
                      Text('Jumlah Jam: 0'),
                      Text('Tarif Per Jam: 0'),
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
