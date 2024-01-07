import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/models/users.dart';
import '/componen/bulan.dart';
import '/componen/tahun.dart';
import '/API/view_absen_api.dart';
import '/API/delete_absen.dart';

class AbsenView extends StatelessWidget {
  const AbsenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AbsenViewForm(),
    );
  }
}

class AbsenViewForm extends StatefulWidget {
  const AbsenViewForm({Key? key}) : super(key: key);

  @override
  State<AbsenViewForm> createState() => _AbsenViewFormState();
}

class _AbsenViewFormState extends State<AbsenViewForm> {
  String absenDatas = '';
  String? tahun_terpilih;
  String? bulan_terpilih;

  TextEditingController materiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);

    //Ubah Sesuai dengan API
    final url = "https://pkbmharbang.com/img/";

    return FutureBuilder<Map<String, dynamic>>(
        future: ViewInputApi().UserDataAbsen(bulan_terpilih, tahun_terpilih),
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
            final absenData = jsonResponse['absenUser'] as List<dynamic>?;
            final penghasilan = jsonResponse['penghasilan'] as int;
            final formatCurrency = NumberFormat.currency(
                locale: 'id', symbol: 'Rp. ', decimalDigits: 0);

            final formattedPenghasilan = formatCurrency.format(penghasilan);

            return Scaffold(
                body: SafeArea(
                    child: Stack(children: [
              SingleChildScrollView(
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
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "DATA ABSEN MENGAJAR ANDA",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.indigo,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                    ),

                    //tanggal
                    Container(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                //kelas
                                Expanded(
                                  child: SelectInputWidget(
                                    tahun_terpilih: tahun_terpilih,
                                    tahun_dipilih: (String option) {
                                      setState(() {
                                        tahun_terpilih = option;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 10),

                                //bulan
                                Expanded(
                                  child: bulanSelect(
                                    bulan_terpilih: bulan_terpilih,
                                    bulan_dipilih: (String option) {
                                      setState(() {
                                        bulan_terpilih = option;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// The Dataaaaaaaaaaaaaaa
                          ///
                          SizedBox(height: 10),
                          if (absenData!.isNotEmpty)
                            for (var data in absenData)
                              Container(
                                padding: EdgeInsets.only(top: 10, bottom: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.only(left: 2, right: 1),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data['tanggal']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(height: 7),
                                              Text(
                                                "${data['waktu']}",
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ), // Spacer

                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: 190,
                                          padding: EdgeInsets.all(5),
                                          color: Colors.grey[300],
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Kelas ${data['kelas']}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w900),
                                              ),
                                              SizedBox(height: 3),
                                              Text(
                                                "Materi: ${data['materi']}",
                                                style: TextStyle(fontSize: 10),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      //Tombol Delete
                                      Container(
                                        padding:
                                            EdgeInsets.only(top: 1, right: 1),
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Konfirmasi'),
                                                    content: Text(
                                                        'Apakah anda yakin ingin menghapus data ini?'),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () async {
                                                          final delete =
                                                              await DeleteApi()
                                                                  .deleteing(
                                                                      data[
                                                                          'id']);

                                                          Navigator
                                                              .pushReplacementNamed(
                                                                  context,
                                                                  '/absen-view');

                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Data Berhasil di Hapus, Response: $delete")));
                                                        },
                                                        child: Text('Ya'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop(); // Tutup dialog
                                                        },
                                                        child: Text('Tidak'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 30,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          if (absenData.isEmpty)
                            Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                  "----- Tidak Ada Data Absen Pada Bulan Ini -----",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ////
                          /////
                          //////
                          /////
                        ]),
                      ),
                    ),
                    // Input date

                    // input select

                    //input text area

                    //input text
                    SizedBox(height: 50)
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Center(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.blueAccent,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Penghasilan : $formattedPenghasilan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ))),
            ])));
          }
        });

    // Layouting
  }
}
