import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";

class InfoCompiti extends StatelessWidget {
  final Map<String, dynamic> compito;
  final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

  InfoCompiti({super.key, required this.compito});

  @override
  Widget build(BuildContext context) {
    final scadenza = _dateFormat.format(compito["scadenza"]);
    final descrizione = compito["descrizione"];
    final nomeDocente = compito["nome"];
    final cognomeDocente = compito["cognome"];
    final materia = compito["nome_materia"];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dettagli Compito",
          style: GoogleFonts.roboto(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Materia: $materia",
              style: GoogleFonts.roboto(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Scadenza: $scadenza",
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Descrizione:",
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              descrizione,
              style: GoogleFonts.roboto(
                fontSize: 14.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Docente: $nomeDocente $cognomeDocente",
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
