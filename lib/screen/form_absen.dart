import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pkbm_harapan_bangsa/componen/jam.dart';
import 'package:provider/provider.dart';
import '/models/users.dart';
import '/componen/date.dart';
import '/componen/kelas.dart';
import '/componen/mapel.dart';
import '/API/form_input_api.dart';
import '/API/dashboard_api.dart';

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(),
        child: InputForm(),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  String errorMessage = '';
  DateTime? selectedDate;
  String? selectedOption;
  String? mapel_terpilih;
  String? kelas_terpilih;
  String? jam_terpilih;

  TextEditingController materiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);
    double minHeight = MediaQuery.of(context).size.height;

    //API SUdah DI Hosting
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

            return Scaffold(
              body: SingleChildScrollView(
                  child: Container(
                color: Colors.black87,
                height: minHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          color: Colors.orange,
                        ),
                        padding: EdgeInsets.only(left: 2, right: 8, top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Colors.orange,
                              ),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  //Back

                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(50),
                                      topLeft: Radius.circular(50),
                                    ),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.orangeAccent),
                                          minimumSize:
                                              MaterialStateProperty.all<Size>(
                                                  Size(40, 40)),
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

                                  SizedBox(width: 10),

                                  // Foto Profile
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Atur nilai sesuai keinginan untuk membuat sudut gambar menjadi rounded
                                    child: Image.network(
                                      "${url}${Uri.encodeFull(userData['foto'])}",
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  SizedBox(width: 12),

                                  // Nama User
                                  Container(
                                    width: 115,
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
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(40),
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: DropdownButton<String>(
                                    hint: Icon(
                                      Icons.settings,
                                      size: 30,
                                      color: Colors.orange,
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
                                                color: Colors.orange,
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
                                                color: Colors.orange,
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
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "INPUT DATA ABSEN MENGAJAR",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.orange,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                    ),

                    //tanggal
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Container(
                            child: DateInputWidget(
                              selectedDate: selectedDate,
                              onSelectDate: (DateTime date) {
                                setState(() {
                                  selectedDate = date;
                                });
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                //kelas
                                Expanded(
                                  child: SelectInputWidget(
                                    kelas_terpilih: kelas_terpilih,
                                    kelas_dipilih: (String option) {
                                      setState(() {
                                        kelas_terpilih = option;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),

                                //mapel
                                Expanded(
                                  child: mapelSelect(
                                    mapel_terpilih: mapel_terpilih,
                                    mapel_dipilih: (String option) {
                                      setState(() {
                                        mapel_terpilih = option;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              cursorColor: Colors.orange,
                              controller: materiController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                iconColor: Colors.orange,

                                focusColor: Colors.orange,
                                prefixIconColor: Colors.orange,
                                suffixIconColor: Colors.orange,

                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.white, // Warna border
                                  ),
                                ),
                                labelText: 'Materi',
                                labelStyle: TextStyle(
                                  color: Colors.orange, // Warna teks label
                                  backgroundColor: Colors
                                      .white, // Warna latar belakang label
                                ),
                                prefixIcon: Icon(Icons
                                    .book_rounded), // Menambahkan ikon di sebelah kiri
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: jamSelect(
                                      jam_terpilih: jam_terpilih,
                                      jam_dipilih: (String option) {
                                        setState(() {
                                          jam_terpilih = option;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.orange),
                                ),
                              ),
                              minimumSize: MaterialStateProperty.all<Size>(
                                  Size(150, 50)), // Atur ukuran minimum tombol
                            ),
                            onPressed: () async {
                              if (selectedDate == null ||
                                  jam_terpilih == null ||
                                  kelas_terpilih == null ||
                                  materiController.text.isEmpty ||
                                  mapel_terpilih == null) {
                                setState(() {
                                  errorMessage =
                                      'Semua input harus diisi'; // Pesan error jika ada input yang kosong
                                });
                                return; // Berhenti eksekusi jika ada input yang kosong
                              }

                              String tgl = DateFormat('yyyy-MM-dd')
                                  .format(selectedDate!);
                              String jam = jam_terpilih as String;
                              String kelas = kelas_terpilih as String;
                              String materi = materiController.text;
                              String mapel = mapel_terpilih as String;

                              try {
                                Map<String, dynamic> message =
                                    await InputApi().inputAbsent(
                                  tgl,
                                  jam,
                                  kelas,
                                  mapel,
                                  materi,
                                );
                                print('$message');
                                Navigator.pushNamed(context, '/dashboard',
                                    arguments: 'INPUT DATA ABSEN BERHASIL!');
                              } catch (e) {
                                setState(() {
                                  errorMessage =
                                      'Input Absen Gagal: $e'; // Simpan pesan error di variabel errorMessage
                                });
                                print('Input Absen Gagal: $e');
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                      ),
                    ),

                    // Input date

                    // input select

                    //input text area

                    //input text
                    SizedBox(height: 15),

                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                                15), // Membuat border rounded
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  errorMessage,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow
                                      .ellipsis, // Menggunakan ellipsis jika terlalu panjang
                                  maxLines: 4, // Batasi maksimal 2 baris
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              )),
            );
          }
        });

    // Layouting
  }
}
