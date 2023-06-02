import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro/Pagine/InfoVoto.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Voti extends StatefulWidget {
  const Voti({Key? key}) : super(key: key);

  @override
  State<Voti> createState() => _VotiState();
}

double? media;

class _VotiState extends State<Voti> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>>? voti;
  DBMetodi db = DBMetodi();
  bool isLoading = true;
  late AnimationController _controller;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Verifica se la lista dei voti è già stata caricata
    if (voti == null) {
      fetchVoti();
    } else {
      setState(() {
        isLoading = false;
      });
    }

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }


  Future<void> fetchVoti() async {
    setState(() {
      isLoading = true;
    });
    final fetchedVoti = await db.getVoti();
    setState(() {
      voti = fetchedVoti;
      voti?.sort((b, a) => a['data_inserimento'].compareTo(b['data_inserimento']));
      media = calcolaMedia(voti);
      isLoading = false;
    });
  }


  double calcolaMedia(List<Map<String, dynamic>>? voti) {
    if (voti == null || voti.isEmpty) return 0.0;

    double somma = 0.0;
    for (final voto in voti) {
      final votoDouble = double.tryParse(voto['voto'].toString()) ?? 0.0;
      somma += votoDouble;
    }
    return somma / voti.length;
  }


  Widget buildCircularChart() {
    if (isLoading) {
      return CircularProgressIndicator();
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: CircularPercentIndicator(
          radius: 50.0.r,
          lineWidth: 13.0.w,
          percent: media! / 10.0,
          center: Text(
            media!.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 24.0.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: getProgressColor(),
          backgroundColor: Colors.grey.shade300,
        ),
      );
    }
  }


  Color getProgressColor() {
    if (media! < 5) {
      return Colors.red;
    } else if (media! < 6) {
      return Colors.yellow;
    } else if (media! < 9) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Voti",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Text(
              "$nome_ $cognome_",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          buildCircularChart(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: voti?.length ?? 0,
              itemBuilder: (context, index) {
                final voto = voti![index];
                final votoString = voto['voto'].toString();
                final dataString = voto['data_inserimento'].toString();
                final materia = voto['nome_materia'].toString();

                final votoDouble = double.tryParse(votoString) ?? 0.0;
                final data = DateTime.tryParse(dataString) ?? DateTime.now();
                final formattedDate = "${data.day}-${data.month}-${data.year}";

                Color dotColor;
                if (votoDouble >= 1 && votoDouble < 5) {
                  dotColor = Colors.red;
                } else if (votoDouble >= 6 && votoDouble < 9) {
                  dotColor = Colors.green;
                } else if (votoDouble >= 9) {
                  dotColor = Colors.blue;
                } else {
                  dotColor = Colors.orange;
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InfoVoto(
                          voto: voto,
                          formattedDate: formattedDate,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            color: dotColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              votoString,
                              style: TextStyle(
                                fontSize: 16.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              materia,
                              style: TextStyle(
                                fontSize: 16.w,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              "Data: $formattedDate",
                              style: TextStyle(
                                fontSize: 14.w,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
