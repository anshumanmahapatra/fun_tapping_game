import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_constant.dart';

import '../controller/controller.dart';

import '../models/color_model.dart';


class PlayerCard {
  Card getPlayerCard(int playerIndex) {
    ColorConstant colorConstant = Get.put(ColorConstant());
    Controller controller = Get.put(Controller());
    double height = Get.mediaQuery.size.height;
    double width = Get.mediaQuery.size.width;
    List<ColorModel> allColorConstants = colorConstant.getColorConstants;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Obx(() {
        return Container(
          width: width * 0.9,
          height: height * 0.275,
          decoration: BoxDecoration(
            color: playerIndex == 1
                ? controller.player1BackgroundColor.value
                : controller.player2BackgroundColor.value,
            borderRadius: BorderRadius.circular(20),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: TextFormField(
                cursorColor: playerIndex == 1
                    ? controller.player1TextColor.value
                    : controller.player2TextColor.value,
                cursorWidth: 2,
                style: TextStyle(
                  color: playerIndex == 1
                      ? controller.player1TextColor.value
                      : controller.player2TextColor.value,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  labelText: 'Player $playerIndex Name',
                  labelStyle: TextStyle(
                      color: playerIndex == 1
                          ? controller.player1TextColor.value
                          : controller.player2TextColor.value),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: playerIndex == 1
                            ? controller.player1TextColor.value
                            : controller.player2TextColor.value),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: playerIndex == 1
                            ? controller.player1TextColor.value
                            : controller.player2TextColor.value),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  icon: Icon(
                    Icons.person_outline,
                    color: playerIndex == 1
                        ? controller.player1TextColor.value
                        : controller.player2TextColor.value,
                  ),
                ),
                onChanged: (val) {
                  if (playerIndex == 1) {
                    controller.savePlayer1Name(val);
                  } else {
                    controller.savePlayer2Name(val);
                  }
                },
                onFieldSubmitted: (val) {
                  if (playerIndex == 1) {
                    controller.savePlayer1Name(val);
                  } else {
                    controller.savePlayer2Name(val);
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: allColorConstants.length,
                  itemBuilder: (context, index) {
                    final colorConstant = allColorConstants[index];
                    return Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.playGenButtonSound();
                            if (playerIndex == 1) {
                              controller.changePlayer1SelectedColor(index);
                            } else {
                              controller.changePlayer2SelectedColor(index);
                            }
                          },
                          child: Container(
                              height: 40,
                              width: 100,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: colorConstant.backgroundColor,
                                border: Border.all(
                                  color: colorConstant.borderColor,
                                  width: playerIndex == 1
                                      ? (controller.player1TextColor.value ==
                                              colorConstant.textColor
                                          ? 2
                                          : 1)
                                      : (controller.player2TextColor.value ==
                                              colorConstant.textColor
                                          ? 2
                                          : 1),
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                colorConstant.text,
                                style: TextStyle(
                                  color: colorConstant.textColor,
                                  fontWeight: playerIndex == 1
                                      ? (controller.player1TextColor.value ==
                                              colorConstant.textColor
                                          ? FontWeight.bold
                                          : FontWeight.normal)
                                      : (controller.player2TextColor.value ==
                                              colorConstant.textColor
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              )),
                        ),
                        index == 3
                            ? SizedBox(
                                width: 10,
                              )
                            : Container(),
                      ],
                    );
                  }),
            ),
            SizedBox(
              height: 30,
            ),
          ]),
        );
      }),
    );
  }
}
