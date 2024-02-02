import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resourses/fight_club_colors.dart';
import '../resourses/fight_club_icons.dart';
import '../resourses/fight_club_images.dart';
import '../widgets/action_button.dart';

class FightPage extends StatefulWidget {
  const FightPage({super.key});

  @override
  State<FightPage> createState() => _FightPageState();
}

class _FightPageState extends State<FightPage> {
  static const maxLives = 5;
  BodyPart? defendingBodyPart;
  BodyPart whatEnemyAttacks = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();
  BodyPart? attacingBodyPart;
  int yourLives = maxLives;
  int enemysLives = maxLives;
  String textCenter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivescount: maxLives,
              youLivesCount: yourLives,
              enemyLivesCount: enemysLives,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ColoredBox(
                        color: Color.fromRGBO(197, 209, 234, 1),
                        child: SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              textCenter,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: FightClubColors.darkGreyText),
                            )))))),
            SizedBox(
              height: 30,
            ),
            ControlsWidget(
                defendingBodyPart: defendingBodyPart,
                selectDefendingBodyPart: _selectDefendingBodyPart,
                attacingBodyPart: attacingBodyPart,
                selectAttacingBodyPart: _selectAttacingBodyPart),
            SizedBox(
              height: 14,
            ),
            ActionButton(
                text: yourLives == 0 || enemysLives == 0 ? "Back" : "Go",
                onTap: _onGoButtonSelected,
                color: _getGoButtonColor()),
          ],
        ),
      ),
    );
  }

  Color _getGoButtonColor() {
    if (yourLives == 0 || enemysLives == 0) {
      return FightClubColors.blackBotton;
    } else if (attacingBodyPart != null && defendingBodyPart != null) {
      return FightClubColors.blackBotton;
    } else {
      return FightClubColors.greyButton;
    }
  }

  void _onGoButtonSelected() {
    if (yourLives == 0 || enemysLives == 0) {
      _saveStatistics(enemysLives, yourLives);
      Navigator.of(context).pop();
    } else if (attacingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        final bool enemyLoseLife = attacingBodyPart != whatEnemyDefends;
        final bool youLoseLife = whatEnemyAttacks != defendingBodyPart;
        if (enemyLoseLife) {
          enemysLives -= 1;
        }
        if (youLoseLife) {
          yourLives -= 1;
        }

        final FightResult? fightResult =
            FightResult.calculateResult(yourLives, enemysLives);
        if (fightResult != null) {
          SharedPreferences.getInstance().then((sharedPreferences) {
            sharedPreferences.setString(
                "last_fight_result", fightResult.result);
          });
        }
        textCenter = _calculateCentralText(enemyLoseLife, youLoseLife);

        whatEnemyAttacks = BodyPart.random();
        whatEnemyDefends = BodyPart.random();

        attacingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  String _calculateCentralText(
      final bool enemyLoseLife, final bool youLoseLife) {
//If lives == 0 String =
    String stringFirst;
    String stringSecond;

    if (yourLives == 0 && enemysLives == 0) {
      return "Draw";
    } else if (yourLives == 0) {
      return "You Lost";
    } else if (enemysLives == 0) {
      return "You Win";
    }

    stringFirst = enemyLoseLife
        ? "You hit enemy's ${attacingBodyPart!.name.toLowerCase()}."
        : "Your attack was blocked.";

    stringSecond = youLoseLife
        ? "Enemy hit your ${defendingBodyPart!.name.toLowerCase()}."
        : "Enemy's attack was blocked.";

    return stringFirst + "\n" + stringSecond;
  }

  void _selectDefendingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectAttacingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      attacingBodyPart = value;
    });
  }
}
void _saveStatistics(yourLives, enemysLives){
  print("Hyi");
  print(yourLives);
  print(enemysLives);
  if (yourLives == 0 && enemysLives == 0) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setInt("stats_draw", 1);
    });
  } else if (enemysLives == 0) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setInt("stats_won", 1);
    });
  } else if (yourLives == 0) {
    SharedPreferences.getInstance().then((sharedPreferences) {
      sharedPreferences.setInt("stats_lost", 1);
    });
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivescount;
  final int youLivesCount;
  final int enemyLivesCount;

  const FightersInfo({
    super.key,
    required this.maxLivescount,
    required this.youLivesCount,
    required this.enemyLivesCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                ])),
              ),
            ),
            Expanded(
              child: ColoredBox(color: Color.fromRGBO(197, 209, 234, 1)),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  LivesWidget(
                      overallLivesCount: maxLivescount,
                      currentLiveCount: youLivesCount),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "You",
                    style: TextStyle(color: FightClubColors.darkGreyText),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Image.asset(
                    height: 92,
                    width: 92,
                    FightClubImages.youAvatar,
                  ),
                  SizedBox(
                    height: 13,
                  ),
                ],
              ),
              SizedBox(
                width: 44,
                height: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: FightClubColors.blueBotton),
                  child: Center(
                    child: Text(
                      "Vs".toLowerCase(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text("Enemy",
                      style: TextStyle(color: FightClubColors.darkGreyText)),
                  SizedBox(
                    height: 12,
                  ),
                  Image.asset(
                    height: 92,
                    width: 92,
                    FightClubImages.enemyAvatar,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  LivesWidget(
                    overallLivesCount: maxLivescount,
                    currentLiveCount: enemyLivesCount,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectDefendingBodyPart;
  final BodyPart? attacingBodyPart;
  final ValueSetter<BodyPart> selectAttacingBodyPart;

  const ControlsWidget({
    super.key,
    required this.defendingBodyPart,
    required this.selectDefendingBodyPart,
    required this.attacingBodyPart,
    required this.selectAttacingBodyPart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            children: [
              Text("Defeand".toUpperCase(),
                  style: TextStyle(color: FightClubColors.darkGreyText)),
              SizedBox(
                height: 13,
              ),
              BodyPartButton(
                  bodyPart: BodyPart.head,
                  selected: defendingBodyPart == BodyPart.head,
                  BodyPartSetter: selectDefendingBodyPart),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                  bodyPart: BodyPart.torso,
                  selected: defendingBodyPart == BodyPart.torso,
                  BodyPartSetter: selectDefendingBodyPart),
              SizedBox(
                height: 14,
              ),
              BodyPartButton(
                  bodyPart: BodyPart.legs,
                  selected: defendingBodyPart == BodyPart.legs,
                  BodyPartSetter: selectDefendingBodyPart),
            ],
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(children: [
            Text("Atack".toUpperCase(),
                style: TextStyle(color: FightClubColors.darkGreyText)),
            SizedBox(
              height: 13,
            ),
            BodyPartButton(
              bodyPart: BodyPart.head,
              selected: attacingBodyPart == BodyPart.head,
              BodyPartSetter: selectAttacingBodyPart,
            ),
            SizedBox(
              height: 14,
            ),
            BodyPartButton(
              bodyPart: BodyPart.torso,
              selected: attacingBodyPart == BodyPart.torso,
              BodyPartSetter: selectAttacingBodyPart,
            ),
            SizedBox(
              height: 14,
            ),
            BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attacingBodyPart == BodyPart.legs,
                BodyPartSetter: selectAttacingBodyPart),
          ]),
        ),
        SizedBox(
          width: 16,
        ),
      ],
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLiveCount;

  const LivesWidget({
    Key? key,
    required this.overallLivesCount,
    required this.currentLiveCount,
  })  : assert(overallLivesCount >= 1),
        assert(currentLiveCount >= 0),
        assert(currentLiveCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLiveCount) {
          return Padding(
            padding: EdgeInsets.only(
                left: 0,
                top: 2,
                right: 0,
                bottom: index >= overallLivesCount ? 4 : 0),
            child: Image.asset(
              FightClubIcons.heartFull,
              width: 18,
              height: 18,
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(
                top: 0,
                bottom: index >= overallLivesCount ? 4 : 0,
                left: 0,
                right: 0),
            child:
                Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18),
          );
        }
      }),
    );
  }
}

class BodyPartButton extends StatelessWidget {
  final bool selected;
  final ValueSetter<BodyPart> BodyPartSetter;
  final BodyPart bodyPart;

  const BodyPartButton({
    required this.bodyPart,
    super.key,
    required this.selected,
    required this.BodyPartSetter,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => BodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: selected ? FightClubColors.blueBotton : Colors.transparent,
              border: !selected
                  ? Border.all(color: FightClubColors.darkGreyText, width: 2)
                  : null),
          child: Center(
              child: Text(
            bodyPart.name.toUpperCase(),
            style: TextStyle(
              color: selected
                  ? FightClubColors.whiteText
                  : FightClubColors.darkGreyText,
            ),
          )),
        ),
      ),
    );
  }
}
