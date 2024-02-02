import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resourses/fight_club_colors.dart';
import 'package:flutter_fight_club/widgets/action_button.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
          child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                "Statistics",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: FightClubColors.darkGreyText),
              )),
          Expanded(
            child: SizedBox(),
          ),
          ResultStatistic(),
          Expanded(
            child: SizedBox(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SecondaryActionButton(
                onTap: () => {Navigator.of(context).pop()}, text: "Back"),
          )
        ],
      )),
    );
  }

  Widget ResultStatistic() {
    return Center(
      child: SizedBox(
        height: 132,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                FutureBuilder<String?>(
                    future: SharedPreferences.getInstance().then(
                        (sharedPreferences) =>
                            sharedPreferences.getString("stats_won")),
                    builder: (context, snaphot) {
                      if (!snaphot.hasData || snaphot.data == null) {
                        return CenterStatisticText("Won: 0");
                      }
                      return CenterStatisticText("Won: ${snaphot.data!}");
                    }),
              ],
            ),
            Row(
              children: [
                FutureBuilder<String?>(
                    future: SharedPreferences.getInstance().then(
                        (sharedPreferences) =>
                            sharedPreferences.getString("stats_lost")),
                    builder: (context, snaphot) {
                      print(snaphot.data);
                      if (!snaphot.hasData || snaphot.data == null) {
                        return CenterStatisticText("Lost: 0");
                      }
                      return CenterStatisticText("Lost: ${snaphot.data!}");
                    }),
              ],
            ),
            Row(
              children: [
                FutureBuilder<String?>(
                    future: SharedPreferences.getInstance().then(
                        (sharedPreferences) =>
                            sharedPreferences.getString("stats_draw")),
                    builder: (context, snaphot) {
                      if (!snaphot.hasData || snaphot.data == null) {
                        return CenterStatisticText("Draw: 0");
                      }
                      return CenterStatisticText("Draw: ${snaphot.data!}");
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget CenterStatisticText(final String text){
    return Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),);
  }
  String _statusPlusKolvo(){

    return "";
  }
}
