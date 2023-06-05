import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:registro/Pagine/Docenti/AssistenteDocenti.dart";
import "package:registro/mysql/DBMetodi.dart";
import "package:registro/Pagine/Docenti/StudentiClasse.dart";
import "../../metodi/Metodi.dart";
import "../../mysql/Utente.dart";
import "HomePageDocenti.dart";
//Pagina terminata ed Ottimizzata ✅

class Classi extends StatefulWidget {
  const Classi({Key? key}) : super(key: key);

  @override
  State<Classi> createState() => _ClassiState();
}

class _ClassiState extends State<Classi> {
  DBMetodi db = DBMetodi();
  final int _selectedIndex = 0;

  Future<List<Map<String, dynamic>>?> getClassi() async {
    return await db.getClassi(idUtente_);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Text(
              "Seleziona una classe",
              style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>?>(
              future: getClassi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Errore nel caricamento"));
                } else if (snapshot.hasData) {
                  final classi = snapshot.data!;
                  return ListView.builder(
                    itemCount: classi.length,
                    itemBuilder: (context, index) {
                      final classe = classi[index];
                      final idClasse = classe["id_classe"];
                      final nomeClasse = classe["nome_classe"] as String;
                      final nomeMateria = classe["nome_materia"] as String;

                      return ListTile(
                        title: Row(
                          children: [
                            const Icon(Icons.school, color: Colors.blue),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              "$nomeClasse - $nomeMateria",
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
                              builder: (context) => StudentiClasse(
                                idClasse: idClasse,
                                nomeClasse: nomeClasse,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: Text("Non sono stati trovati dati nel database"));
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          It("Classi", Icons.people_alt_rounded),
          It("Home", Icons.home),
          It("Assistente", Icons.help),
        ],
        onTap: (currentIndex) {
          switch (currentIndex) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePageDocenti(),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssistenteDocenti(),
                ),
              );
              break;
          }
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
