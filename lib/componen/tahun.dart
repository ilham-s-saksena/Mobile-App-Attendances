import 'package:flutter/material.dart';

class SelectInputWidget extends StatelessWidget {
  final String? tahun_terpilih;
  final Function(String) tahun_dipilih;

  SelectInputWidget({
    required this.tahun_terpilih,
    required this.tahun_dipilih,
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
          hint: Text("Tahun", style: TextStyle(color: Colors.indigo)),
          value: tahun_terpilih,
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
              tahun_dipilih(newValue);
            }
          },
          items: <String>[
            '2023',
            '2024',
            '2025',
            '2026',
            '2027',
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
