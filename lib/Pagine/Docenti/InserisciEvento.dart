import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/mysql/DBMetodi.dart";
//Pagina terminata ed Ottimizzata ✅

class InserisciEvento extends StatefulWidget {
  final int idClasse;
  const InserisciEvento({Key? key, required this.idClasse}) : super(key: key);

  @override
  State<InserisciEvento> createState() => _InserisciEventoState();
}

class _InserisciEventoState extends State<InserisciEvento> {
  final TextEditingController _nomeEventoController = TextEditingController();
  final TextEditingController _descrizioneController = TextEditingController();
  final TextEditingController _dataInizioController = TextEditingController();
  final TextEditingController _dataFineController = TextEditingController();
  final DBMetodi _db = DBMetodi();

  @override
  void dispose() {
    _nomeEventoController.dispose();
    _descrizioneController.dispose();
    _dataInizioController.dispose();
    _dataFineController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Caricato!",
            style: TextStyle(color: Colors.green, fontSize: 18),
          ),
          content: const Text(
            "Evento inserito con successo",
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
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

  void _insertEvento() {
    final nomeEvento = _nomeEventoController.text;
    final descrizione = _descrizioneController.text;
    final dataInizio = _dataInizioController.text;
    final dataFine = _dataFineController.text;

    if (nomeEvento.isNotEmpty &&
        descrizione.isNotEmpty &&
        dataInizio.isNotEmpty &&
        dataFine.isNotEmpty) {
      _db.addEvento(
          nomeEvento, descrizione, dataInizio, dataFine, widget.idClasse);
      _nomeEventoController.clear();
      _descrizioneController.clear();
      _dataInizioController.clear();
      _dataFineController.clear();
      _showSuccessDialog();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Errore",
              style: GoogleFonts.roboto(color: Colors.red),
            ),
            content: Text(
              "Per favore, compila tutti i campi correttamente.",
              style: GoogleFonts.roboto(color: Colors.black),
            ),
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

  bool _isFieldEmpty(String value) {
    return value.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserisci Evento"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nomeEventoController,
              decoration: const InputDecoration(
                labelText: "Nome Evento",
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.roboto(color: Colors.black),
              validator: (value) {
                if (_isFieldEmpty(value!)) {
                  return "Il campo nome evento è obbligatorio.";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descrizioneController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Descrizione",
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.roboto(color: Colors.black),
              validator: (value) {
                if (_isFieldEmpty(value!)) {
                  return "Il campo descrizione è obbligatorio.";
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
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
                      _dataInizioController.text =
                          selectedDate.toString().substring(0, 10);
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data Inizio",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _dataInizioController.text.isNotEmpty
                      ? "Data Inizio: ${_dataInizioController.text}"
                      : "Seleziona una data di inizio",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
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
                      _dataFineController.text =
                          selectedDate.toString().substring(0, 10);
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Data Fine",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _dataFineController.text.isNotEmpty
                      ? "Data Fine: ${_dataFineController.text}"
                      : "Seleziona una data di fine",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _insertEvento,
              child: const Text("Inserisci"),
            ),
          ],
        ),
      ),
    );
  }
}
