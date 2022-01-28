import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';

import '../models/play_model.dart';

import '../controller/controller.dart';

import '../widgets/play_stats_tab.dart';


class PlayStats {
  Container getPlayStats() {
    PlayStatsTab playStatsTab = Get.put(PlayStatsTab());
    ColorConstant colorConstant = Get.put(ColorConstant());
    Controller controller = Get.put(Controller());
    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;
    return Container(
      height: height * 0.6,
      width: width,
      color: colorConstant.kPrimary,
      child: Obx(() {
        return controller.isOnHomeScreen.value == true
            ? FutureBuilder<List<PlayModel>>(
                future: controller.playModel,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      debugPrint(snapshot.error.toString());
                      return Center(child: Text("Sorry Failed to Load Stats"));
                    } else {
                      if (snapshot.data!.length == 0) {
                        controller.firstEntry();
                      } else {
                        controller.updateStats(snapshot.data!);
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              playStatsTab.getPlayStatsTab1(
                                  'Total Games',
                                  controller.totalGames,
                                  colorConstant.kQuarternary,
                                  Colors.black),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              playStatsTab.getPlayStatsTab2(
                                'Player 1 Wins',
                                controller.player1Wins,
                                controller.totalGames,
                                colorConstant.kSecondary,
                                Colors.black,
                              ),
                              playStatsTab.getPlayStatsTab2(
                                'Player 2 Wins',
                                controller.player2Wins,
                                controller.totalGames,
                                colorConstant.kTertiary,
                                Colors.white,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              playStatsTab.getPlayStatsTab1(
                                'Player 1 Highest Winning Streak',
                                controller.player1Streak,
                                colorConstant.kTertiary,
                                Colors.white,
                              ),
                              playStatsTab.getPlayStatsTab1(
                                'Player 2 Highest Winning Streak',
                                controller.player2Streak,
                                colorConstant.kSecondary,
                                Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              playStatsTab.getPlayStatsTab1(
                                'Player 1 Current Streak',
                                controller.player1CurrentStreak,
                                colorConstant.kSecondary,
                                Colors.black,
                              ),
                              playStatsTab.getPlayStatsTab1(
                                'Player 2 Current Streak',
                                controller.player2CurrentStreak,
                                colorConstant.kTertiary,
                                Colors.white,
                              ),
                            ],
                          )
                        ],
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    debugPrint('Waiting for data');
                    return Center(
                        child: CircularProgressIndicator(color: Colors.white));
                  } else {
                    debugPrint('Got nothing to show');
                    return Container();
                  }
                })
            : Container();
      }),
    );
  }
}
