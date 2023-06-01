import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:registro/Pagine/Widget/HeaderHeight.dart';
import 'package:registro/mysql/DBMetodi.dart';
import 'package:registro/mysql/Utente.dart';

class Compiti extends StatefulWidget {
  const Compiti({Key? key}) : super(key: key);

  @override
  State<Compiti> createState() => _CompitiState();
}

class _CompitiState extends State<Compiti> {
  List<Map<String, dynamic>>? compiti;
  DBMetodi db = DBMetodi();
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    fetchData();
  }
double _headerHeight = 100.h;
  Future<void> fetchData() async {
    compiti = await db.getCompiti(idClasse_!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compiti'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(_headerHeight),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: compiti != null
                ? ListView.builder(
              itemCount: compiti!.length,
              itemBuilder: (context, index) {
                final compito = compiti![index];
                final scadenza = _dateFormat.format(compito['scadenza']);
                final descrizione = compito['descrizione'];
                final nome = compito['nome'];
                final cognome = compito['cognome'];
                final materia = compito['nome_materia'];

                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.assignment,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    '$materia - Scadenza: $scadenza',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    'Descrizione: $descrizione\nDocente: $nome $cognome',
                    style:  TextStyle(fontSize: 16.sp ,                       color: Colors.black,
                    ),
                  ),
                );
              },
            )
                : const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
