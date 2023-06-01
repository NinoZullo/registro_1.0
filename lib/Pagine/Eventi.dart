class Eventi {
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  String className;

  Eventi({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.className,
    required String nomeEvento,
  });

  factory Eventi.fromJson(Map<String, dynamic> json) {
    return Eventi(
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      className: json['className'],
      nomeEvento: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'className': className,
    };
  }
}
