// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Kuliner {
  final String nama_tempat;
  final String kuliner;
  final String alamat;
  final String foto;
  Kuliner({
    required this.nama_tempat,
    required this.kuliner,
    required this.alamat,
    required this.foto,
  });

  

  Kuliner copyWith({
    String? nama_tempat,
    String? kuliner,
    String? alamat,
    String? foto,
  }) {
    return Kuliner(
      nama_tempat: nama_tempat ?? this.nama_tempat,
      kuliner: kuliner ?? this.kuliner,
      alamat: alamat ?? this.alamat,
      foto: foto ?? this.foto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nama_tempat': nama_tempat,
      'kuliner': kuliner,
      'alamat': alamat,
      'foto': foto,
    };
  }

  factory Kuliner.fromMap(Map<String, dynamic> map) {
    return Kuliner(
      nama_tempat: map['nama_tempat'] as String,
      kuliner: map['kuliner'] as String,
      alamat: map['alamat'] as String,
      foto: map['foto'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Kuliner.fromJson(String source) => Kuliner.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Kuliner(nama_tempat: $nama_tempat, kuliner: $kuliner, alamat: $alamat, foto: $foto)';
  }

  @override
  bool operator ==(covariant Kuliner other) {
    if (identical(this, other)) return true;
  
    return 
      other.nama_tempat == nama_tempat &&
      other.kuliner == kuliner &&
      other.alamat == alamat &&
      other.foto == foto;
  }

  @override
  int get hashCode {
    return nama_tempat.hashCode ^
      kuliner.hashCode ^
      alamat.hashCode ^
      foto.hashCode;
  }
}
