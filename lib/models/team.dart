import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  final String? id;
  final String name;
  final String badge;
  final List<DocumentReference> playerRefs;
  final int size;

  Team({
    this.id,
    required this.name,
    required this.badge,
    required this.playerRefs,
    this.size = 30,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      badge: json['badge'],
      playerRefs: _fromFirestoreList(json['playerRefs']),
      size: json['size'] ?? 30,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'badge': badge,
      'playerRefs': _toFirestoreList(playerRefs),
      'size': size,
    };
  }

  Team copyWithId(String id) {
    return Team(
      id: id,
      name: name,
      badge: badge,
      playerRefs: playerRefs,
      size: size,
    );
  }

  static List<String> _toFirestoreList(List<DocumentReference> refs) {
    return refs.map((ref) => ref.path).toList();
  }

  static List<DocumentReference> _fromFirestoreList(dynamic json) {
    if (json is List) {
      return json.map((item) => FirebaseFirestore.instance.doc(item)).toList();
    }
    return [];
  }
}
