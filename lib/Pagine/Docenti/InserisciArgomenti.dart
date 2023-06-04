import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/mysql/DBMetodi.dart";

class InserisciArgomento extends StatefulWidget {
  final int idClasse;

  const InserisciArgomento({Key? key, required this.idClasse}) : super(key: key);

  @override
  State<InserisciArgomento> createState() => _InserisciArgomentoState();
}

class _InserisciArgomentoState extends State<InserisciArgomento> {
  final TextEditingController _descrizioneController = TextEditingController();
  final TextEditingController _dataInserimentoController = TextEditingController();
  final TextEditingController _idAssegnazioneController = TextEditingController();
  final DBMetodi _db = DBMetodi();

  @override
  void dispose() {
    _descrizioneController.dispose();
    _dataInserimentoController.dispose();
    _idAssegnazioneController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Caricato!" , style: GoogleFonts.roboto(color: Colors.green , fontSize: 18.sp ,)),
          content: Text("Argomento inserito con successo", style: GoogleFonts.roboto(color: Colors.black , fontSize: 16.sp ,)),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _insertArgomento() {
    final descrizione = _descrizioneController.text;
    final dataInserimento = _dataInserimentoController.text;
    final idAssegnazione = int.tryParse(_idAssegnazioneController.text) ?? 0;

    if (descrizione.isNotEmpty && dataInserimento.isNotEmpty && idAssegnazione != 0) {
      _db.addArgomento(descrizione, dataInserimento, idAssegnazione);
      _descrizioneController.clear();
      _dataInserimentoController.clear();
      _idAssegnazioneController.clear();
      _showSuccessDialog();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Errore!" , style: GoogleFonts.roboto(color: Colors.red , fontSize: 18.sp ,)),
            content: Text("Compila tutti i campi per piacere", style: GoogleFonts.roboto(color: Colors.black , fontSize: 16.sp ,)),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserisci Argomento"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _descrizioneController,
              decoration: const InputDecoration(
                labelText: "Descrizione",
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(color: Colors.black),
              maxLines: 5,
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    setState(() {
                      _dataInserimentoController.text = selectedDate.toString().substring(0, 10);
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data di Inserimento",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _dataInserimentoController.text.isNotEmpty
                      ? "Data Inserimento: ${_dataInserimentoController.text}"
                      : "Seleziona Data Inserimento",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _idAssegnazioneController,
              decoration: const InputDecoration(
                labelText: "ID Assegnazione",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _insertArgomento,
              child: const Text("Inserisci"),
            ),
          ],
        ),
      ),
    );
  }
}
