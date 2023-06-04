import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/mysql/DBMetodi.dart";

//Pagina terminata ed Ottimizzata ✅
class InserisciCompito extends StatefulWidget {
  const InserisciCompito({Key? key}) : super(key: key);

  @override
  State<InserisciCompito> createState() => _InserisciCompitoState();
}

class _InserisciCompitoState extends State<InserisciCompito> {
  final TextEditingController _scadenzaController = TextEditingController();
  final TextEditingController _descrizioneController = TextEditingController();
  final TextEditingController _idAssegnazioneController =
      TextEditingController();
  final DBMetodi _db = DBMetodi();

  @override
  void dispose() {
    _scadenzaController.dispose();
    _descrizioneController.dispose();
    _idAssegnazioneController.dispose();
    super.dispose();
  }

  Future<void> _showSuccessDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Caricato!",
            style: GoogleFonts.roboto(color: Colors.green, fontSize: 18.sp),
          ),
          content: Text(
            "Compito inserito con successo",
            style: GoogleFonts.roboto(color: Colors.black, fontSize: 16.sp),
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

  void _inserisciCompito() {
    final scadenza = _scadenzaController.text;
    final descrizione = _descrizioneController.text;
    final idAssegnazione = int.tryParse(_idAssegnazioneController.text) ?? 0;

    if (scadenza.isNotEmpty && descrizione.isNotEmpty && idAssegnazione != 0) {
      _db.addCompito(scadenza, descrizione, idAssegnazione);
      _scadenzaController.clear();
      _descrizioneController.clear();
      _idAssegnazioneController.clear();
      _showSuccessDialog();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Errore!",
              style: GoogleFonts.roboto(color: Colors.red, fontSize: 18.sp),
            ),
            content: Text(
              "Per favore, compila tutti i campi!",
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 16.sp),
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

  bool _isCampoVuoto(String value) {
    return value.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserisci Compito"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                      _scadenzaController.text =
                          selectedDate.toString().substring(0, 10);
                    });
                  }
                });
              },
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Scadenza",
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _scadenzaController.text.isNotEmpty
                      ? "Scadenza: ${_scadenzaController.text}"
                      : "Seleziona una data di scadenza",
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _descrizioneController,
              decoration: const InputDecoration(
                labelText: "Descrizione",
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.roboto(color: Colors.black),
              maxLines: 5,
              validator: (value) {
                if (_isCampoVuoto(value!)) {
                  return "Il campo descrizione è obbligatorio.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _idAssegnazioneController,
              decoration: const InputDecoration(
                labelText: "ID Assegnazione",
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.roboto(color: Colors.black),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (_isCampoVuoto(value!)) {
                  return "Il campo ID assegnazione è obbligatorio.";
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _inserisciCompito,
              child: const Text("Inserisci"),
            ),
          ],
        ),
      ),
    );
  }
}
