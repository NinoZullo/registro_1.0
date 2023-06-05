import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:registro/mysql/DBMetodi.dart";
import "package:registro/mysql/Utente.dart";

//Pagina terminata ed Ottimizzata ✅

class Argomenti extends StatefulWidget {
  const Argomenti({Key? key}) : super(key: key);

  @override
  State<Argomenti> createState() => _ArgomentiState();
}

class _ArgomentiState extends State<Argomenti> {
  List<Map<String, dynamic>>? argomenti;
  DBMetodi db = DBMetodi();
  final DateFormat _dateFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();
    fetchArgomenti();
  }

  Future<void> fetchArgomenti() async {
    argomenti = await db.getArgomenti(idClasse_!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Argomenti"),
        centerTitle: true,
      ),
      body: argomenti != null
          ? ListView.builder(
        itemCount: argomenti!.length,
        itemBuilder: (context, index) {
          final argomento = argomenti![index];
          final descrizione = argomento["descrizione"] as String;
          final dataInserimento = argomento["data_inserimento"] as DateTime;
          final nomeDocente = argomento["nome"] as String;
          final cognomeDocente = argomento["cognome"] as String;
          final nomeMateria = argomento["nome_materia"] as String;

          return ListTile(
            title: Text(
              "$nomeMateria",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Descrizione: $descrizione",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  "Data inserimento: ${_dateFormat.format(dataInserimento)}",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  "Docente: $nomeDocente $cognomeDocente",
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
          );
        },
      )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
