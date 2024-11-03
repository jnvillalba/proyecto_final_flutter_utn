import 'package:proyecto_final_facil/models/enums/player_position.dart';
import 'package:proyecto_final_facil/models/player.dart';
import 'package:proyecto_final_facil/models/team.dart';

List<Team> getTeams() {
  return [
    getBoca(),
    getRiver(),
    getRacing(),
    getCAI(),
    getEstudiantes(),
    getGC()
  ];
}

Team getBoca() {
  return Team(
    id: '1',
    name: 'Boca',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/189.png?lm=1511621129',
    players: [
      Player.gk(
        id: '1',
        name: 'Sergio Romero',
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/30690-1596803710.jpg?lm=1',
      ),
      Player(
        id: '2',
        name: 'Marcos Rojo',
        position: PlayerPosition.forward,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/93176-1633537711.JPG?lm=1',
      ),
      Player(
        id: '3',
        name: 'Edinson Cavani',
        position: PlayerPosition.forward,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/48280-1619791055.jpg?lm=1',
      ),
    ],
  );
}

Team getRacing() {
  return Team(
    id: '2',
    name: 'Racing',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1444.png?lm=1412762689',
    players: [],
  );
}

Team getRiver() {
  return Team(
    id: '3',
    name: 'River',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/209.png?lm=1645539487',
    players: [
      Player(
        id: '3',
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
      ),
    ],
  );
}

Team getCAI() {
  return Team(
    id: '4',
    name: 'Independiente',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1234.png?lm=1489920510',
    players: [
      Player(
        id: '3',
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
      ),
    ],
  );
}

Team getGC() {
  return Team(
    id: '5',
    name: 'Godoy Cruz',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/12574.png?lm=1412763466',
    players: [
      Player(
        id: '3',
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
      ),
    ],
  );
}

Team getEstudiantes() {
  return Team(
    id: '7',
    name: 'Estudiantes',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/288.png?lm=1615331978',
    players: [
      Player(
        id: '3',
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
      ),
    ],
  );
}
