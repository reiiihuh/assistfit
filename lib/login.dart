import 'package:flutter/material.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Image(
                    image: AssetImage('images/logo1.png'),
                    height: 150,
                    width: 300,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Supported by:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Image(
                  image: AssetImage('images/logo fit.png'),
                  height: 100,
                  width: 100,
                ),
              ],
            ),
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Image(
                              image: AssetImage('images/logo1.png'),
                              height: 100,
                              width: 200,
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _usernameController,
                              decoration: const InputDecoration(
                                labelText: 'Email SSO',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.black87),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black87),
                              onChanged: (value) {
                                setState(() {
                                  _isButtonEnabled = value.isNotEmpty &&
                                      _passwordController.text.isNotEmpty;
                                });
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(color: Colors.black87),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.redAccent),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black87),
                              onChanged: (value) {
                                setState(() {
                                  _isButtonEnabled =
                                      _usernameController.text.isNotEmpty &&
                                          value.isNotEmpty;
                                });
                              },
                            ),
                            const SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: _isButtonEnabled
                                  ? () {
                                      String username =
                                          _usernameController.text;
                                      String password =
                                          _passwordController.text;

                                      if ((username ==
                                                  "ahra@student.telkomuniversity.ac.id" &&
                                              password == "6701223079") ||
                                          (username ==
                                                  "fadli@student.telkomuniversity.ac.id" &&
                                              password == "6701220024") ||
                                          (username ==
                                                  "reihan@student.telkomuniversity.ac.id" &&
                                              password == "6701220122") ||
                                          (username == "admin" &&
                                              password == "123")) {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'Login gagal!',
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                              content: const Text(
                                                'Akun kamu tidak terdaftar menjadi asprak, silahkan ke Lab FIT lt 1',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              backgroundColor: Colors.white,
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 60),
                                backgroundColor: Colors.green,
                              ),
                              child: const Text(
                                'Masuk dengan SSO',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
