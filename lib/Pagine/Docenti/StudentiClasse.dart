import 'package:flutter/material.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/Pagine/Docenti/AzioniStudente.dart';

class StudentiClasse extends StatefulWidget {
  final int idClasse;
  final String nomeClasse;

  const StudentiClasse({Key? key, required this.idClasse, required this.nomeClasse})
      : super(key: key);

  @override
  State<StudentiClasse> createState() => _StudentiClasseState();
}

class _StudentiClasseState extends State<StudentiClasse> {
  DBMetodi db = DBMetodi();

  Future<List<Map<String, dynamic>>?> getStudenti() async {
    return await db.getStudenti(widget.idClasse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Studenti della Classe - ${widget.nomeClasse}'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>?>(
        future: getStudenti(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            final studenti = snapshot.data!;
            return ListView.builder(
              itemCount: studenti.length,
              itemBuilder: (context, index) {
                final studente = studenti[index];
                final nome = studente['nome'] as String;
                final cognome = studente['cognome'] as String;
                final idStudente = studente['id_studente'] as int;

                return ListTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$nome $cognome',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AzioniStudente(
                          idStudente: idStudente,
                          nome: nome,
                          cognome: cognome,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Impossibile Caricare gli studenti'));
          }
        },
      ),
    );
  }
}
