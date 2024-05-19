import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mockup_assistfit/bottomnavbar.dart';

void main() {
  runApp(MyApp());
}

// Main application widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadBAPScreen(),
    );
  }
}

// Screen widget for uploading BAP
class UploadBAPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Upload BAP',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with icon and title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.file_present,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Upload BAP',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 30), // Adjust the height as needed
                    Text(
                      'Due 30 May 2024 at 23:59',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            // Container for file upload area
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // Changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 50,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Your work\nNot submitted',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Submit button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement submit button functionality here
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor:
                      Colors.green, // Match the color of download button
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30.0), // Match the border radius
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Note section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NOTE:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Kolom paraf asprak dan tanda tangan koordinator dosen mata kuliah harap dikosongkan terlebih dahulu karena harus tanda tangan basah.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(), // Custom bottom navigation bar
    );
  }
}

// Notes:
// 1. The `UploadBAPScreen` widget provides a UI for uploading BAP files with a deadline indicator.
// 2. The file upload area is currently static. You need to implement the functionality to allow users to upload files.
// 3. The submit button does not perform any action at the moment. Add the necessary logic to handle file submission.
// 4. The `BottomNav` widget is assumed to be a custom bottom navigation bar imported from another file.
// 5. Adjust the padding, colors, and other UI elements as needed to fit the overall design of your application.
// 6. Ensure all necessary packages are included in your `pubspec.yaml` file for the app to function correctly.
