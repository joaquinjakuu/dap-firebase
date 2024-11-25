class Song {
  final String id;
  final String cancion;
  final String banda;
  final String disco;
  final int year;
  final String imagen;

  Song({
    required this.id,
    required this.cancion,
    required this.banda,
    required this.disco,
    required this.year,
    required this.imagen,
  });

  factory Song.fromFirestore(Map<String, dynamic> json, String id) {
    return Song(
      id: id,
      cancion: json['cancion'] ?? '',
      banda: json['banda'] ?? '',
      disco: json['disco'] ?? '',
      year: json['year'] ?? 0,
      imagen: json['imagen'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'cancion': cancion,
      'banda': banda,
      'disco': disco,
      'year': year,
      'imagen': imagen,
    };
  }

  Song copyWith({
    String? id,
    String? cancion,
    String? banda,
    String? disco,
    int? year,
    String? imagen,
  }) {
    return Song(
      id: id ?? this.id,
      cancion: cancion ?? this.cancion,
      banda: banda ?? this.banda,
      disco: disco ?? this.disco,
      year: year ?? this.year,
      imagen: imagen ?? this.imagen,
    );
  }
}
