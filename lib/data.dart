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
    getGC(),
    getRiestra(),
  ];
}

Player romero() {
  return Player.gk(
    id: '1',
    number: 1,
    name: 'Sergio Romero',
    imageUrl:
        'https://img.a.transfermarkt.technology/portrait/header/30690-1596803710.jpg?lm=1',
  );
}

Team getBoca() {
  return Team(
    id: '1',
    name: 'Boca',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/189.png?lm=1511621129',
    players: [
      romero(),
      Player(
        id: '2',
        number: 6,
        name: 'Marcos Rojo',
        position: PlayerPosition.forward,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/93176-1633537711.JPG?lm=1',
      ),
      Player(
        id: '3',
        number: 10,
        name: 'Edinson Cavani',
        position: PlayerPosition.forward,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/48280-1619791055.jpg?lm=1',
      ),
    ],
  );
}

Team getRiestra() {
  return Team(
    id: '8',
    name: 'Riestra',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/189.png?lm=1511621129',
    players: [
      Player(
        id: '47',
        number: 47,
        name: 'Iván "Spreen" Buhajeruk',
        position: PlayerPosition.forward,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/1341853-1731349912.JPG?lm=1',
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
    players: [],
  );
}

Team getCAI() {
  return Team(
    id: '4',
    name: 'Independiente',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1234.png?lm=1489920510',
    players: [],
  );
}

Team getGC() {
  return Team(
    id: '5',
    name: 'Godoy Cruz',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/12574.png?lm=1412763466',
    players: [],
  );
}

Team getEstudiantes() {
  return Team(
    id: '7',
    name: 'Estudiantes',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/288.png?lm=1615331978',
    players: [],
  );
}
