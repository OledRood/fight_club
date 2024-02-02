import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:flutter_fight_club/resourses/fight_club_colors.dart';
import 'package:flutter_fight_club/resourses/fight_club_images.dart';

class FightResultWidget extends StatelessWidget {
  final FightResult fightResult;

  const FightResultWidget({
    super.key,
    required this.fightResult,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
//Первый слой
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ColoredBox(
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                  Colors.white,
                  Color.fromRGBO(197, 209, 234, 1)
                ]))),
              ),
              Expanded(
                  child: ColoredBox(
                color: Color.fromRGBO(197, 209, 234, 1),
              ))
            ],
          ),
//Второй слой
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "You",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Image.asset(
                    FightClubImages.youAvatar,
                    height: 92,
                    width: 92,
                  ),
                ],
              ),
              Expanded(child: SizedBox()),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  height: 36,
                  decoration: BoxDecoration(
                    color: _backColor(fightResult),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    _startText(fightResult).toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )),
              Expanded(child: SizedBox()),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Enemy",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  Image.asset(
                    FightClubImages.enemyAvatar,
                    height: 92,
                    width: 92,
                  ),
                ],
              ),
              SizedBox(
                width: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _backColor(final FightResult fightResult) {
    if (fightResult == FightResult.won) {
      return Color(0xFF038800);
    } else if (fightResult == FightResult.lost){
      return Color(0xFFEA2C2C);
    } else {return Color(0xFF1C79CE);
  }
}
String _startText(final FightResult fightResult) {
  if (fightResult == FightResult.won) {
    return "Won";
  } else if (fightResult == FightResult.lost){
    return "Lost";
  } else {return "Draw";
  }
}
}
