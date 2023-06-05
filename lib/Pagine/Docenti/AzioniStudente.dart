import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:registro/Pagine/Docenti/InserisciAnnotazione.dart";
import "package:registro/Pagine/Docenti/InserisciArgomenti.dart";
import "package:registro/Pagine/Docenti/InserisciAssenza.dart";
import "package:registro/Pagine/Docenti/InserisciCompito.dart";
import "package:registro/Pagine/Docenti/InserisciEvento.dart";
import "package:registro/Pagine/Docenti/InserisciNota.dart";
import "package:registro/Pagine/Docenti/InserisciVoto.dart";
import "package:registro/mysql/Utente.dart";
//Pagina terminata ed Ottimizzata ✅

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
        title: const Text("Azioni Studente"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 20.w,
            children: [
              ActionContainer(
                Colore: Colors.blue,
                Testo: "Inserisci Nota",
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
              ),
              ActionContainer(
                Colore: Colors.blue,
                Testo: "Inserisci Argomento",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InserisciArgomento(idClasse: idClasse),
                    ),
                  );
                },
              ),
              ActionContainer(
                Colore: Colors.blue,
                Testo: "Inserisci Compito",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InserisciCompito(),
                    ),
                  );
                },
              ),
              ActionContainer(
                Colore: Colors.blue,
                Testo: "Inserisci Voto",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InserisciVoto(idStudente: idStudente),
                    ),
                  );
                },
              ),
              ActionContainer(
                Colore: Colors.blue,
                Testo: "Inserisci Assenza",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InserisciAssenza(idStudente: idStudente),
                    ),
                  );
                },
              ),
              ActionContainer(
                Colore: Colors.blue,
                Testo: "Inserisci Annotazione",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InserisciAnnotazione(idStudente: idStudente),
                    ),
                  );
                },
              ),
              ActionContainer(
                Colore: Colors.blue,
                Testo: "Inserisci Evento",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InserisciEvento(idClasse: idClasse),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionContainer extends StatelessWidget {
  final Color Colore;
  final String Testo;
  final VoidCallback onPressed;

  const ActionContainer({
    Key? key,
    required this.Colore,
    required this.Testo,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colore,
          borderRadius: BorderRadius.circular(15.w),
        ),
        child: Center(
          child: Text(
            Testo,
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
