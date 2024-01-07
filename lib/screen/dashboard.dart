import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/users.dart';
// import '/models/user.dart';
import '/API/dashboard_api.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardForm(),
    );
  }
}

class DashboardForm extends StatefulWidget {
  const DashboardForm({Key? key}) : super(key: key);

  @override
  State<DashboardForm> createState() => _DashboardFormState();
}

class _DashboardFormState extends State<DashboardForm> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as String?;
    final userManager = Provider.of<UserManager>(context);

    //Ubah Sesuai API anda
    final url = "https://pkbmharbang.com/img/";

    //--

    //--
    return FutureBuilder<Map<String, dynamic>>(
        future: RegisterApi().dashboardData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            Navigator.pushReplacementNamed(context, '/login');

            return Center();
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
                                  Column(
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
                                      ),
                                    ],
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
                                        Navigator.pushReplacementNamed(
                                            context, '/login');
                                        userManager.logout();
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

                    // Laporan JPL

                    // -----------

                    //----------

                    Container(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.indigo,
                                ),
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // JPL BULAN INI
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Bulan Ini',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 1, right: 1),
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Text(
                                                      "${jsonResponse['BulanIni']}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 36,
                                                        color: Colors.indigo,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'JPL',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // SPACER

                            // SPACER

                            SizedBox(width: 8), // Spacer

                            //

                            //
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.indigo,
                                ),
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    //JPL HARI INI
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Hari Ini',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 1, right: 1),
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white,
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: 5, right: 5),
                                                    child: Text(
                                                      "${jsonResponse['HariIni']}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 36,
                                                        color: Colors.indigo,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'JPL',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 12),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/formAbsen');
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                padding: EdgeInsets.only(top: 18, bottom: 18),
                              ),
                              label: Text(
                                "Isi Absen Mengajar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: Icon(
                                Icons
                                    .file_open_outlined, // Ganti dengan ikon yang diinginkan
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    if (message != null)
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(
                                15), // Membuat border rounded
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  message,
                                  style: TextStyle(color: Colors.white),
                                  overflow: TextOverflow
                                      .ellipsis, // Menggunakan ellipsis jika terlalu panjang
                                  maxLines: 4, // Batasi maksimal 2 baris
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(
                      height: 15,
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 160),
                      decoration: BoxDecoration(
                        color: Colors.indigo[100],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.indigo,
                                    ),
                                    padding: EdgeInsets.only(left: 2, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: Colors.indigo,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Honor Anda',
                                                style: TextStyle(
                                                  color: Colors.grey[300],
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                'Bulan Ini',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              // Honor
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 1, right: 1),
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            padding: EdgeInsets.all(5),
                                            child: Text(
                                              formattedPenghasilan,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30,
                                                color: Colors.indigo,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: 16), // Jarak antara kontainer dan tombol
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 1),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/absen-view');
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  padding: EdgeInsets.all(14)),
                              child: Text(
                                "Lihat Selengkapnya",
                                style: TextStyle(
                                  color: Colors.indigo[900],
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "• Data Absen Mengjar Terkini",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.indigo,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.indigo, // Warna latar belakang
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 16, right: 16, top: 12),
                                      child: Column(
                                        children: [
                                          ///
                                          //////
                                          ///
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Tanggal',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // SPACER

                                              //
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Kelas',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              ///
                                              ///
                                              ///
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Jam',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize: 14,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              ///
                                              ///
                                              ///
                                            ],
                                          ),

                                          ///////
                                          ///////
                                          ///
                                          ///
                                          SizedBox(height: 10),

                                          ///
                                          ///
                                          ///
                                          //////
                                          //////

                                          if (absenData!.isNotEmpty)
                                            for (var data in absenData)
                                              Container(
                                                color: Colors.white,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  data[
                                                                      'tanggal'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // SPACER

                                                    //
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Kelas ${data['kelas']}",
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    ///
                                                    ///
                                                    ///
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  data['waktu'],
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    ///
                                                    ///
                                                    ///
                                                  ],
                                                ),
                                              )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Tabel

                              // Footer
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                  child: Container(
                                    color: Colors
                                        .indigo, // Warna latar belakang footer
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            // Handle button press
                                          },
                                          label: Text(
                                            'Lihat Selengkapnya',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          icon: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        });

    // Layouting
  }
}
