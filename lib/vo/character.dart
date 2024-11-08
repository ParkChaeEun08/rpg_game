import 'dart:math';
import 'package:rpg_game/vo/monster.dart';

class Character {
  late String name;
  late int health;
  late int attack;
  late int defense;
  late int kill;
  late bool defendMode = false;
  bool itemUsed = false;
  late int maxHealth;
  late int bonusHealth;

// 생성자
  Character(this.name, this.health, this.attack, this.defense) {
    maxHealth = health;
    bonusHealth = health;
  }

// 캐릭터 방어
  void defend() {
    defendMode = true;
    print('$name이(가) 방어합니다.');
  }

// 캐릭터 방어 리셋
  void resetDefenseMode() {
    defendMode = false;
  }

// 몬스터 공격
  void attackMonster(Monster monster) {
    int damage = (attack - monster.defense).clamp(0, double.infinity).toInt();
    monster.health -= damage;
    print('$name이(가) ${monster.name}에게 $damage의 피해를 입혔습니다.');
  }

// 캐릭터 상태 출력
  void showStatus() {
    print(
        '캐릭터 상태 - 이름: $name, 체력: $health, 공격력: $attack, 방어력: $defense, 처치한 몬스터 수: $kill');
  }

//체력 증가 기능
  void applyhealthBonus() {
    if (Random().nextDouble() < 0.3) {
      health += 10;
      print('보너스 체력을 얻었습니다. 현재 체력: $health');
    }
  }

  //아이템 사용
  void useItem() {
    if (!itemUsed) {
      attack *= 2;
      itemUsed = true;
      print('$name이(가) 아이템을 사용하여 공격력이 두 배로 증가 하였습니다.');
    } else {
      print('이미 아이템을 사용하였습니다.');
    }
  }
}
