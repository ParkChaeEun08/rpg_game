import 'package:rpg_game/vo/monster.dart';

class Character {
  late String name;
  late int health;
  late int attack;
  late int defense;
  late int kill;
  late bool defendMode = false;

  Character(this.name, this.health, this.attack, this.defense);

  void defend() {
    print('$name이(가) 방어합니다.');
    defendMode = true;
  }

  void attackMonster(Monster monster) {
    print('$name이(가) 공격합니다.');
  }
}
