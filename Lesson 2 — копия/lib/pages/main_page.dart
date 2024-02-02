import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/pages/fight_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/resourses/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/fight_result_widget.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fight_result.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _MainPageContent();
  }
}

class _MainPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(children: [
          const SizedBox(
            height: 24,
          ),
          Center(
            child: Text(
              "the\nFight\nClub\n".toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 30, color: FightClubColors.darkGreyText),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          FutureBuilder<String?>(
              future: SharedPreferences.getInstance().then(
                      (sharedPreferences) =>
                      sharedPreferences.getString("last_fight_result")),
              builder: (context, snaphot) {
                if (!snaphot.hasData || snaphot.data == null) {
                  return const SizedBox();
                }
                final FightResult fightResult = FightResult.getByName(
                    snaphot.data!);

                return FightResultWidget(fightResult: fightResult);
              }),
          Expanded(
            child: SizedBox(),
          ),
          SecondaryActionButton(
            text: "Statistics",
            onTap: () {
              Navigator.of((context)).push(
                  MaterialPageRoute(builder: (context) => StatisticsPage()));
            },
          ),
          SizedBox(
            height: 8,
          ),
          ActionButton(
              onTap: () {
                Navigator.of((context))
                    .push(MaterialPageRoute(builder: (context) => FightPage()));
              },
              color: FightClubColors.darkGreyText,
              text: "Start".toUpperCase()),
          const SizedBox(
            height: 16,
          ),
        ]),
      ),
    );
  }
}
