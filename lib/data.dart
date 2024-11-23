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

Player brey() {
  return Player.gk(
    name: 'Leandro Brey',
    imageUrl:
        'https://img.a.transfermarkt.technology/portrait/header/982633-1710343824.jpg?lm=1',
    number: 12,
  );
}

Player javig() {
  return Player.gk(
    name: 'Javier García',
    imageUrl:
        'https://img.a.transfermarkt.technology/portrait/header/7966-1651064007.JPG?lm=1',
    number: 13,
  );
}

Team boca() {
  return Team(
    name: 'Boca',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/189.png?lm=1511621129',
    players: [],
    playerIds: [
      '20n6bWC3pgjHuYXKss7H',
      '6HLrnMX5wZAbJockgGfK',
      '9RtPqjJztiVdFvYlWAmV',
      'E99cS4MF7gbn0accs6uU',
      'MHs4CkchqgGk3LQOosb2',
      'OKXlpaGhjCha1EXWuXNg',
      'OlXV2raTDx8gZZ4i7IxT',
      'QEORrIXpvklv87iRJqAy',
      'QnKsJjEokjRM2Fqq8tmm',
      'REWEUOJ8MWbCnahTEJoc',
      'TBWwFBTqfECy86GSQw09',
      'W6HzwVNaXOX64Zsh5St7',
      'X35G5zLKjlz2HFRHmOn8',
      'gN3URKntfq7chzlCeEW7',
      'grM9u0LD0zKCgk7cxxRF',
      'lzhBHTnDdEl8R1gJ7sfg',
      'msW1LgkYkajBRlY5tR9w',
      'p6MWagfCQtheH84mwWa3',
      'pDbjhLE4SSrALpRFZfpK',
      'rMD9HKM7s6jrGQI60tA8',
      's0uXcV2OzvRbPUC1cNf4',
      'szecAB5fBHTyu7Ix1mWn',
      'wLXswLyxdAvoY6zj2KdH',
      'zlSZprynSGdnq8mO1bD4'
    ],
  );
}

Team getBoca() {
  return Team(
    name: 'Boca',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/189.png?lm=1511621129',
    players: playersBoca(),
  );
}

List<Player> playersBoca() {
  return [
    javig(),
    brey(),
    Player(
      name: 'Marcos Rojo',
      position: PlayerPosition.defender,
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
    Player(
      name: 'Aarón Anselmino',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/1145504-1694003362.JPG?lm=1',
      number: 38,
    ),
    Player(
      name: 'Nicolás Figal',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/334055-1618683189.jpg?lm=1',
      number: 4,
    ),
    Player(
      name: 'Cristian Lema',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/147128-1537351960.jpg?lm=1',
      number: 2,
    ),
    Player(
      name: 'Gary Medel',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/60889-1630574292.jpg?lm=1',
      number: 5,
    ),
    Player(
      name: 'Lautaro Blanco',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/831161-1635706437.JPG?lm=1',
      number: 23,
    ),
    Player(
      name: 'Marcelo Saracchi',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/373916-1608892184.jpeg?lm=1',
      number: 3,
    ),
    Player(
      name: 'Lucas Blondel',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/503348-1639163671.JPG?lm=1',
      number: 24,
    ),
    Player(
      name: 'Luis Advíncula',
      position: PlayerPosition.defender,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/103890-1689009563.jpg?lm=1',
      number: 17,
    ),
    Player(
      name: 'Ignacio Miramón',
      position: PlayerPosition.midfielder,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/836518-1699914175.jpg?lm=1',
      number: 21,
    ),
    Player(
      name: 'Jabes Saralegui',
      position: PlayerPosition.midfielder,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/1174943-1705514491.jpg?lm=1',
      number: 47,
    ),
    Player(
      name: 'Kevin Zenón',
      position: PlayerPosition.midfielder,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/829966-1708005655.JPG?lm=1',
      number: 22,
    ),
    Player(
      name: 'Brian Aguirre',
      position: PlayerPosition.forward,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/668549-1674736123.JPG?lm=1',
      number: 33,
    ),
    Player(
      name: 'Exequiel Zeballos',
      position: PlayerPosition.forward,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/661132-1573832468.jpg?lm=1',
      number: 7,
    ),
    Player(
      name: 'Miguel Merentiel',
      position: PlayerPosition.forward,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/481367-1621169984.jpg?lm=1',
      number: 16,
    ),
    Player(
      name: 'Milton Giménez',
      position: PlayerPosition.forward,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/730779-1671215285.jpg?lm=1',
      number: 9,
    ),
    Player(
        name: 'Tomás Belmonte',
        position: PlayerPosition.midfielder,
        imageUrl:
            'https://img.a.transfermarkt.technology/portrait/header/483446-1580983861.jpg?lm=1',
        number: 30),
    Player(
      name: 'Cristian Medina',
      position: PlayerPosition.midfielder,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/661133-1574082594.jpg?lm=1',
      number: 36,
    ),
    Player(
      name: 'Agustín Martegani',
      position: PlayerPosition.midfielder,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/732507-1696837411.jpg?lm=1',
      number: 19,
    ),
    Player(
      name: 'Lucas Janson',
      position: PlayerPosition.forward,
      imageUrl:
          'https://img.a.transfermarkt.technology/portrait/header/238448-1636330859.JPG?lm=1',
      number: 11,
    ),
  ];
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
    players: [],
  );
}

Team getCAI() {
  return Team(
    name: 'Independiente',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1234.png?lm=1489920510',
    players: [],
  );
}

Team getGC() {
  return Team(
    name: 'Godoy Cruz',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/12574.png?lm=1412763466',
    players: [],
  );
}

Team getEstudiantes() {
  return Team(
    name: 'Estudiantes',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/288.png?lm=1615331978',
    players: [],
  );
}

Team velez() {
  return Team(
    name: 'Vélez Sarsfield',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1029.png?lm=1634518202',
    players: [],
  );
}

Team sLorenzo() {
  return Team(
    name: 'San Lorenzo',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/1775.png?lm=1723433116',
    players: [],
  );
}

Team talleres() {
  return Team(
    name: 'Talleres',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/3938.png?lm=1636589988',
    players: [],
  );
}

Team rc() {
  return Team(
    name: 'Rosario Central',
    badge: 'Rosario Central',
    players: [],
  );
}

Team riestra() {
  return Team(
    name: 'Riestra',
    badge:
        'https://tmssl.akamaized.net//images/wappen/head/19775.png?lm=1487795829',
    players: [],
    playerIds: ["N8EULGauHrsice5Gw0WO"],
  );
}

Player spreen() {
  return Player(
    name: 'Iván "Spreen" Buhajeruk',
    position: PlayerPosition.forward,
    imageUrl:
        'https://img.a.transfermarkt.technology/portrait/header/1341853-1731349912.JPG?lm=1',
    number: 47,
  );
}

// Team getGC() {
//   return Team(
//     name: 'Godoy Cruz',
//     badge:
//     '',
//     players: [],
//   );
// }
//
