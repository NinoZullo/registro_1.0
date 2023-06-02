import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// PAGINA TERMINATA ED OTTIMIZZATA CON ANIMAZIONI ✅


class InfoNota extends StatelessWidget {
  final Map<String, dynamic> nota;
  final String formattedDate;

  const InfoNota({Key? key, required this.nota, required this.formattedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final descrizione = nota['descrizione'];
    final nomeDocente = nota['nome'];
    final cognomeDocente = nota['cognome'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dettagli Nota",
          style: GoogleFonts.roboto(fontSize: 20.sp, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Data: $formattedDate",
              style: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              "Docente: $nomeDocente $cognomeDocente",
              style: TextStyle(fontSize: 16.0.sp, color: Colors.black),
            ),
            SizedBox(height: 10.0.h),
            Text(
              "Descrizione:",
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5.0.h),
            Text(
              descrizione,
              style: TextStyle(fontSize: 14.0.sp, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
