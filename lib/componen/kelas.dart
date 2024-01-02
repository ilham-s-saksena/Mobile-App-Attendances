import 'package:flutter/material.dart';

class SelectInputWidget extends StatelessWidget {
  final String? kelas_terpilih;
  final Function(String) kelas_dipilih;

  SelectInputWidget({
    required this.kelas_terpilih,
    required this.kelas_dipilih,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text("Pilih Kelas", style: TextStyle(color: Colors.indigo)),
          value: kelas_terpilih,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.indigo,
          ),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.bold),
          onChanged: (String? newValue) {
            if (newValue != null) {
              kelas_dipilih(newValue);
            }
          },
          items: <String>[
            '5',
            '6',
            '7',
            '8',
            '9',
            '10',
            '11',
            '12',
            // ... Add more options as needed
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
