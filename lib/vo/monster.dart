import 'dart:math';
import 'package:rpg_game/vo/character.dart';

class Monster {
  late String name;
  late int health;
  late int maxAttack;
  late int defense = 0;
  int turnCounter = 0;

// 생성자
  Monster(this.name, this.health, this.maxAttack);

// 캐릭터 공격
  void attackCharacter(Character character) {
    int randomAttack = Random().nextInt(maxAttack);
    int damage =
        randomAttack.clamp(character.defense, double.infinity).toInt() -
            character.defense;
    if (character.defendMode) {
      character.health += randomAttack;
    } else {
      character.health -= damage;
    }
    if (turnCounter % 3 == 0) {
      defense += 2;
      print('$name의 방어력이 증가하였습니다. 현재 방어력: $defense');
      turnCounter = 0;
    }
  }

// 몬스터 상태 출력
  void showStatus() {
    print('몬스터 상태 - 이름: $name, 체력: $health, 최대 공격력: $maxAttack, 방어력: $defense');
  }
}
