import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:intl/intl.dart";
import "package:registro/mysql/DBMetodi.dart" show DBMetodi;
import "package:registro/mysql/Utente.dart";
import "InfoNote.dart";

// PAGINA TERMINATA ED OTTIMIZZATA CON ANIMAZIONI ✅

class NoteDisciplinari extends StatefulWidget {
  const NoteDisciplinari({Key? key}) : super(key: key);

  @override
  State<NoteDisciplinari> createState() => _NoteDisciplinariState();
}

class _NoteDisciplinariState extends State<NoteDisciplinari> {
  List<Map<String, dynamic>>? note;
  DBMetodi db = DBMetodi();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNote();
  }

  Future<void> fetchNote() async {
    setState(() {
      isLoading = true;
    });

    final fetchedNote = await db.getNote(idUtente_);
    setState(() {
      note = fetchedNote;
      note?.sort(
          (a, b) => b["data_inserimento"].compareTo(a["data_inserimento"]));
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Note Disciplinari",
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
              style: GoogleFonts.roboto(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: note?.length ?? 0,
                    itemBuilder: (context, index) {
                      final nota = note![index];
                      final dataInserimento = nota["data_inserimento"];
                      final nomeDocente = nota["nome"];
                      final cognomeDocente = nota["cognome"];

                      final formattedDate =
                          DateFormat("dd-MM-yyyy").format(dataInserimento);

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoNota(
                                nota: nota,
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
                          child: ListTile(
                            title: Text(
                              "Data: $formattedDate",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 15.sp,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Docente: $nomeDocente $cognomeDocente",
                                    style: GoogleFonts.roboto(
                                        fontSize: 15.sp, color: Colors.black)),
                                SizedBox(height: 4.h),
                              ],
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              size: 20.sp,
                              color: Colors.grey,
                            ),
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
