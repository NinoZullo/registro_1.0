import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:registro/mysql/Utente.dart";

import "InserisciNota.dart";

class AzioniStudente extends StatelessWidget {
  final int idStudente;
  final String nome;
  final String cognome;

  const AzioniStudente({
    Key? key,
    required this.idStudente,
    required this.nome,
    required this.cognome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Azioni Studente"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.w),
                child: Text(
                  "$nome $cognome",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.w,
                shrinkWrap: true,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  InserisciNota(idStudente: idStudente, idDocente: idUtente_,),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      "Inserisci Nota",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Azione: Inserisci argomento
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      "Inserisci Argomento",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Azione: Inserisci compito
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      "Inserisci Compito",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Azione: Inserisci voto
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      "Inserisci Voto",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Azione: Inserisci assenza
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      "Inserisci Assenza",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
