import 'package:flutter/material.dart';

class jamSelect extends StatelessWidget {
  final String? jam_terpilih;
  final Function(String) jam_dipilih;

  jamSelect({
    required this.jam_terpilih,
    required this.jam_dipilih,
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
          hint: Text("Jam Mengajar", style: TextStyle(color: Colors.indigo)),
          value: jam_terpilih,
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
              jam_dipilih(newValue);
            }
          },
          items: <String>[
            '09.00 - 09.45',
            '09.45 - 10.30',
            '10.30 - 11.15',
            '11.15 - 12.00',
            '13.00 - 13.45',
            '13.45 - 14.30',
            '14.30 - 15.15',
            '15.15 - 16.00',
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
