import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/API/login_api.dart';
import '/models/users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Future<String?> getToken() async {
  return await storage.read(key: 'Harbang.Januari@12');
}

class MySignIn extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _authenticate(BuildContext context) async {
    final apiManager = Provider.of<LoginApi>(context, listen: false);
    final userManager = Provider.of<UserManager>(context, listen: false);
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final token = await apiManager.authenticate(email, password);
      userManager.setAuthToken(token);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));

      print('Errorrsr: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as String?;

    return FutureBuilder<String?>(
      future: getToken(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // Jika token tersedia, arahkan pengguna ke halaman dashboard
          final authToken = snapshot.data;
          if (authToken != null) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, '/dashboard');
            });
          }

          // Kode tampilan login Anda
          return Scaffold(
              body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: [
                      if (message != null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green,
                          ),
                          padding: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              message,
                              style: TextStyle(
                                color: Colors.white,
                                // Atur warna sesuai kebutuhan
                              ),
                            ),
                          ),
                        ),

                      Image.asset(
                        'assets/top.png', // Ganti dengan path logo yang sesuai
                        height: 130, // Sesuaikan ukuran gambar
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Text(
                        'Enter valid user name & password to continue',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 10), // Spacer vertical antara teks
                    ],
                  ),

                  //username
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              13.0), // Mengatur sudut menjadi lebih bulat
                        ),
                        labelText: 'Email',
                        prefixIcon: Icon(
                            Icons.person), // Menambahkan ikon di sebelah kiri
                      ),
                    ),
                  ),

                  //password
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true, // Ini yang menyembunyikan teks input
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.key),
                      ),
                    ),
                  ),

                  //----------------------------------------------------------------
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          //forgot password screen
                        },
                        child: const Text(
                          'Forgot Password',
                        ),
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                      ),
                      child: const Text('Login'),
                      onPressed: () async {
                        _authenticate(context);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5.0, left: 11),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            endIndent: 10,
                          ),
                        ),
                      ),
                      Text(
                        'Or Continue With',
                        style: TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, right: 11),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Handle action for Google button
                        },
                        icon: Image.asset(
                          'assets/google_logo.png',
                          height: 24,
                        ),
                        label: Text('Google'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          //
                        },
                        icon: Image.asset(
                          'assets/facebook_logo.png',
                          height: 24,
                        ),
                        label: Text('Facebook'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          primary: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/register');
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(right: 5.0, left: 11),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            endIndent: 10,
                          ),
                        ),
                      ),
                      Text(
                        '© 2024-2025 PKBM Harapan Bangsa™. All Rights Reserved.',
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 5.0, right: 11),
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                            indent: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ));
        }
      },
    );
  }
}
