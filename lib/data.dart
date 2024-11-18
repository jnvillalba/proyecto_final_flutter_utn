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

Player romero() {
  return Player.gk(
    name: 'Sergio Romero',
    imageUrl:
        'https://img.a.transfermarkt.technology/portrait/header/30690-1596803710.jpg?lm=1',
    number: 1,
  );
}

Team boca() {
  return Team(
    name: 'Boca',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/189.png?lm=1511621129',
    players: [],
    playerIds: ['s0uXcV2OzvRbPUC1cNf4'],
  );
}

Team getBoca() {
  return Team(
    name: 'Boca',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/189.png?lm=1511621129',
    players: [
      romero(),
      Player(
        name: 'Marcos Rojo',
        position: PlayerPosition.forward,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/93176-1633537711.JPG?lm=1',
        number: 6,
      ),
      Player(
        name: 'Edinson Cavani',
        position: PlayerPosition.forward,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/48280-1619791055.jpg?lm=1',
        number: 10,
      ),
    ],
  );
}

Team getRacing() {
  return Team(
    name: 'Racing',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1444.png?lm=1412762689',
    players: [],
  );
}

Team getRiver() {
  return Team(
    name: 'River',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/209.png?lm=1645539487',
    players: [
      Player(
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
        number: 1,
      ),
    ],
  );
}

Team getCAI() {
  return Team(
    name: 'Independiente',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1234.png?lm=1489920510',
    players: [
      Player(
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
        number: 1,
      ),
    ],
  );
}

Team getGC() {
  return Team(
    name: 'Godoy Cruz',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/12574.png?lm=1412763466',
    players: [
      Player(
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
        number: 1,
      ),
    ],
  );
}

Team getEstudiantes() {
  return Team(
    name: 'Estudiantes',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/288.png?lm=1615331978',
    players: [
      Player(
        name: 'Player 3',
        position: PlayerPosition.defender,
        imageUrl: 'https://example.com/player3.png',
        number: 1,
      ),
    ],
  );
}
