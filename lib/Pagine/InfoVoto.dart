/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class InfoVoto extends StatelessWidget {
  final Map<String, dynamic> voto;
  final String formattedDate;

  const InfoVoto({super.key, required this.voto, required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    final String materia = voto['nome_materia'].toString();
    final String votoString = voto['voto'].toString();
    final String descrizione = voto['descrizione'].toString();
    final String insegnante = '${voto['nome']} ${voto['cognome']}';

    String tipologia;
    if (voto['tipo'] == 'O') {
      tipologia = 'Orale';
    } else if (voto['tipo'] == 'S') {
      tipologia = 'Scritto';
    } else if (voto['tipo'] == 'P') {
      tipologia = 'Pratico';
    } else {
      tipologia = 'Sconosciuta';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Info Voto",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
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
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Voto: $votoString",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,

              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Data: $formattedDate",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Descrizione: $descrizione",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,

              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Insegnante: $insegnante",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,

              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Tipologia: $tipologia",
              style: TextStyle(
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
