import 'package:flutter/material.dart';
import 'package:pkbm_harapan_bangsa/API/register_api.dart';

class MySignUp extends StatelessWidget {
  const MySignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MySignUpForm(),
    );
  }
}

class MySignUpForm extends StatefulWidget {
  const MySignUpForm({Key? key}) : super(key: key);

  @override
  State<MySignUpForm> createState() => _MySignUpFormState();
}

class _MySignUpFormState extends State<MySignUpForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController konfirmasiPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Image.asset(
                  'assets/up.png', // Ganti dengan path logo yang sesuai
                  height: 130, // Sesuaikan ukuran gambar
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register Your Account',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Text(
                  'User proper information to continue',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10), // Spacer vertical antara teks
              ],
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        13.0), // Mengatur sudut menjadi lebih bulat
                  ),
                  labelText: 'Full Name',
                  prefixIcon:
                      Icon(Icons.person), // Menambahkan ikon di sebelah kiri
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        13.0), // Mengatur sudut menjadi lebih bulat
                  ),
                  labelText: 'Email',
                  prefixIcon:
                      Icon(Icons.mail), // Menambahkan ikon di sebelah kiri
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
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
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: konfirmasiPasswordController,
                obscureText: true, // Ini yang menyembunyikan teks input
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  labelText: 'Konfirmasi Password',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('By signing up, you agree to our'),
                TextButton(
                  child: const Text(
                    'Terms & Conditions',
                    style: TextStyle(fontSize: 14),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        13.0), // Mengatur sudut menjadi lebih bulat
                  ),
                ),
                child: const Text('Create Account'),
                onPressed: () async {
                  String email = emailController.text;
                  String name = nameController.text;
                  String password = passwordController.text;
                  String konfirmasipassword = konfirmasiPasswordController.text;

                  try {
                    String? message = await RegisterApi().authenticate(
                        name, email, password, konfirmasipassword);
                    print('$message');

                    Navigator.pushReplacementNamed(context, '/login',
                        arguments: message);
                  } catch (e) {
                    // Tangani error saat login gagal
                    print('REGISTER failed: $e');
                  }
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              children: <Widget>[
                const Text('Already have an account?'),
                TextButton(
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
