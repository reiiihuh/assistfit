import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'bottomnavbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadBAPP1(),
    );
  }
}

class UploadBAPP1 extends StatefulWidget {
  @override
  _UploadBAPP1State createState() => _UploadBAPP1State();
}

class _UploadBAPP1State extends State<UploadBAPP1> {
  File? _file;
  Uint8List? _fileBytes;
  bool _isLoading = false;
  String? _fileName;
  bool _isFileSelected = false;

  void _clearFile() {
    setState(() {
      _file = null;
      _fileBytes = null;
      _fileName = null;
      _isFileSelected = false;
    });
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
      if (result != null) {
        if (kIsWeb) {
          // If running on web
          setState(() {
            _fileBytes = result.files.single.bytes;
            _fileName = result.files.single.name;
            _isFileSelected = true;
          });
        } else {
          setState(() {
            _file = File(result.files.single.path!);
            _fileName = result.files.single.name;
            _isFileSelected = true;
          });
        }
      } else {
        print('No file selected.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _uploadFile() async {
    if (_file == null && _fileBytes == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      var uri = Uri.parse('http://192.168.1.11/login/api/upload.php');
      var request = http.MultipartRequest('POST', uri);

      if (kIsWeb) {
        // If running on web
        var multipartFile = http.MultipartFile.fromBytes(
          'file',
          _fileBytes!,
          filename: _fileName,
        );
        request.files.add(multipartFile);
      } else {
        var stream = http.ByteStream(_file!.openRead());
        var length = await _file!.length();
        var multipartFile = http.MultipartFile('file', stream, length,
            filename: basename(_file!.path));
        request.files.add(multipartFile);
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        print('File uploaded successfully.');
      } else {
        print('File upload failed.');
      }
    } catch (e) {
      print('Error uploading file: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Upload BAPP',
          style: TextStyle(
            color: Colors.black,
          ),
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
                      'Upload BAPP',
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
            Stack(
              children: [
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
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
                      child: _file == null && _fileBytes == null
                          ? Row(
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
                            )
                          : Text(_fileName ?? ''),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: _clearFile,
                    icon: Icon(Icons.clear),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),
            // Note section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 202, 202, 202), // Border color
                  width: 1.0, // Border width
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
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
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading || !_isFileSelected ? null : _uploadFile,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0), // Border color
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(), // Custom bottom navigation bar
    );
  }
}
