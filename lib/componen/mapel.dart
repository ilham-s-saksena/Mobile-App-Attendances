import 'package:flutter/material.dart';

class mapelSelect extends StatelessWidget {
  final String? mapel_terpilih;
  final Function(String) mapel_dipilih;

  mapelSelect({
    required this.mapel_terpilih,
    required this.mapel_dipilih,
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
          hint: Text("Mata Pelajaran", style: TextStyle(color: Colors.orange)),
          value: mapel_terpilih,
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.orange,
          ),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold),
          onChanged: (String? newValue) {
            if (newValue != null) {
              mapel_dipilih(newValue);
            }
          },
          items: <String>[
            'Matematika',
            'B Indonesia',
            'B Jawa',
            'B Inggris',
            'IPA',
            'IPS',
            'PAI',
            'PKN',
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
