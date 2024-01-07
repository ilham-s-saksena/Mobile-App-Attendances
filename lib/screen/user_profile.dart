import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '/models/users.dart';
// import '/models/user.dart';
import '/API/dashboard_api.dart';
import '/API/profile_api.dart';
// import 'package:intl/intl.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserProfileForm(),
    );
  }
}

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({Key? key}) : super(key: key);

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  File? _imageFile;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile != null) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final passwordConfirm = _passwordConfirmController.text;
      final result = await ApiService.uploadImage(
          _imageFile!, name, email, password, passwordConfirm);

      final message = jsonDecode(result!);
      final notify = message['message'];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(notify)));
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, '/user-profile'),
      );
    } else {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final passwordConfirm = _passwordConfirmController.text;
      final result = await ApiService.uploadNoImage(
          name, email, password, passwordConfirm);

      final message = jsonDecode(result!);
      final notify = message['message'];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(notify)));
      Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, '/user-profile'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);

    //API SUdah di Hosting
    final url = "https://pkbmharbang.com/img/";

    return FutureBuilder<Map<String, dynamic>>(
        future: RegisterApi().dashboardData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            final jsonResponse = snapshot.data!;
            final userData = jsonResponse['user'];
            _emailController.text = userData['email'];
            _nameController.text = userData['name'];

            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.indigo,
                        ),
                        padding: EdgeInsets.only(left: 2, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.indigo,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  //Back

                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.indigoAccent),
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                  Size(50, 50)),
                                          padding: MaterialStateProperty.all<
                                                  EdgeInsetsGeometry>(
                                              EdgeInsets.zero),
                                          alignment: Alignment.center,
                                        ),
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, '/dashboard');
                                        },
                                        child: Icon(Icons.arrow_back,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 12),

                                  // Foto Profile
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Atur nilai sesuai keinginan untuk membuat sudut gambar menjadi rounded
                                    child: Image.network(
                                      "${url}${userData['foto']}",
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  SizedBox(width: 12),

                                  // Nama User
                                  Container(
                                    width: 130,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${userData['name']}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),

                                        //Email User
                                        Text(
                                          "${userData['email']}",
                                          style: TextStyle(
                                            color: Colors.grey[300],
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow
                                              .ellipsis, // Menggunakan ellipsis jika terlalu panjang
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Tombol Setting
                            Container(
                              padding: EdgeInsets.only(top: 1, right: 1),
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: DropdownButton<String>(
                                    hint: Icon(
                                      Icons.settings,
                                      size: 30,
                                      color: Colors.indigo,
                                    ),
                                    iconSize: 0,
                                    style: TextStyle(
                                        fontSize: 0, color: Colors.black),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'settings',
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.settings,
                                                size: 30,
                                                color: Colors.indigo,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DropdownMenuItem<String>(
                                        value: 'logout',
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.exit_to_app,
                                                size: 30,
                                                color: Colors.indigo,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                    onChanged: (value) {
                                      if (value == 'logout') {
                                        userManager.logout();
                                        Navigator.pushReplacementNamed(
                                            context, '/login');
                                      } else if (value == 'settings') {
                                        Navigator.pushReplacementNamed(
                                            context, '/user-profile');
                                      }
                                    },
                                  ),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Center(
                            child: Text(
                              "UBAH DATA PROFIL",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Form

                          //--

                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      10), // Atur nilai sesuai keinginan untuk membuat sudut gambar menjadi rounded
                                  child: _imageFile != null
                                      ? Image.file(
                                          _imageFile!,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          "${url}${userData['foto']}",
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                ),

                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () =>
                                      _pickImage(ImageSource.camera),
                                  child: Text(
                                    "Ganti Foto",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                SizedBox(height: 20),

                                // Email Kolom

                                //-------------
                                TextFormField(
                                  controller: _emailController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon:
                                        Icon(Icons.mail, color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 20),

                                // Nama Kolom

                                //-------------
                                TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    hintStyle: TextStyle(color: Colors.white),
                                    labelText: 'Nama',
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon:
                                        Icon(Icons.person, color: Colors.white),
                                  ),
                                ),

                                SizedBox(height: 20),

                                //-------
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right: 5.0, left: 11),
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                          endIndent: 10,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Ganti Password',
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.white),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 5.0, right: 11),
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                          indent: 10,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),

                                TextFormField(
                                  controller: _passwordController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    labelText: 'Password Lama',
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon:
                                        Icon(Icons.key, color: Colors.white),
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),

                                TextFormField(
                                  controller: _passwordConfirmController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(13.0),
                                    ),
                                    labelText: 'Password Baru',
                                    labelStyle: TextStyle(color: Colors.white),
                                    prefixIcon:
                                        Icon(Icons.key, color: Colors.white),
                                  ),
                                ),

                                SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: _uploadImage,
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),

                          //--

                          //--
                        ]),
                      ),
                    ),

                    // New Code
                  ],
                ),
              ),
            );
          }
        });

    // Layouting
  }
}
