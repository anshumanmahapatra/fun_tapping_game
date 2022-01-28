import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';

import '../controller/controller.dart';

import '../widgets/play_stats.dart';
import '../widgets/player_card.dart';

import '../screens/play_game.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerCard playerCard = Get.put(PlayerCard());
    PlayStats playStats = Get.put(PlayStats());
    ColorConstant colorConstant = Get.put(ColorConstant());
    Controller controller = Get.put(Controller());

    var size = Get.mediaQuery.size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: colorConstant.kPrimary,
          title: Text('Fun Tapping Game'),
        ),
        body: Stack(children: [
          playStats.getPlayStats(),
          DraggableScrollableSheet(
              initialChildSize: 1,
              minChildSize: 0.4,
              snap: true,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: colorConstant.kQuarternary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            controller: scrollController,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: size.width * 0.05),
                                      child: Text(
                                        'Player ${index + 1}',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 24),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  playerCard.getPlayerCard(index + 1),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.playImpButtonSound();
                            Get.to(
                              () => PlayGame(),
                              transition: Transition.rightToLeft,
                            );
                            controller.onHomeScreen(false);
                            controller.playGameSound(
                                false, controller.isOnHomeScreen.value);
                          },
                          child: Text(
                            "Play",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: colorConstant.kSecondary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ]));
  }
}
