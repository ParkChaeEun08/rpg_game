import 'dart:io';
import 'dart:math';
import 'package:rpg_game/utill/csv_reader.dart';
import 'package:rpg_game/vo/character.dart';
import 'package:rpg_game/vo/monster.dart';

void main() {
  CsvReader reader = CsvReader();
  Character character = reader.loadCharacterStats();
  List<Monster> monsters = reader.loadMonsterStats();

  RpgGame game = RpgGame(character, monsters);
  game.startGame();
}

class RpgGame {
  Character character;
  List<Monster> monsters;
  int defeatedMonsters = 0;

  RpgGame(this.character, this.monsters);

  void startGame() {
    print('게임이 시작되었습니다!');
    while (character.health > 0 && defeatedMonsters < monsters.length) {
      Monster monster = getRandomMonster();
      while (monster.health > 0 && character.health > 0) {
        character.showStatus();
        monster.showStatus();
        print('행동을 선택하세요: 1) 공격 2) 방어');
        String? action = stdin.readLineSync();
        if (action == '1') {
          character.attackMonster(monster);
        } else if (action == '2') {
          character.defend();
        }
        if (monster.health > 0) {
          monster.attackCharacter(character);
        }
        character.resetDefenseMode();
      }
      if (character.health <= 0) {
        print('게임 오버! ${monster.name} 에게 패배했습니다.');
        break;
      } else {
        print('${monster.name} 을(를) 물리쳤습니다!');
        defeatedMonsters++;
        monsters.remove(monster);
        if (defeatedMonsters < monsters.length) {
          print('다음 몬스터와 대결하시겠습니까? (y/n)');
          String? nextBattle = stdin.readLineSync();
          if (nextBattle?.toLowerCase() != 'y') {
            break;
          }
        }
      }
    }
    if (defeatedMonsters >= monsters.length) {
      print('축하합니다! 모든 몬스터를 물리쳤습니다.');
    }
    saveResult();
  }

  Monster getRandomMonster() {
    int index = Random().nextInt(monsters.length);
    return monsters[index];
  }

  void saveResult() {
    print('결과를 저장하시겠습니까? (y/n)');
    String? save = stdin.readLineSync();
    if (save?.toLowerCase() == 'y') {
      File file = File('result.txt');
      file.writeAsStringSync(
          '캐릭터: ${character.name}, 체력: ${character.health}, 결과: ${character.health > 0 ? '승리' : '패배'}');
      print('결과가 result.txt에 저장되었습니다.');
    }
  }
}
