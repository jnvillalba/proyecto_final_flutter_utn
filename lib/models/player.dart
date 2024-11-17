import 'package:cloud_firestore/cloud_firestore.dart';

class Player {
  final String? id;
  final String name;
  final String position;
  final String imageUrl;
  final int number;
  bool isCollected;
  final DocumentReference teamRef;

  Player({
    required this.id,
    required this.name,
    required this.position,
    required this.imageUrl,
    required this.number,
    required this.teamRef,
    this.isCollected = false,
  });

  // Constructor de fábrica para crear un Player a partir de un JSON
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      name: json['name'],
      position: json['position'] ?? 'Unknown',
      imageUrl: json['imageUrl'],
      number: json['number'],
      teamRef: FirebaseFirestore.instance.doc(json['teamRef']),
      isCollected: json['isCollected'] ?? false,
    );
  }

  // Método para convertir un Player a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'imageUrl': imageUrl,
      'number': number,
      'teamRef': teamRef.path, // Guardamos la ruta del documento
      'isCollected': isCollected,
    };
  }

  // Método para obtener un Player con la posición de "GK"
  Player.gk({
    required this.number,
    this.id,
    required this.name,
    required this.imageUrl,
    this.isCollected = false,
    this.position = "GK",
    required this.teamRef,
  });
}
