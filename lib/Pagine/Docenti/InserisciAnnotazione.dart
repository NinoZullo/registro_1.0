import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:registro/mysql/DBMetodi.dart";

//Pagina terminata ed Ottimizzata ✅

class InserisciAnnotazione extends StatefulWidget {
  final int idStudente;

  const InserisciAnnotazione({Key? key, required this.idStudente})
      : super(key: key);

  @override
  State<InserisciAnnotazione> createState() => _InserisciAnnotazioneState();
}

class _InserisciAnnotazioneState extends State<InserisciAnnotazione> {
  DBMetodi db = DBMetodi();

  final TextEditingController _descrizioneController = TextEditingController();
  final TextEditingController _dataInserimentoController =
      TextEditingController();
  final TextEditingController _idTipoController = TextEditingController();
  final TextEditingController _idAssegnazioneController =
      TextEditingController();

  final List<String> tipiAnnotazione = [
    "+",
    "-",
    "*",
    "GR",
    "IN",
    "NTS",
    "SU",
    "DI",
    "BU",
    "DST",
    "OT"
  ];
  String selectedTipoAnnotazione = "+";

  @override
  void dispose() {
    _descrizioneController.dispose();
    _dataInserimentoController.dispose();
    _idTipoController.dispose();
    _idAssegnazioneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inserisci Annotazione"),
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
              style: GoogleFonts.roboto(color: Colors.black),
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
                      _dataInserimentoController.text =
                          selectedDate.toString().substring(0, 10);
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
                  style: GoogleFonts.roboto(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: selectedTipoAnnotazione,
              style: GoogleFonts.roboto(color: Colors.black),
              onChanged: (newValue) {
                setState(() {
                  selectedTipoAnnotazione = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: "Tipo Annotazione",
                border: OutlineInputBorder(),
              ),
              items:
                  tipiAnnotazione.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: GoogleFonts.roboto(color: Colors.black)),
                );
              }).toList(),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _idAssegnazioneController,
              decoration: const InputDecoration(
                labelText: "ID Assegnazione",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: GoogleFonts.roboto(color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final descrizione = _descrizioneController.text;
                final dataInserimento = _dataInserimentoController.text;
                final idTipo = tipiAnnotazione.indexOf(selectedTipoAnnotazione);
                final idAssegnazione =
                    int.tryParse(_idAssegnazioneController.text) ?? 0;

                db.addAnnotazione(
                  descrizione,
                  dataInserimento,
                  idTipo,
                  widget.idStudente,
                  idAssegnazione,
                );

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Annotazione Aggiunta"),
                      content: Text(
                        "Annotazione aggiunta con successo!",
                        style: GoogleFonts.roboto(color: Colors.black),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );

                _descrizioneController.clear();
                _dataInserimentoController.clear();
                _idAssegnazioneController.clear();
              },
              child: const Text("Inserisci"),
            ),
          ],
        ),
      ),
    );
  }
}
