import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/play_db.dart';

import '../models/play_model.dart';

import '../screens/winner_page.dart';
import '../screens/winner_page_flipped.dart';

import '../constants/color_constant.dart';


class Controller extends GetxController {
  ColorConstant allColorConstant = Get.put(ColorConstant());
  PlayDatabase playDatabase = Get.put(PlayDatabase.instance);
  AudioCache audioCache1 = AudioCache(prefix: 'asset/');
  AudioCache audioCache2 = AudioCache(prefix: 'asset/');
  AudioPlayer audioPlayer = AudioPlayer();

  late Rx<Color> player1TextColor;
  late Rx<Color> player2TextColor;
  late Rx<Color> player1BackgroundColor;
  late Rx<Color> player2BackgroundColor;
  late Color player1Color;
  late Color player2Color;

  Future<List<PlayModel>>? playModel;
  late int totalGames;
  late int player1Wins;
  late int player2Wins;
  late int player1Streak;
  late int player2Streak;
  late int player1CurrentStreak;
  late int player2CurrentStreak;
  late int id;
  RxBool isOnHomeScreen = true.obs;

  var player1Name = "";
  var player2Name = "";
  var sizeCounter1 = 0.obs;
  var sizeCounter2 = 0.obs;
  var scoreCounter1 = 0.obs;
  var scoreCounter2 = 0.obs;

  changePlayer1SelectedColor(int number) {
    if (number == 0) {
      player1TextColor.value = allColorConstant.getColorConstants[0].textColor;
      player1BackgroundColor.value =
          allColorConstant.getColorConstants[0].backgroundColor;
      player1Color = Colors.red;
    } else if (number == 1) {
      player1TextColor.value = allColorConstant.getColorConstants[1].textColor;
      player1BackgroundColor.value =
          allColorConstant.getColorConstants[1].backgroundColor;
      player1Color = Colors.green;
    } else if (number == 2) {
      player1TextColor.value = allColorConstant.getColorConstants[2].textColor;
      player1BackgroundColor.value =
          allColorConstant.getColorConstants[2].backgroundColor;
      player1Color = Colors.blue;
    } else {
      player1TextColor.value = allColorConstant.getColorConstants[3].textColor;
      player1BackgroundColor.value =
          allColorConstant.getColorConstants[3].backgroundColor;
      player1Color = Colors.yellow;
    }
  }

  changePlayer2SelectedColor(int number) {
    if (number == 0) {
      player2TextColor.value = allColorConstant.getColorConstants[0].textColor;
      player2BackgroundColor.value =
          allColorConstant.getColorConstants[0].backgroundColor;
      player2Color = Colors.red;
    } else if (number == 1) {
      player2TextColor.value = allColorConstant.getColorConstants[1].textColor;
      player2BackgroundColor.value =
          allColorConstant.getColorConstants[1].backgroundColor;
      player2Color = Colors.green;
    } else if (number == 2) {
      player2TextColor.value = allColorConstant.getColorConstants[2].textColor;
      player2BackgroundColor.value =
          allColorConstant.getColorConstants[2].backgroundColor;
      player2Color = Colors.blue;
    } else {
      player2TextColor.value = allColorConstant.getColorConstants[3].textColor;
      player2BackgroundColor.value =
          allColorConstant.getColorConstants[3].backgroundColor;
      player2Color = Colors.yellow;
    }
  }

  savePlayer1Name(String name) {
    player1Name = name;
  }

  savePlayer2Name(String name) {
    player2Name = name;
  }

  tapCounter1() {
    sizeCounter1.value += 17;
    sizeCounter2.value -= 17;
    scoreCounter1.value++;
    scoreCounter2.value--;
    if (scoreCounter1.value == 15) {
      winner(winner: player1Name, loser: player2Name, player: 1);
    }
  }

  tapCounter2() {
    sizeCounter2.value += 17;
    sizeCounter1.value -= 17;
    scoreCounter2.value++;
    scoreCounter1.value--;
    if (scoreCounter2.value == 15) {
      winner(winner: player2Name, loser: player1Name, player: 2);
    }
  }

  resetCounters() {
    sizeCounter1.value = 0;
    sizeCounter2.value = 0;
    scoreCounter1.value = 0;
    scoreCounter2.value = 0;
  }

  winner({String? winner, String? loser, int? player}) {
    isPlayer1ChangeOrPlayer2Change(player);
    resetCounters();
    Get.off(
      () => player == 1
          ? WinnerPage(
              winner: winner,
              loser: loser,
            )
          : WinnerPageFlipped(winner: winner, loser: loser),
      transition:
          winner == player1Name ? Transition.downToUp : Transition.upToDown,
      duration: Duration(
        milliseconds: 600,
      ),
    );
  }

  onHomeScreen(bool val) {
    isOnHomeScreen.value = val;
  }

  void isPlayer1ChangeOrPlayer2Change(int? player) async {
    if (player == 1) {
      await statsChangeAfterPlayer1Win();
    } else {
      await statsChangeAfterPlayer2Win();
    }
  }

  firstEntry() async {
    final playModel = PlayModel(
        totalGames: 0,
        player1Wins: 0,
        player2Wins: 0,
        player1Streak: 0,
        player2Streak: 0,
        player1CurrentStreak: 0,
        player2CurrentStreak: 0);

    totalGames = 0;
    player1Wins = 0;
    player2Wins = 0;
    player1CurrentStreak = 0;
    player2CurrentStreak = 0;
    player1Streak = 0;
    player2Streak = 0;

    int createdId = await playDatabase.createFirstEntry(playModel);

    id = createdId;
  }

  updateStats(List<PlayModel> playModel) {
    id = playModel.first.id!;
    totalGames = playModel.first.totalGames;
    player1Wins = playModel.first.player1Wins;
    player2Wins = playModel.first.player2Wins;
    player1Streak = playModel.first.player1Streak;
    player2Streak = playModel.first.player2Streak;
    player1CurrentStreak = playModel.first.player1CurrentStreak;
    player2CurrentStreak = playModel.first.player2CurrentStreak;
  }

  Future statsChangeAfterPlayer1Win() async {
    totalGames = totalGames + 1;
    player1Wins = player1Wins + 1;
    player1CurrentStreak = player1CurrentStreak + 1;
    player2CurrentStreak = 0;
    if (player1CurrentStreak > player1Streak) {
      player1Streak = player1CurrentStreak;
    }

    final playModel = PlayModel(
      id: id,
      totalGames: totalGames,
      player1Wins: player1Wins,
      player2Wins: player2Wins,
      player1Streak: player1Streak,
      player2Streak: player2Streak,
      player1CurrentStreak: player1CurrentStreak,
      player2CurrentStreak: player2CurrentStreak,
    );

    await playDatabase.update(playModel);
  }

  Future statsChangeAfterPlayer2Win() async {
    totalGames = totalGames + 1;
    player2Wins = player2Wins + 1;
    player2CurrentStreak = player2CurrentStreak + 1;
    player1CurrentStreak = 0;
    if (player2CurrentStreak > player2Streak) {
      player2Streak = player2CurrentStreak;
    }

    final playModel = PlayModel(
      id: id,
      totalGames: totalGames,
      player1Wins: player1Wins,
      player2Wins: player2Wins,
      player1Streak: player1Streak,
      player2Streak: player2Streak,
      player1CurrentStreak: player1CurrentStreak,
      player2CurrentStreak: player2CurrentStreak,
    );

    await playDatabase.update(playModel);
  }

  getStats() {
    playModel = playDatabase.readAllNotes();
  }

  Future<bool> onBackPressed() async {
    bool shouldReturn = false;
    await Get.defaultDialog<bool?>(
      title: "Alert",
      middleText: "Do you want to really exit the game?",
      onConfirm: () {
        Get.back();
      },
      onCancel: () {
        shouldReturn = true;
        onHomeScreen(true);
        playGameSound(false, isOnHomeScreen.value);
        resetCounters();
        Get.back();
      },
      textConfirm: 'No',
      textCancel: 'Yes',
    );
    return shouldReturn;
  }

  playGameSound(bool isInitialCall, bool shouldPlay) {
    audioCache1.fixedPlayer = audioPlayer;
    if (isInitialCall == true && shouldPlay == true) {
      audioCache1.loop('sound/game_sound.mp3');
    } else if (isInitialCall == false && shouldPlay == true) {
      audioPlayer.resume();
    } else {
      audioPlayer.pause();
    }
  }

  playTimerSound() {
    audioCache2.play('sound/timer.mp3', mode: PlayerMode.LOW_LATENCY);
  }

  playWinningAudio() {
    audioCache2.play('sound/win.mp3', mode: PlayerMode.LOW_LATENCY);
  }

  playImpButtonSound() {
    audioCache2.play('sound/imp_button_sound.mp3',
        mode: PlayerMode.LOW_LATENCY);
  }

  playGenButtonSound() {
    audioCache2.play('sound/gen_button_sound.mp3',
        mode: PlayerMode.LOW_LATENCY);
  }

  playGameButtonSound(int playerIndex) {
    if (playerIndex == 1) {
      audioCache2.play('sound/button_sound_1.mp3',
          mode: PlayerMode.LOW_LATENCY);
    } else {
      audioCache2.play('sound/button_sound_2.mp3',
          mode: PlayerMode.LOW_LATENCY);
    }
  }

  @override
  void onInit() {
    player1TextColor = allColorConstant.getColorConstants[0].textColor.obs;
    player2TextColor = allColorConstant.getColorConstants[1].textColor.obs;
    player1BackgroundColor =
        allColorConstant.getColorConstants[0].backgroundColor.obs;
    player2BackgroundColor =
        allColorConstant.getColorConstants[1].backgroundColor.obs;
    player1Color = Colors.red;
    player2Color = Colors.green;

    playGameSound(true, isOnHomeScreen.value);
    getStats();
    super.onInit();
  }

  @override
  void onClose() {
    audioPlayer.pause();
    playDatabase.close();
    super.onClose();
  }
}
