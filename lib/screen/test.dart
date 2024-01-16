import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pkbm_harapan_bangsa/componen/jam.dart';
// import 'package:provider/provider.dart';
// import '/models/users.dart';
import '/componen/date.dart';
import '/componen/kelas.dart';
import '/componen/mapel.dart';
import '/API/form_input_api.dart';
// import '/API/dashboard_api.dart';

class PopupContent extends StatefulWidget {
  @override
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  // String selectedOption = 'Option 1';
  String errorMessage = '';
  DateTime? selectedDate;
  String? selectedOption;
  String? mapel_terpilih;
  String? kelas_terpilih;
  String? jam_terpilih;
  bool isLoading = false;

  TextEditingController materiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "INPUT DATA ABSEN MENGAJAR",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.w900),
                ),
              ),
              padding: EdgeInsets.only(top: 30, bottom: 10),
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
                          backgroundColor:
                              Colors.white, // Warna latar belakang label
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
                  // Tambahkan variabel untuk menentukan apakah sedang loading atau tidak

                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.orange),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(150, 50),
                      ),
                    ),
                    onPressed: () async {
                      if (selectedDate == null ||
                          jam_terpilih == null ||
                          kelas_terpilih == null ||
                          materiController.text.isEmpty ||
                          mapel_terpilih == null) {
                        setState(() {
                          errorMessage = 'Semua input harus diisi';
                        });
                        return;
                      }

                      setState(() {
                        isLoading =
                            true; // Aktifkan animasi loading saat tombol ditekan
                      });

                      String tgl =
                          DateFormat('yyyy-MM-dd').format(selectedDate!);
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
                          errorMessage = 'Input Absen Gagal: $e';
                        });
                        print('Input Absen Gagal: $e');
                      } finally {
                        setState(() {
                          isLoading =
                              false; // Matikan animasi loading setelah proses selesai
                        });
                      }
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.orange),
                          )
                        : Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
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
                    borderRadius:
                        BorderRadius.circular(15), // Membuat border rounded
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ],
        ),
      )),
      actions: [
        TextButton(
          onPressed: () {
            // Tutup pop-up
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
