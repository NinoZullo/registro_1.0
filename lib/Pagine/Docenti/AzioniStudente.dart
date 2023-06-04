import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registro/Pagine/Docenti/InserisciAnnotazione.dart';
import 'package:registro/Pagine/Docenti/InserisciArgomenti.dart';
import 'package:registro/Pagine/Docenti/InserisciCompito.dart';
import 'package:registro/Pagine/Docenti/InserisciNota.dart';
import 'package:registro/Pagine/Docenti/InserisciVoto.dart';
import 'package:registro/mysql/Utente.dart';

class AzioniStudente extends StatelessWidget {
  final int idStudente;
  final int idClasse;
  final String nome;
  final String cognome;

  const AzioniStudente({
    Key? key,
    required this.idStudente,
    required this.idClasse,
    required this.nome,
    required this.cognome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Azioni Studente'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.w),
                child: Text(
                  '$nome $cognome',
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
                          builder: (context) => InserisciNota(
                            idStudente: idStudente,
                            idDocente: idUtente_,
                          ),
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
                      'Inserisci Nota',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              InserisciArgomento(idClasse: idClasse),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      'Inserisci Argomento',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InserisciCompito()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      'Inserisci Compito',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  InserisciVoto(idStudente: idStudente,)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      'Inserisci Voto',
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
                      'Inserisci Assenza',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InserisciAnnotazione(
                            idStudente: idStudente,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      'Inserisci Annotazione',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.w),
                      ),
                    ),
                    child: Text(
                      'Inserisci Evento',
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
