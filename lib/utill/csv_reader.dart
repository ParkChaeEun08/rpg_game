import 'dart:ffi';
import 'dart:io';

import 'package:rpg_game/vo/character.dart';
import 'package:rpg_game/vo/monster.dart';

class CsvReader {
  String getCharacterName() {
    String result = '';
    String? input;
    RegExp regExp = RegExp(r'^[a-zA-Z가-힣]+$');
    for (int i = 0; i < 3; i++) {
      print('이름을 입력해주세요.($i/3)');
      input = stdin.readLineSync();
      if (input == null) {
        continue;
      } else {
        if (regExp.hasMatch(input)) {
          result = input;
          break;
        } else {
          continue;
        }
      }
    }
    return result;
  }

  Character loadCharacterStats() {
    Character character;
    try {
      final file = File('characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');

      int health = int.parse(stats[0]);
      int attack = int.parse(stats[1]);
      int defense = int.parse(stats[2]);

      String name = getCharacterName();
      if (name.isEmpty) {
        print('이름규칙을 3회 틀려서 프로그램을 종료합니다.');
        exit(0);
      }
      character = Character(name, health, attack, defense);
      print('캐릭터 데이터를 불러오는 데 성공했습니다.');
      character.showStatus();
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
    return character;
  }

// 위 함수와 마찬가지로 몬스터들의 스탯을 불러오는 함수도 작성해보세요.
  List<Monster> loadMonsterStats() {
    List<Monster> monster;
    try {
      final file = File('monster.txt');
      final contents = file.readAsLinesSync();
      
      for (String line in contents) {
        
      }
    }
  }
}
