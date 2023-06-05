class Eventi {
  String titolo;
  String descrizione;
  DateTime startDate;
  DateTime endDate;
  String nomeClasse;

  Eventi({
    required this.titolo,
    required this.descrizione,
    required this.startDate,
    required this.endDate,
    required this.nomeClasse,
    required String nomeEvento,
  });

  factory Eventi.fromJson(Map<String, dynamic> json) {
    return Eventi(
      titolo: json['title'],
      descrizione: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      nomeClasse: json['className'],
      nomeEvento: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': titolo,
      'description': descrizione,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'className': nomeClasse,
    };
  }
}
