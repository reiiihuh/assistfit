import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'bottomnavbar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';

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
  bool _isSubmitted = false;
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

  Future<void> _uploadFile(BuildContext context) async {
    if (_file == null && _fileBytes == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      var uri = Uri.parse('http://10.60.40.69/login/api/upload.php');
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
        // Jika file berhasil diupload, setel _isSubmitted menjadi true
        setState(() {
          _isSubmitted = true;
        });
        // Tampilkan snackbar notifikasi bahwa file berhasil diupload
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File berhasil diupload.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Jika file gagal diupload, tampilkan snackbar dengan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File gagal diupload.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi saat upload file
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Setel isLoading kembali ke false setelah proses upload selesai
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _unsubmitFile(BuildContext context) async {
    try {
      // Kirim permintaan ke server untuk menghapus file dari database menggunakan delete.php
      var url = Uri.parse('http://10.60.40.69/login/api/delete.php');
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': 3, // Ganti dengan ID file yang ingin Anda hapus
        }),
      );
      if (response.statusCode == 200) {
        // Jika file berhasil dihapus dari database
        setState(() {
          // Atur kembali status _isSubmitted menjadi false
          _isSubmitted = false;
          // Bersihkan informasi file yang diunggah sebelumnya
          _clearFile();
        });
        // Tampilkan snackbar notifikasi bahwa file berhasil di unsubmit
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File berhasil dihapus.'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Jika terjadi kesalahan saat menghapus file dari database, tampilkan snackbar dengan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File gagal dihapus.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi saat menghapus file dari database
      print('Error unsubmitting file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error unsubmitting file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Setel isLoading kembali ke false setelah proses unsubmit file selesai
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
                onPressed: _isLoading || !_isFileSelected
                    ? null
                    : _isSubmitted
                        ? () => _unsubmitFile(
                            context) // Panggil _unsubmitFile dengan menyertakan context
                        : () => _uploadFile(
                            context), // Panggil _uploadFile dengan menyertakan context
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  backgroundColor: _isSubmitted ? Colors.red : Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        _isSubmitted ? 'Unsubmit' : 'Submit',
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
